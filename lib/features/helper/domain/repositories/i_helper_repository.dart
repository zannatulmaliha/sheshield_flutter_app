import '../entities/accepted_alert.dart';
import '../entities/helper_status.dart';
import '../entities/nearby_alert.dart';

/// Contract the presentation layer depends on. No Dio or Firebase type
/// appears here -- data/ translates transport-specific errors into
/// [HelperFailure] below.
abstract class IHelperRepository {
  Future<HelperStatus> fetchStatus();

  /// latitude/longitude are required by the backend when isActive is
  /// true; the server stores them as the helper's last known location,
  /// with an expiry, so a stale location stops matching new alerts.
  Future<HelperStatus> setStatus({
    required bool isActive,
    required double radiusKm,
    double? latitude,
    double? longitude,
  });

  /// Only returns alerts within the helper's current radius, to
  /// verified, currently-active helpers -- enforced server-side.
  Future<List<NearbyAlert>> fetchNearbyAlerts();

  /// Returns the accepted alert, or null if another helper won the
  /// accept race first (server responded 409) -- an expected outcome,
  /// not an error, so it is not represented as a thrown failure.
  Future<AcceptedAlert?> accept(String alertId);
}

class HelperFailure implements Exception {
  const HelperFailure(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}
