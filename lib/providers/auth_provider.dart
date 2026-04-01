import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_business_automation_crm_app/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class AuthNotifier extends StateNotifier<bool> {
  final ApiService _apiService;

  AuthNotifier(this._apiService) : super(false); // Initial state is false (not loading)

  Future<bool> login(String email, String password) async {
    state = true;
    try {
      await _apiService.login(email, password);
      return true;
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<bool> signup(Map<String, String> data) async {
    state = true;
    try {
      await _apiService.signup(data);
      return true;
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    state = true;
    try {
      await _apiService.verifyOtp(otp);
      return true;
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    state = true;
    try {
      await _apiService.forgotPassword(email);
      return true;
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return AuthNotifier(apiService);
});
