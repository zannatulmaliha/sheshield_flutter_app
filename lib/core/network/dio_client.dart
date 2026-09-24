import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Single Dio instance for the whole app.
///
/// Attaches the stored JWT to every outgoing request automatically.
/// Clears the JWT on a normal 401 response, but preserves the JWT when
/// an admin request explicitly sets `skipAuth401Clear` to true.
class DioClient {
  DioClient(String baseUrl, this._storage) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: _tokenKey);

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
        onError: (error, handler) async {
          final statusCode = error.response?.statusCode;

          // Do not remove the normal JWT when an admin request receives
          // a 401 because admin authentication uses X-Admin-Key separately.
          final skipAuth401Clear =
              error.requestOptions.extra['skipAuth401Clear'] == true;

          if (statusCode == 401 && !skipAuth401Clear) {
            await _storage.delete(key: _tokenKey);
          }

          handler.next(error);
        },
      ),
    );
  }

  static const String _tokenKey = 'sheshield_jwt';

  final FlutterSecureStorage _storage;

  late final Dio dio;

  Future<void> saveToken(String token) {
    return _storage.write(
      key: _tokenKey,
      value: token,
    );
  }

  Future<void> clearToken() {
    return _storage.delete(
      key: _tokenKey,
    );
  }

  Future<String?> readToken() {
    return _storage.read(
      key: _tokenKey,
    );
  }
}
