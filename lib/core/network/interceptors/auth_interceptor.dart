import 'package:dio/dio.dart';
import '../../storage/secure_storage.dart';

/// Interceptor to automatically add Bearer authorization headers and handle token refreshing.
class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage;

  // Custom header key (e.g. bypass token append for public APIs)
  static const String skipAuthHeaderKey = 'skip_auth';

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // If the request contains skipAuthHeaderKey, remove it and skip token inject.
    if (options.headers.containsKey(skipAuthHeaderKey)) {
      options.headers.remove(skipAuthHeaderKey);
      return handler.next(options);
    }

    final token = await _storage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Default API headers
    options.headers['Accept'] = 'application/json';

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Intercept 401 Unauthorized errors to perform dynamic JWT refresh.
    if (err.response?.statusCode == 401) {
      final refreshToken = await _storage.getRefreshToken();

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          // TODO: Implement actual refresh API endpoint call.
          // Example:
          // final newTokens = await _refreshApiCall(refreshToken);
          // await _storage.saveAccessToken(newTokens.accessToken);
          // await _storage.saveRefreshToken(newTokens.refreshToken);
          //
          // Then retry original request:
          // final options = err.requestOptions;
          // options.headers['Authorization'] = 'Bearer ${newTokens.accessToken}';
          // final dio = Dio(); // or reference shared Dio
          // final response = await dio.fetch(options);
          // return handler.resolve(response);
        } catch (e) {
          // Token refresh failed, user session is fully expired. Clear storage.
          await _storage.clearAll();
          // TODO: Trigger sign out routing event.
        }
      }
    }

    return handler.next(err);
  }
}
