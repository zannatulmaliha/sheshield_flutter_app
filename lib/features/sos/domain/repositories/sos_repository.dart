import 'package:sheshield/features/sos/domain/entities/alert_summary.dart';
import 'package:sheshield/features/sos/domain/entities/danger_zone.dart';
import 'package:sheshield/features/sos/domain/entities/duress_type.dart';
import 'package:sheshield/features/sos/domain/entities/sos_alert.dart';

/// Contract the presentation layer depends on for emergency alerts.
/// Failures surface as `AppFailure`. There is deliberately no `cancel`:
/// the backend has none, and once sent, contacts have already been texted,
/// so "cancelling" only ever means dismissing the local UI.
abstract interface class SosRepository {
  /// [notifiedByDevice] lists contact ids this phone already texted from its
  /// own SIM, so the server can skip texting them again.
  Future<SosAlert> sendAlert({
    required double latitude,
    required double longitude,
    double? accuracyMeters,
    List<String> notifiedByDevice = const [],
    bool avConsent = false,
    String trigger = 'manual',
  });

  /// Escalates an active SOS: every trusted contact is notified at once,
  /// independent of the currently matched helper.
  Future<void> triggerDuress(String alertId, DuressType type);

  /// Keeps the live tracking page moving while the alert is active.
  Future<void> updateAlertLocation({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracyMeters,
  });

  /// "I'm Safe": stops the tracking page. Does not un-notify contacts.
  Future<void> resolveAlert(String alertId);

  /// The caller's own past alerts, most recent first.
  Future<List<AlertSummary>> fetchAlertHistory();

  /// The Danger Zone heat map grid around a point.
  Future<List<DangerZone>> fetchDangerZones({
    required double latitude,
    required double longitude,
  });
}
