import 'package:dio/dio.dart';
import 'package:whatsapp_business_automation_crm_app/services/dio_client.dart';
import 'package:whatsapp_business_automation_crm_app/services/token_storage_service.dart';

class ApiService {
  final Dio _dio = DioClient().dio;
  final TokenStorageService _tokenStorage = TokenStorageService();

  Future<void> login(String email, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 && response.data != null) {
        final accessToken = response.data['access_token'];
        final refreshToken = response.data['refresh_token'];

        if (accessToken != null && refreshToken != null) {
          await _tokenStorage.saveTokens(
            accessToken: accessToken,
            refreshToken: refreshToken,
          );
        }
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Invalid credentials');
      } else {
        throw Exception(e.message ?? 'An error occurred during login');
      }
    }
  }

  Future<void> signup(Map<String, String> data) async {
    try {
      await _dio.post('/auth/signup', data: data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Signup failed');
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      await _dio.post('/auth/verify-otp', data: {'otp': otp});
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Invalid OTP');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _dio.post('/auth/forgot-password', data: {'email': email});
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to request password reset');
    }
  }
}
