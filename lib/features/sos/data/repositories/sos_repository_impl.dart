import 'package:sheshield/features/sos/data/datasources/sos_api_datasource.dart';
import 'package:sheshield/features/sos/domain/entities/alert_summary.dart';
import 'package:sheshield/features/sos/domain/entities/danger_zone.dart';
import 'package:sheshield/features/sos/domain/entities/duress_type.dart';
import 'package:sheshield/features/sos/domain/entities/sos_alert.dart';
import 'package:sheshield/features/sos/domain/repositories/sos_repository.dart';

/// Deliberately does NOT touch the cache anywhere: an SOS is a write, and
/// always time-critical. A cached "success" could mean a real emergency
/// never reached the backend.
class SosRepositoryImpl implements SosRepository {
  const SosRepositoryImpl(this._apiDataSource);

  final SosApiDataSource _apiDataSource;

  @override
  Future<SosAlert> sendAlert({
    required double latitude,
    required double longitude,
    double? accuracyMeters,
    List<String> notifiedByDevice = const [],
    bool avConsent = false,
    String trigger = 'manual',
  }) async {
    final model = await _apiDataSource.sendAlert(
      latitude: latitude,
      longitude: longitude,
      accuracyMeters: accuracyMeters,
      notifiedByDevice: notifiedByDevice,
      avConsent: avConsent,
      trigger: trigger,
    );
    return model.toEntity();
  }

  @override
  Future<void> triggerDuress(String alertId, DuressType type) =>
      _apiDataSource.triggerDuress(alertId, type);

  @override
  Future<void> updateAlertLocation({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracyMeters,
  }) =>
      _apiDataSource.updateAlertLocation(
        alertId: alertId,
        latitude: latitude,
        longitude: longitude,
        accuracyMeters: accuracyMeters,
      );

  @override
  Future<void> resolveAlert(String alertId) => _apiDataSource.resolveAlert(alertId);

  @override
  Future<List<AlertSummary>> fetchAlertHistory() async {
    final models = await _apiDataSource.fetchAlertHistory();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<DangerZone>> fetchDangerZones({
    required double latitude,
    required double longitude,
  }) async {
    final models = await _apiDataSource.fetchDangerZones(
      latitude: latitude,
      longitude: longitude,
    );
    return models.map((model) => model.toEntity()).toList();
  }
}
