import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Single Dio instance for the whole app. Attaches the stored JWT to
/// every outgoing request automatically, and clears it on a 401 so a
/// stale/expired token doesn't cause silent repeated failures.
class DioClient {
  DioClient(String baseUrl, this._storage) {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: _tokenKey);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _storage.delete(key: _tokenKey);
          }
          handler.next(error);
        },
      ),
    );
  }

  static const _tokenKey = 'sheshield_jwt';

  final FlutterSecureStorage _storage;
  late final Dio dio;

  Future<void> saveToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  Future<void> clearToken() => _storage.delete(key: _tokenKey);

  Future<String?> readToken() => _storage.read(key: _tokenKey);
}
