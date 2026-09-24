import '../entities/alert_summary.dart';
import '../entities/sos_alert.dart';

/// Contract the presentation layer depends on for emergency alerts.
/// No Dio type appears here -- data/ translates transport errors into
/// [SosFailure] below. There is deliberately no `cancel` method: the
/// backend has no cancel endpoint (internal/alert has only `create`)
/// -- once sent, contacts have already been texted, so "cancelling"
/// only ever means dismissing the local UI.
abstract class ISosRepository {
  /// Sends a new SOS alert. [notifiedByDevice] lists the IDs of
  /// contacts this device already texted directly from its own SIM
  /// (not implemented on the Flutter side yet -- always pass an empty
  /// list for now, which tells the server to notify every contact
  /// itself), so the server can skip texting them again.
  Future<SosAlert> send({
    required double latitude,
    required double longitude,
    double? accuracyMeters,
    List<String> notifiedByDevice = const [],
    bool avConsent = false,
  });

  /// Records a duress signal on an active/accepted SOS and escalates:
  /// every trusted contact is notified immediately, independent of the
  /// currently matched helper. [type] is one of the DuressType values.
  Future<void> triggerDuress(String alertId, String type);

  /// Refreshes the alert's live location while it's active, so the
  /// tracking page contacts opened from their SMS keeps moving with the
  /// sender rather than freezing at the moment SOS was pressed.
  Future<void> updateLocation({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracyMeters,
  });

  /// Marks the alert resolved ("I'm Safe") -- stops the tracking page
  /// from showing further updates. Does not un-notify contacts; there's
  /// no way to un-send an SMS that already went out.
  Future<void> resolve(String alertId);

  /// The caller's own past SOS alerts, most recent first -- what the
  /// notification-history screen shows.
  Future<List<AlertSummary>> fetchHistory();
}

class SosFailure implements Exception {
  const SosFailure(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}