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
  });
}

class SosFailure implements Exception {
  const SosFailure(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}