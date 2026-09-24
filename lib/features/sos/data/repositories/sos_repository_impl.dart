import '../../domain/entities/alert_summary.dart';
import '../../domain/entities/sos_alert.dart';
import '../../domain/repositories/i_sos_repository.dart';
import '../datasources/sos_api_datasource.dart';

/// Thin adapter satisfying [ISosRepository] by delegating to the REST
/// data source. Deliberately does NOT touch [CacheBox] anywhere --
/// an SOS alert is a write, not a read someone might want to reuse,
/// and it is always time-critical: a cached "success" here could mean
/// a real emergency never actually reached the backend.
class SosRepositoryImpl implements ISosRepository {
  SosRepositoryImpl(this._dataSource);
  final SosApiDataSource _dataSource;

  @override
  Future<SosAlert> send({
    required double latitude,
    required double longitude,
    double? accuracyMeters,
    List<String> notifiedByDevice = const [],
    bool avConsent = false,
  }) =>
      _dataSource.send(
        latitude: latitude,
        longitude: longitude,
        accuracyMeters: accuracyMeters,
        notifiedByDevice: notifiedByDevice,
        avConsent: avConsent,
      );

  @override
  Future<void> triggerDuress(String alertId, String type) =>
      _dataSource.triggerDuress(alertId, type);

  @override
  Future<void> updateLocation({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracyMeters,
  }) =>
      _dataSource.updateLocation(
        alertId: alertId,
        latitude: latitude,
        longitude: longitude,
        accuracyMeters: accuracyMeters,
      );

  @override
  Future<void> resolve(String alertId) => _dataSource.resolve(alertId);

  @override
  Future<List<AlertSummary>> fetchHistory() => _dataSource.fetchHistory();
}