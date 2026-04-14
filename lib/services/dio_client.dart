import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'token_storage_service.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;
  final TokenStorageService _tokenStorage = TokenStorageService();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    final baseUrl = dotenv.env['BASE_URL'] ?? 'http://localhost:3000/api/v1';

    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await _tokenStorage.getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          // Check if error is 401 Unauthorized
          if (error.response?.statusCode == 401) {
            final refreshToken = await _tokenStorage.getRefreshToken();

            if (refreshToken != null) {
              try {
                // Use a standard dio instance to avoid recursive retries from the interceptor
                final refreshDio = Dio(BaseOptions(baseUrl: dio.options.baseUrl));

                final response = await refreshDio.post('/auth/refresh-token', data: {
                  'refresh_token': refreshToken,
                });

                if (response.statusCode == 200 && response.data != null) {
                  final newAccessToken = response.data['access_token'];
                  final newRefreshToken = response.data['refresh_token'];

                  if (newAccessToken != null) {
                    await _tokenStorage.saveTokens(
                      accessToken: newAccessToken,
                      refreshToken: newRefreshToken ?? refreshToken,
                    );

                    // Update header and retry the original request
                    final options = error.requestOptions;
                    options.headers['Authorization'] = 'Bearer $newAccessToken';

                    final retryResponse = await dio.fetch(options);
                    return handler.resolve(retryResponse);
                  }
                }
              } on DioException catch (_) {
                // Refresh token failed, clear tokens and let the error pass through
                await _tokenStorage.clearTokens();
              }
            } else {
              // No refresh token available, clear tokens
              await _tokenStorage.clearTokens();
            }
          }
          return handler.next(error);
        },
      ),
    );
  }
}
