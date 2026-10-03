import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sheshield/core/network/auth_token_store.dart';
import 'package:sheshield/core/network/interceptors/auth_interceptor.dart';

/// The one configured Dio instance for the app. Base URL and logging come
/// from the flavor's `AppConfig`, never from constants in this file.
class DioClient {
  DioClient({
    required String baseUrl,
    required AuthTokenStore tokenStore,
    required bool enableLogging,
  }) : _tokenStore = tokenStore {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    )..interceptors.add(AuthInterceptor(tokenStore));

    if (enableLogging) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => debugPrint(obj.toString()),
        ),
      );
    }
  }

  final AuthTokenStore _tokenStore;

  late final Dio dio;

  Future<void> saveToken(String token) => _tokenStore.saveAuthToken(token);

  Future<void> clearToken() => _tokenStore.clearAuthToken();

  Future<String?> readToken() => _tokenStore.readAuthToken();
}
