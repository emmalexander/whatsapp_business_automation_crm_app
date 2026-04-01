import 'package:flutter/material.dart';
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
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ToastUtil.showError(context, 'Passwords do not match');
      return;
    }

    try {
      await ref.read(authProvider.notifier).signup({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
      });

      if (mounted) {
        ToastUtil.showSuccess(context, 'Sign up successful! Please verify your email.');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OtpScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ToastUtil.showError(context, e.toString());
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
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                const SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: 'First Name',
                        hintText: 'John',
                        controller: _firstNameController,
                        validator: (value) =>
                            value != null && value.isNotEmpty ? null : 'Required',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Last Name',
                        hintText: 'Doe',
                        controller: _lastNameController,
                        validator: (value) =>
                            value != null && value.isNotEmpty ? null : 'Required',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  labelText: 'Email Address',
                  hintText: 'john.doe@example.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : 'Please enter your email',
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  labelText: 'Phone Number',
                  hintText: '+1 234 567 8900',
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : 'Please enter your phone number',
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'Create a password',
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : 'Please enter a password',
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  obscureText: true,
                  controller: _confirmPasswordController,
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : 'Please confirm your password',
                ),
                const SizedBox(height: 48),
                LoadingButton(
                  text: 'Sign Up',
                  isLoading: isLoading,
                  onPressed: _handleSignup,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
