import 'package:dio/dio.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/admin/data/datasources/admin_key_store.dart';

/// Dio wrapper for `/api/v1/admin/*`, authenticated by `X-Admin-Key`.
///
/// It uses its OWN Dio (same base URL, no interceptors) instead of the
/// shared one: the shared client attaches the user's Bearer token and
/// deletes it on any 401, so a mistyped admin key would otherwise log the
/// person out of the main app.
class AdminApiClient {
  AdminApiClient(DioClient dioClient, this._keyStore)
      : dio = Dio(
          BaseOptions(
            baseUrl: dioClient.dio.options.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );

  final Dio dio;
  final AdminKeyStore _keyStore;

  /// Request options carrying the stored key; [base] is merged in.
  Future<Options> authorizedOptions([Options? base]) async {
    final key = await _keyStore.readAdminKey();
    return (base ?? Options()).copyWith(headers: {'X-Admin-Key': key ?? ''});
  }

  /// Like `guardApiCall`, plus the two admin-specific messages.
  Future<T> guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (exception) {
      throw _mapAdminException(exception);
    }
  }

  AppFailure _mapAdminException(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final responseBody = exception.response?.data;

    if (statusCode == 401) {
      return const AppFailure(message: 'Invalid admin key.', unauthorized: true);
    }
    if (statusCode == 404 && responseBody is! Map) {
      return const AppFailure(message: 'Admin access is not enabled on this server.');
    }
    return mapDioExceptionToFailure(exception);
  }
}
