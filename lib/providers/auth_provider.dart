import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart'
    show StateNotifier, StateNotifierProvider;
import 'package:whatsapp_business_automation_crm_app/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// ---------------------------------------------------------------------------
// AuthNotifier
// State: bool — true while an async auth operation is in progress
// ---------------------------------------------------------------------------
class AuthNotifier extends StateNotifier<bool> {
  final ApiService _apiService;

  AuthNotifier(this._apiService) : super(false);

  // Sign Up
  Future<void> signUp(Map<String, dynamic> data) async {
    state = true;
    try {
      await _apiService.signUp(data);
    } finally {
      state = false;
    }
  }

  // Sign In
  Future<void> signIn(String email, String password) async {
    state = true;
    try {
      await _apiService.signIn(email, password);
    } finally {
      state = false;
    }
  }

  // Verify Email OTP (after signup)
  Future<void> verifyEmail(String email, String code) async {
    state = true;
    try {
      await _apiService.verifyEmail(email, code);
    } finally {
      state = false;
    }
  }

  // Resend Verification Code
  Future<void> resendVerificationCode(String email) async {
    state = true;
    try {
      await _apiService.resendVerificationCode(email);
    } finally {
      state = false;
    }
  }

  // Request Password Reset (sends OTP)
  Future<void> requestPasswordReset(String email) async {
    state = true;
    try {
      await _apiService.requestPasswordReset(email);
    } finally {
      state = false;
    }
  }

  // Verify Password Reset OTP and set new password
  Future<void> verifyPasswordReset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    state = true;
    try {
      await _apiService.verifyPasswordReset(
        email: email,
        code: code,
        newPassword: newPassword,
      );
    } finally {
      state = false;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return AuthNotifier(apiService);
});
