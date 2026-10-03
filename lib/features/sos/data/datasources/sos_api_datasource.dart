import 'package:dio/dio.dart';
import 'package:sheshield/core/network/api_envelope.dart';
import 'package:sheshield/core/network/api_failure_mapper.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/features/sos/data/models/alert_summary_model.dart';
import 'package:sheshield/features/sos/data/models/danger_zone_model.dart';
import 'package:sheshield/features/sos/data/models/sos_alert_model.dart';
import 'package:sheshield/features/sos/domain/entities/duress_type.dart';

/// The only file that talks to `/api/v1/alerts` (internal/alert/handler.go).
class SosApiDataSource {
  const SosApiDataSource(this._dioClient);

  static const _basePath = '/alerts';

  final DioClient _dioClient;

  Dio get _dio => _dioClient.dio;

  /// POST /alerts. The server texts every contact not in [notifiedByDevice]
  /// and reports the outcome per contact. [avConsent] is the live answer to
  /// "start audio/video recording?": persisted, but no capture exists yet.
  Future<SosAlertModel> sendAlert({
    required double latitude,
    required double longitude,
    required List<String> notifiedByDevice,
    required bool avConsent,
    required String trigger,
    double? accuracyMeters,
  }) =>
      guardApiCall(() async {
        final response = await _dio.post<dynamic>(
          _basePath,
          data: {
            'latitude': latitude,
            'longitude': longitude,
            'accuracyMeters': accuracyMeters,
            'notifiedByDevice': notifiedByDevice,
            'avConsent': avConsent,
            'trigger': trigger,
          },
        );
        return SosAlertModel.fromJson(readDataObject(response));
      });

  /// POST /alerts/{id}/duress  body: `{ type }`
  Future<void> triggerDuress(String alertId, DuressType type) => guardApiCall(
        () => _dio.post<dynamic>('$_basePath/$alertId/duress', data: {'type': type.key}),
      );

  /// PATCH /alerts/{id}/location: best-effort; callers swallow failures.
  Future<void> updateAlertLocation({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracyMeters,
  }) =>
      guardApiCall(
        () => _dio.patch<dynamic>(
          '$_basePath/$alertId/location',
          data: {
            'latitude': latitude,
            'longitude': longitude,
            'accuracyMeters': accuracyMeters,
          },
        ),
      );

  /// PATCH /alerts/{id}/resolve: "I'm Safe".
  Future<void> resolveAlert(String alertId) =>
      guardApiCall(() => _dio.patch<dynamic>('$_basePath/$alertId/resolve'));

  /// GET /alerts: the caller's own history, most recent first.
  Future<List<AlertSummaryModel>> fetchAlertHistory() => guardApiCall(() async {
        final response = await _dio.get<dynamic>(_basePath);
        return readDataList(response).map(AlertSummaryModel.fromJson).toList();
      });

  static const _defaultHeatmapRadiusKm = 5.0;

  /// GET /alerts/heatmap: the Danger Zone grid around a point.
  Future<List<DangerZoneModel>> fetchDangerZones({
    required double latitude,
    required double longitude,
    double radiusKm = _defaultHeatmapRadiusKm,
  }) =>
      guardApiCall(() async {
        final response = await _dio.get<dynamic>(
          '$_basePath/heatmap',
          queryParameters: {'lat': latitude, 'lng': longitude, 'radiusKm': radiusKm},
        );
        return readDataList(response).map(DangerZoneModel.fromJson).toList();
      });
}
