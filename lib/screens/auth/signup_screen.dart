import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_business_automation_crm_app/providers/auth_provider.dart';
import 'package:whatsapp_business_automation_crm_app/screens/auth/otp_screen.dart';
import 'package:whatsapp_business_automation_crm_app/theme.dart';
import 'package:whatsapp_business_automation_crm_app/utils/toast_util.dart';
import 'package:whatsapp_business_automation_crm_app/widgets/custom_text_field.dart';
import 'package:whatsapp_business_automation_crm_app/widgets/loading_button.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Country code state — defaults to the device locale country.
  late Country _selectedCountry;

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    // Use the device locale to pick a sensible default country.
    final localeCountryCode =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode ?? 'NG';
    _selectedCountry = _countryFromCode(localeCountryCode);
  }

  /// Returns a [Country] matching [isoCode], falling back to Nigeria.
  Country _countryFromCode(String isoCode) {
    try {
      return CountryParser.parseCountryCode(isoCode);
    } catch (_) {
      return CountryParser.parseCountryCode('NG');
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ── Validators ──────────────────────────────────────────────────────────────

  String? _validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value.trim())) {
      return '$fieldName contains invalid characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email address is required';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    final digits = value.trim().replaceAll(' ', '');
    if (!RegExp(r'^\d{6,14}$').hasMatch(digits)) {
      return 'Enter a valid phone number (digits only)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
      return 'Must contain at least one number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  // ── Signup handler ───────────────────────────────────────────────────────────

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    // Combine country dial code + subscriber number
    final phoneNumber =
        '+${_selectedCountry.phoneCode}${_phoneController.text.trim().replaceAll(' ', '')}';

    final data = <String, dynamic>{
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phoneNumber': phoneNumber,
      'password': _passwordController.text,
    };

    if (_middleNameController.text.trim().isNotEmpty) {
      data['middleName'] = _middleNameController.text.trim();
    }

    try {
      await ref.read(authProvider.notifier).signUp(data);
      if (mounted) {
        ToastUtil.showSuccess(
          context,
          'Account created! Check your email for your verification code.',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              email: _emailController.text.trim(),
              mode: OtpMode.emailVerification,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ToastUtil.showError(
            context, e.toString().replaceFirst('Exception: ', ''));
      }
    }
  }

  // ── Country picker ───────────────────────────────────────────────────────────

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: [_selectedCountry.countryCode],
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        inputDecoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.textGrey),
          hintText: 'Search country…',
          hintStyle: const TextStyle(color: AppTheme.textLightGrey),
          filled: true,
          fillColor: AppTheme.background,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                const BorderSide(color: AppTheme.primaryGreen, width: 1.5),
          ),
        ),
        searchTextStyle: const TextStyle(color: AppTheme.textDark),
        flagSize: 24,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(
          color: AppTheme.textDark,
          fontSize: 14,
        ),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.72,
      ),
      onSelect: (Country country) {
        setState(() => _selectedCountry = country);
      },
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppTheme.cardColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppTheme.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Header ───────────────────────────────────────────────────
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Join LedgeCRM today',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textGrey,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),

                // ── First Name & Last Name ────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: 'First Name',
                        hintText: 'John',
                        controller: _firstNameController,
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => _validateName(v, 'First name'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Last Name',
                        hintText: 'Doe',
                        controller: _lastNameController,
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => _validateName(v, 'Last name'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Middle Name (optional) ────────────────────────────────────
                CustomTextField(
                  labelText: 'Middle Name (Optional)',
                  hintText: 'James',
                  controller: _middleNameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return null;
                    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value.trim())) {
                      return 'Middle name contains invalid characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // ── Phone Number ─────────────────────────────────────────────
                _PhoneField(
                  selectedCountry: _selectedCountry,
                  controller: _phoneController,
                  onPickCountry: _openCountryPicker,
                  validator: _validatePhone,
                ),
                const SizedBox(height: 20),

                // ── Email ─────────────────────────────────────────────────────
                CustomTextField(
                  labelText: 'Email Address',
                  hintText: 'john.doe@example.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),

                // ── Password ──────────────────────────────────────────────────
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Min. 8 chars, 1 uppercase, 1 number',
                  obscureText: !_showPassword,
                  controller: _passwordController,
                  validator: _validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: AppTheme.textGrey,
                    ),
                    onPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                  ),
                ),
                const SizedBox(height: 20),

                // ── Confirm Password ──────────────────────────────────────────
                CustomTextField(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  obscureText: !_showConfirmPassword,
                  controller: _confirmPasswordController,
                  validator: _validateConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showConfirmPassword
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: AppTheme.textGrey,
                    ),
                    onPressed: () => setState(
                        () => _showConfirmPassword = !_showConfirmPassword),
                  ),
                ),
                const SizedBox(height: 36),

                LoadingButton(
                  text: 'Create Account',
                  isLoading: isLoading,
                  onPressed: _handleSignup,
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Sign In',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Phone field widget ────────────────────────────────────────────────────────

class _PhoneField extends StatelessWidget {
  final Country selectedCountry;
  final TextEditingController controller;
  final VoidCallback onPickCountry;
  final String? Function(String?)? validator;

  const _PhoneField({
    required this.selectedCountry,
    required this.controller,
    required this.onPickCountry,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Country selector button ─────────────────────────────────────
            _CountryDialButton(
              country: selectedCountry,
              onTap: onPickCountry,
            ),
            const SizedBox(width: 10),

            // ── Number input ────────────────────────────────────────────────
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                style: Theme.of(context).textTheme.bodyLarge,
                validator: validator,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d\s]')),
                ],
                decoration: InputDecoration(
                  hintText: 'e.g. 8012345678',
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textLightGrey,
                      ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
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
                    borderSide: const BorderSide(
                        color: AppTheme.primaryGreen, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.redAccent),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Country dial-code button ──────────────────────────────────────────────────

class _CountryDialButton extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const _CountryDialButton({required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Emoji flag
            Text(
              country.flagEmoji,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(width: 6),
            Text(
              '+${country.phoneCode}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded,
                size: 18, color: AppTheme.textGrey),
          ],
        ),
      ),
    );
  }
}
