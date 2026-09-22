import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';
import '../../domain/entities/sos_alert.dart';
import '../../domain/repositories/i_sos_repository.dart';

/// The only file that talks to the Go backend's /api/v1/alerts
/// endpoint (internal/alert/handler.go). There is exactly one route:
/// creating an alert -- no list, no cancel.
class SosApiDataSource {
  SosApiDataSource(this._client);
  final DioClient _client;
  static const _basePath = '/alerts';

  /// POST /api/v1/alerts
  /// body: { latitude, longitude, accuracyMeters, notifiedByDevice }
  /// -> { "data": { id, createdAt, deliveries: [...] } }
  /// The server texts every contact not already in [notifiedByDevice]
  /// (via its SMS provider, or logs the message in dev when no
  /// provider is configured) and reports the outcome per contact --
  /// this call only has to persist the alert and return that report.
  Future<SosAlert> send({
    required double latitude,
    required double longitude,
    double? accuracyMeters,
    List<String> notifiedByDevice = const [],
  }) async {
    try {
      final res = await _client.dio.post(_basePath, data: {
        'latitude': latitude,
        'longitude': longitude,
        'accuracyMeters': accuracyMeters,
        'notifiedByDevice': notifiedByDevice,
      });
      return SosAlert.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  SosFailure _fail(DioException e) {
    final data = e.response?.data;
    final message = (data is Map && data['error'] is String)
        ? data['error'] as String
        : (e.type == DioExceptionType.connectionError ||
                e.type == DioExceptionType.connectionTimeout
            ? 'No internet connection. Please try again.'
            : 'Something went wrong. Please try again.');
    return SosFailure(message, unauthorized: e.response?.statusCode == 401);
  }
}