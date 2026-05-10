// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:whatsapp_business_automation_crm_app/core/network_exception_handler.dart';
import 'package:whatsapp_business_automation_crm_app/models/user_model.dart';
import 'package:whatsapp_business_automation_crm_app/services/dio_client.dart';
import 'package:whatsapp_business_automation_crm_app/services/token_storage_service.dart';

class ApiService {
  final Dio _dio = DioClient().dio;
  final TokenStorageService _tokenStorage = TokenStorageService();

  // ---------------------------------------------------------------------------
  // Auth: Sign Up
  // POST /auth/sign-up
  // ---------------------------------------------------------------------------
  Future<void> signUp(Map<String, dynamic> data) async {
    try {
      //print("Sign Up Data: ${data}");
      await _dio.post('/auth/sign-up', data: data);
    } on DioException catch (e) {
      throw NetworkExceptionHandler.handleApiException(e);
      //throw Exception(_extractMessage(e, 'Sign up failed'));
    }
  }

  // ---------------------------------------------------------------------------
  // Auth: Sign In
  // POST /auth/sign-in
  // ---------------------------------------------------------------------------
  Future<void> signIn(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/sign-in',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200 && response.data != null) {
        final accessToken = response.data['data']['accessToken'] ?? "";
        final refreshToken = response.data['data']['refreshToken'] ?? "";

        if (accessToken != null && refreshToken != null) {
          await _tokenStorage.saveTokens(
            accessToken: accessToken,
            refreshToken: refreshToken,
          );
        }
      } else {
        throw Exception('Failed to sign in');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw UnverifiedEmailException(
          _extractMessage(
            e,
            'Email not verified. Please verify your email before signing in.',
          ),
        );
      }

      throw NetworkExceptionHandler.handleApiException(e);

      // throw Exception(_extractMessage(e, 'Invalid credentials'));
    }
  }

  // ---------------------------------------------------------------------------
  // Auth: Verify Email (after signup OTP)
  // POST /auth/verify-email
  // ---------------------------------------------------------------------------
  Future<void> verifyEmail(String email, String code) async {
    try {
      await _dio.post(
        '/auth/verify-email',
        data: {'email': email, 'otp': code},
      );
    } on DioException catch (e) {
      throw NetworkExceptionHandler.handleApiException(e);
      // throw Exception(
      //   _extractMessage(e, 'Invalid or expired verification code'),
      // );
    }
  }

  // ---------------------------------------------------------------------------
  // Auth: Resend Verification Code
  // POST /auth/resend-verification
  // ---------------------------------------------------------------------------
  Future<void> resendVerificationCode(String email) async {
    try {
      await _dio.post('/auth/resend-verification', data: {'email': email});
    } on DioException catch (e) {
      throw NetworkExceptionHandler.handleApiException(e);
      //throw Exception(_extractMessage(e, 'Failed to resend verification code'));
    }
  }

  // ---------------------------------------------------------------------------
  // Auth: Request Password Reset
  // POST /auth/request-password-reset
  // ---------------------------------------------------------------------------
  Future<void> requestPasswordReset(String email) async {
    try {
      await _dio.post('/auth/request-password-reset', data: {'email': email});
    } on DioException catch (e) {
      throw NetworkExceptionHandler.handleApiException(e);
      //throw Exception(_extractMessage(e, 'Failed to request password reset'));
    }
  }

  // ---------------------------------------------------------------------------
  // Auth: Verify Password Reset OTP
  // POST /auth/verify-password-reset
  // ---------------------------------------------------------------------------
  Future<void> verifyPasswordReset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      await _dio.post(
        '/auth/verify-password-reset',
        data: {'email': email, 'code': code, 'newPassword': newPassword},
      );
    } on DioException catch (e) {
      throw NetworkExceptionHandler.handleApiException(e);
      //throw Exception(_extractMessage(e, 'Invalid or expired reset code'));
    }
  }

  // ---------------------------------------------------------------------------
  // Auth: Sign Out
  // POST /auth/sign-out
  // ---------------------------------------------------------------------------
  Future<void> signOut() async {
    try {
      await _dio.post('/auth/sign-out');
    } on DioException catch (e) {
      throw NetworkExceptionHandler.handleApiException(e);
    } finally {
      // Always clear tokens locally, even if the server call fails.
      await _tokenStorage.clearTokens();
    }
  }

  // ---------------------------------------------------------------------------
  // Users: Get Current User
  // GET /users/
  // ---------------------------------------------------------------------------
  Future<UserModel> getUser() async {
    try {
      final response = await _dio.get('/users/');
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return UserModel.fromJson(data);
      }
      throw Failure('Unexpected response format');
    } on DioException catch (e) {
      throw NetworkExceptionHandler.handleApiException(e);
    }
  }

  // ---------------------------------------------------------------------------
  // Users: Update Current User
  // PUT /users/
  // ---------------------------------------------------------------------------
  Future<UserModel> updateUser(Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/users/', data: data);
      final responseData = response.data;
      if (responseData is Map<String, dynamic>) {
        return UserModel.fromJson(responseData);
      }
      throw Failure('Unexpected response format');
    } on DioException catch (e) {
      throw NetworkExceptionHandler.handleApiException(e);
    }
  }

  // ---------------------------------------------------------------------------
  // Users: Delete Current User
  // DELETE /users/
  // ---------------------------------------------------------------------------
  Future<void> deleteUser() async {
    try {
      await _dio.delete('/users/');
    } on DioException catch (e) {
      throw NetworkExceptionHandler.handleApiException(e);
    } finally {
      await _tokenStorage.clearTokens();
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------
  String _extractMessage(DioException e, String fallback) {
    final data = e.response?.data;
    if (data is Map) {
      return data['message']?.toString() ?? fallback;
    }
    return e.message ?? fallback;
  }
}

/// Thrown when a sign-in attempt is made for an unverified email (HTTP 403).
class UnverifiedEmailException implements Exception {
  final String message;
  const UnverifiedEmailException(this.message);

  @override
  String toString() => message;
}
