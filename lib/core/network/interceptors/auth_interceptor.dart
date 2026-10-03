import 'package:dio/dio.dart';
import 'package:sheshield/core/network/auth_token_store.dart';

/// Marks a request whose 401 must NOT sign the user out (admin calls use
/// a separate `X-Admin-Key`, so a wrong key is not a lost session).
const skipSessionClearOnUnauthorized = 'skipAuth401Clear';

/// Adds the stored JWT to every request and drops it on a real 401.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStore);

  final AuthTokenStore _tokenStore;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStore.readAuthToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final isUnauthorized = error.response?.statusCode == 401;
    final shouldKeepSession =
        error.requestOptions.extra[skipSessionClearOnUnauthorized] == true;

    if (isUnauthorized && !shouldKeepSession) await _tokenStore.clearAuthToken();
    handler.next(error);
  }
}
