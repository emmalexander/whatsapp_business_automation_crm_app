import 'package:flutter_riverpod/legacy.dart'
    show StateNotifier, StateNotifierProvider;
import 'package:whatsapp_business_automation_crm_app/models/user_model.dart';
import 'package:whatsapp_business_automation_crm_app/providers/auth_provider.dart';
import 'package:whatsapp_business_automation_crm_app/services/api_service.dart';

// ---------------------------------------------------------------------------
// UserState — wraps UserModel? + isLoading + error
// ---------------------------------------------------------------------------
class UserState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const UserState({this.user, this.isLoading = false, this.error});

  UserState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return UserState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

// ---------------------------------------------------------------------------
// UserNotifier
// ---------------------------------------------------------------------------
class UserNotifier extends StateNotifier<UserState> {
  final ApiService _apiService;

  UserNotifier(this._apiService) : super(const UserState());

  // ── Fetch current user ───────────────────────────────────────────────────
  Future<void> getUser() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _apiService.getUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  // ── Update current user ──────────────────────────────────────────────────
  Future<void> updateUser(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final updatedUser = await _apiService.updateUser(data);
      state = state.copyWith(user: updatedUser, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  // ── Delete current user ──────────────────────────────────────────────────
  Future<void> deleteUser() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _apiService.deleteUser();
      state = const UserState(); // clear everything on success
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  // ── Sign out ─────────────────────────────────────────────────────────────
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _apiService.signOut();
    } catch (_) {
      // Swallow server-side error — tokens are already cleared by ApiService.
    } finally {
      state = const UserState(); // clear user data regardless
    }
  }

  /// Clear user state (e.g. on logout from another provider).
  void clearUser() {
    state = const UserState();
  }
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return UserNotifier(apiService);
});
