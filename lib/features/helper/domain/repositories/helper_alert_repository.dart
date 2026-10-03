import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/live_state.dart';
import 'package:sheshield/features/helper/domain/entities/my_response.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';
import 'package:sheshield/features/helper/domain/entities/safety_status.dart';

/// Finding, accepting and working an alert. Failures surface as
/// `AppFailure`.
abstract interface class HelperAlertRepository {
  /// Only alerts within the helper's radius, to verified, currently-active
  /// helpers -- enforced server-side.
  Future<List<NearbyAlert>> fetchNearbyAlerts();

  /// Returns the accepted alert, or null if another helper won the accept
  /// race (server 409). That is an expected outcome, not a failure.
  Future<AcceptedAlert?> acceptAlert(String alertId);

  /// Backs out of an alert this helper holds (spec §2); reopens it for the
  /// standby helpers.
  Future<void> releaseAlert(String alertId);

  Future<SafetyStatus> fetchSafetyStatus(String alertId);

  /// Null when the helper isn't currently holding an alert.
  Future<MyResponse?> fetchCurrentResponse();

  Future<LiveState> fetchLiveState(String alertId);

  Future<void> setResponseStage(String alertId, ResponseStage stage);

  /// "Situation handled": closes the alert and revokes the helper's access.
  Future<void> resolveAlert(String alertId);
}
