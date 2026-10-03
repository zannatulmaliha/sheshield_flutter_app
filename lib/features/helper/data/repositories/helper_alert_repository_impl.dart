import 'package:sheshield/features/helper/data/datasources/helper_alert_api_datasource.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/live_state.dart';
import 'package:sheshield/features/helper/domain/entities/my_response.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';
import 'package:sheshield/features/helper/domain/entities/safety_status.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';

/// No caching anywhere here: alerts are time-critical, so a stale read
/// would be actively harmful rather than just a missed optimisation.
class HelperAlertRepositoryImpl implements HelperAlertRepository {
  const HelperAlertRepositoryImpl(this._apiDataSource);

  final HelperAlertApiDataSource _apiDataSource;

  @override
  Future<List<NearbyAlert>> fetchNearbyAlerts() async {
    final models = await _apiDataSource.fetchNearbyAlerts();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<AcceptedAlert?> acceptAlert(String alertId) async =>
      (await _apiDataSource.acceptAlert(alertId))?.toEntity();

  @override
  Future<void> releaseAlert(String alertId) => _apiDataSource.releaseAlert(alertId);

  @override
  Future<SafetyStatus> fetchSafetyStatus(String alertId) async =>
      (await _apiDataSource.fetchSafetyStatus(alertId)).toEntity();

  @override
  Future<MyResponse?> fetchCurrentResponse() async =>
      (await _apiDataSource.fetchCurrentResponse())?.toEntity();

  @override
  Future<LiveState> fetchLiveState(String alertId) async =>
      (await _apiDataSource.fetchLiveState(alertId)).toEntity();

  @override
  Future<void> setResponseStage(String alertId, ResponseStage stage) =>
      _apiDataSource.setResponseStage(alertId, stage);

  @override
  Future<void> resolveAlert(String alertId) => _apiDataSource.resolveAlert(alertId);
}
