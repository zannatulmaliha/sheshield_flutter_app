import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';
import '../../domain/entities/alert_summary.dart';
import '../../domain/entities/sos_alert.dart';
import '../../domain/repositories/i_sos_repository.dart';

/// The only file that talks to the Go backend's /api/v1/alerts
/// endpoint (internal/alert/handler.go).
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

  /// PATCH /api/v1/alerts/{id}/location
  /// Best-effort "keep the live tracking page moving" call while an
  /// alert is active; callers swallow failures here rather than
  /// interrupt the person the alert is about.
  Future<void> updateLocation({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracyMeters,
  }) async {
    try {
      await _client.dio.patch('$_basePath/$alertId/location', data: {
        'latitude': latitude,
        'longitude': longitude,
        'accuracyMeters': accuracyMeters,
      });
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// PATCH /api/v1/alerts/{id}/resolve -- "I'm Safe".
  Future<void> resolve(String alertId) async {
    try {
      await _client.dio.patch('$_basePath/$alertId/resolve');
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// GET /api/v1/alerts -> { "data": [ { id, status, createdAt, ... }, ... ] }
  /// The caller's own SOS history, most recent first.
  Future<List<AlertSummary>> fetchHistory() async {
    try {
      final res = await _client.dio.get(_basePath);
      final list = res.data['data'] as List<dynamic>;
      return list
          .map((j) => AlertSummary.fromJson(j as Map<String, dynamic>))
          .toList();
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