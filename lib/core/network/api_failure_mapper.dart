import 'package:dio/dio.dart';
import 'package:sheshield/core/error/app_failure.dart';

const _offlineMessage = 'No internet connection. Please try again.';
const _genericMessage = 'Something went wrong. Please try again.';

/// Turns a transport error into the message a person should read. The
/// backend's own `{ "error": "..." }` text wins when present.
AppFailure mapDioExceptionToFailure(DioException exception) {
  final responseBody = exception.response?.data;
  final serverMessage = responseBody is Map ? responseBody['error'] : null;

  return AppFailure(
    message: serverMessage is String ? serverMessage : _fallbackMessage(exception),
    unauthorized: exception.response?.statusCode == 401,
    statusCode: exception.response?.statusCode,
  );
}

String _fallbackMessage(DioException exception) {
  final isOffline = exception.type == DioExceptionType.connectionError ||
      exception.type == DioExceptionType.connectionTimeout;
  return isOffline ? _offlineMessage : _genericMessage;
}

/// Runs [request] and rethrows any [DioException] as an [AppFailure], so
/// datasources never repeat try/catch blocks.
Future<T> guardApiCall<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (exception) {
    throw mapDioExceptionToFailure(exception);
  }
}
