import 'package:dio/dio.dart';
import 'package:flutter_riverpod/legacy.dart'
    show StateNotifier, StateNotifierProvider;
import 'package:whatsapp_business_automation_crm_app/providers/auth_provider.dart';
import 'package:whatsapp_business_automation_crm_app/services/api_service.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

enum ChatUploadStatus { idle, uploading, success, error }

class ChatUploadState {
  final ChatUploadStatus status;
  final String? filePath;
  final String? errorMessage;
  final double progress; // 0.0 – 1.0

  const ChatUploadState({
    this.status = ChatUploadStatus.idle,
    this.filePath,
    this.errorMessage,
    this.progress = 0.0,
  });

  bool get isLoading => status == ChatUploadStatus.uploading;

  ChatUploadState copyWith({
    ChatUploadStatus? status,
    String? filePath,
    String? errorMessage,
    double? progress,
  }) {
    return ChatUploadState(
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      errorMessage: errorMessage ?? this.errorMessage,
      progress: progress ?? this.progress,
    );
  }
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

class ChatUploadNotifier extends StateNotifier<ChatUploadState> {
  final ApiService _apiService;
  CancelToken? _cancelToken;

  ChatUploadNotifier(this._apiService) : super(const ChatUploadState());

  Future<void> upload({
    required String filePath,
    required String name,
    required String phoneNumber,
  }) async {
    if (state.status == ChatUploadStatus.uploading) return;

    state = ChatUploadState(
      status: ChatUploadStatus.uploading,
      filePath: filePath,
      progress: 0.0,
    );

    _cancelToken = CancelToken();

    try {
      await _apiService.uploadChatExport(
        filePath,
        name: name,
        phoneNumber: phoneNumber,
        cancelToken: _cancelToken,
        onProgress: (sent, total) {
          if (total > 0) {
            state = state.copyWith(progress: sent / total);
          }
        },
      );

      state = state.copyWith(
        status: ChatUploadStatus.success,
        progress: 1.0,
      );
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        state = const ChatUploadState();
        return;
      }
      state = state.copyWith(
        status: ChatUploadStatus.error,
        errorMessage: e.toString(),
      );
    } finally {
      _cancelToken = null;
    }
  }

  void cancel() {
    _cancelToken?.cancel('User cancelled upload');
    state = const ChatUploadState();
  }

  void reset() {
    state = const ChatUploadState();
  }
}

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

final chatUploadProvider =
    StateNotifierProvider<ChatUploadNotifier, ChatUploadState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return ChatUploadNotifier(apiService);
});
