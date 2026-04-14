import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_business_automation_crm_app/providers/auth_provider.dart';
import 'package:whatsapp_business_automation_crm_app/screens/auth/login_screen.dart';
import 'package:whatsapp_business_automation_crm_app/screens/auth/reset_password_screen.dart';
import 'package:whatsapp_business_automation_crm_app/theme.dart';
import 'package:whatsapp_business_automation_crm_app/utils/toast_util.dart';
import 'package:whatsapp_business_automation_crm_app/widgets/loading_button.dart';

/// Controls what this OTP screen is verifying.
enum OtpMode { emailVerification, passwordReset }

class OtpScreen extends ConsumerStatefulWidget {
  final String email;
  final OtpMode mode;

  const OtpScreen({
    super.key,
    required this.email,
    required this.mode,
  });

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  // Each digit gets its own controller + focus node
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  // Resend cooldown — 3 minutes
  static const int _cooldownSeconds = 180;
  int _remainingSeconds = 0;
  Timer? _cooldownTimer;
  bool _hasResentOnce = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _cooldownTimer?.cancel();
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  String get _title =>
      widget.mode == OtpMode.emailVerification ? 'Verify Your Email' : 'Reset Password';

  String get _subtitle =>
      widget.mode == OtpMode.emailVerification
          ? 'We sent a 6-digit code to ${widget.email}.\nPlease enter it below to verify your account.'
          : 'We sent a 6-digit reset code to ${widget.email}.\nEnter it below to continue.';

  // ── OTP digit input ──────────────────────────────────────────────────────
  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  // ── Resend ───────────────────────────────────────────────────────────────
  void _startCooldown() {
    setState(() {
      _remainingSeconds = _cooldownSeconds;
      _hasResentOnce = true;
    });
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        if (mounted) setState(() => _remainingSeconds = 0);
      } else {
        if (mounted) setState(() => _remainingSeconds--);
      }
    });
  }

  String get _cooldownLabel {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Future<void> _handleResend() async {
    try {
      await ref
          .read(authProvider.notifier)
          .resendVerificationCode(widget.email);
      if (mounted) {
        ToastUtil.showSuccess(context, 'Verification code resent to ${widget.email}.');
        _startCooldown();
      }
    } catch (e) {
      if (mounted) {
        ToastUtil.showError(context, e.toString().replaceFirst('Exception: ', ''));
      }
    }
  }

  // ── Submit ───────────────────────────────────────────────────────────────
  Future<void> _handleVerify() async {
    if (_otp.length < 6) {
      ToastUtil.showError(context, 'Please enter the 6-digit code.');
      return;
    }

    try {
      if (widget.mode == OtpMode.emailVerification) {
        await ref
            .read(authProvider.notifier)
            .verifyEmail(widget.email, _otp);
        if (mounted) {
          ToastUtil.showSuccess(
              context, 'Email verified successfully! Please sign in.');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      } else {
        // Navigate to ResetPasswordScreen passing email + code
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ResetPasswordScreen(
                email: widget.email,
                code: _otp,
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ToastUtil.showError(
            context, e.toString().replaceFirst('Exception: ', ''));
      }
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider);
    final canResend = !_hasResentOnce || _remainingSeconds == 0;

    return Scaffold(
      backgroundColor: AppTheme.cardColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_rounded,
                  color: AppTheme.primaryGreen,
                  size: 36,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                _title,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                _subtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textGrey,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // OTP digit boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) => _buildDigitBox(index)),
              ),
              const SizedBox(height: 40),

              // Verify button
              LoadingButton(
                text: widget.mode == OtpMode.emailVerification
                    ? 'Verify Email'
                    : 'Continue',
                isLoading: isLoading,
                onPressed: _handleVerify,
              ),
              const SizedBox(height: 28),

              // Resend row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive a code? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (_hasResentOnce && _remainingSeconds > 0) ...[
                    Text(
                      'Resend in $_cooldownLabel',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textGrey,
                            fontWeight: FontWeight.w600,
                          ),
                    )
                  ] else ...[
                    GestureDetector(
                      onTap: canResend && !isLoading ? _handleResend : null,
                      child: Text(
                        'Resend',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: canResend
                                  ? AppTheme.primaryGreen
                                  : AppTheme.textGrey,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDigitBox(int index) {
    return SizedBox(
      width: 48,
      height: 56,
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) => _onKeyEvent(index, event),
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
          onChanged: (v) => _onDigitChanged(index, v),
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.zero,
            filled: true,
            fillColor: AppTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.primaryGreen, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
