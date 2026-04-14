import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_business_automation_crm_app/providers/auth_provider.dart';
import 'package:whatsapp_business_automation_crm_app/screens/auth/otp_screen.dart';
import 'package:whatsapp_business_automation_crm_app/theme.dart';
import 'package:whatsapp_business_automation_crm_app/utils/toast_util.dart';
import 'package:whatsapp_business_automation_crm_app/widgets/custom_text_field.dart';
import 'package:whatsapp_business_automation_crm_app/widgets/loading_button.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email address is required';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  Future<void> _handleRequestReset() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await ref
          .read(authProvider.notifier)
          .requestPasswordReset(_emailController.text.trim());

      if (mounted) {
        ToastUtil.showSuccess(
          context,
          'A reset code has been sent to ${_emailController.text.trim()}.',
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              email: _emailController.text.trim(),
              mode: OtpMode.passwordReset,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ToastUtil.showError(context, e.toString().replaceFirst('Exception: ', ''));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider);

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_reset_rounded,
                      color: AppTheme.primaryGreen,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "No worries! Enter your email address and we'll send you a 6-digit reset code.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textGrey,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                CustomTextField(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 32),

                LoadingButton(
                  text: 'Send Reset Code',
                  isLoading: isLoading,
                  onPressed: _handleRequestReset,
                ),
                const SizedBox(height: 28),

                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_rounded,
                            size: 16, color: AppTheme.textGrey),
                        const SizedBox(width: 4),
                        Text(
                          'Back to Sign In',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textGrey,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
