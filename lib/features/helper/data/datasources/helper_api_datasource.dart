import 'package:dio/dio.dart';
import 'package:sheshield/core/network/dio_client.dart';
import '../../domain/entities/accepted_alert.dart';
import '../../domain/entities/helper_status.dart';
import '../../domain/entities/nearby_alert.dart';
import '../../domain/entities/safety_status.dart';
import '../../domain/repositories/i_helper_repository.dart';

/// The only file that talks to the /api/v1/helper endpoints. These do
/// not exist on the backend yet -- see the contract in each method's
/// doc comment for what internal/helper/ needs to implement, following
/// the same handler -> service -> repository shape as
/// internal/verification/.
class HelperApiDataSource {
  HelperApiDataSource(this._client);
  final DioClient _client;
  static const _basePath = '/api/v1/helper';

  /// GET /api/v1/helper/status -> { "data": { isActive, radiusKm } }
  Future<HelperStatus> fetchStatus() async {
    try {
      final res = await _client.dio.get('$_basePath/status');
      return HelperStatus.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// PUT /api/v1/helper/status
  /// body: { isActive, radiusKm, latitude?, longitude?, mutualConnectionOptIn }
  Future<HelperStatus> setStatus({
    required bool isActive,
    required double radiusKm,
    double? latitude,
    double? longitude,
    bool mutualConnectionOptIn = false,
  }) async {
    try {
      final res = await _client.dio.put('$_basePath/status', data: {
        'isActive': isActive,
        'radiusKm': radiusKm,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        'mutualConnectionOptIn': mutualConnectionOptIn,
      });
      return HelperStatus.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// GET /api/v1/helper/alerts/nearby
  /// -> { "data": [ { id, roughArea, distanceMeters, createdAt }, ... ] }
  Future<List<NearbyAlert>> fetchNearbyAlerts() async {
    try {
      final res = await _client.dio.get('$_basePath/alerts/nearby');
      final list = res.data['data'] as List<dynamic>;
      return list
          .map((j) => NearbyAlert.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// POST /api/v1/helper/alerts/{id}/accept
  /// 200 -> the full alert (exact location + phone), this helper won.
  /// 409 -> another helper already won; returns null, not an error.
  /// The server MUST make this one atomic operation (e.g. a single
  /// UPDATE ... WHERE status = 'active' RETURNING *) so exactly one
  /// helper can ever win under concurrent requests.
  Future<AcceptedAlert?> accept(String alertId) async {
    try {
      final res = await _client.dio.post('$_basePath/alerts/$alertId/accept');
      return AcceptedAlert.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) return null;
      throw _fail(e);
    }
  }

  /// POST /api/v1/helper/alerts/{id}/release -- back out of an alert this
  /// helper currently holds. Reopens it server-side for standby helpers.
  Future<void> release(String alertId) async {
    try {
      await _client.dio.post('$_basePath/alerts/$alertId/release');
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  /// GET /api/v1/helper/alerts/{id}/safety-status -> { duressActive, connectivityLost }
  /// Polled while this helper holds the alert -- see spec §8.
  Future<SafetyStatus> fetchSafetyStatus(String alertId) async {
    try {
      final res = await _client.dio.get('$_basePath/alerts/$alertId/safety-status');
      final data = res.data['data'] as Map<String, dynamic>;
      return SafetyStatus(
        duressActive: data['duressActive'] as bool? ?? false,
        connectivityLost: data['connectivityLost'] as bool? ?? false,
      );
    } on DioException catch (e) {
      throw _fail(e);
    }
  }

  HelperFailure _fail(DioException e) {
    final data = e.response?.data;
    final message = (data is Map && data['error'] is String)
        ? data['error'] as String
        : (e.type == DioExceptionType.connectionError ||
                e.type == DioExceptionType.connectionTimeout
            ? 'No internet connection. Please try again.'
            : 'Something went wrong. Please try again.');
    return HelperFailure(message, unauthorized: e.response?.statusCode == 401);
  }
}
