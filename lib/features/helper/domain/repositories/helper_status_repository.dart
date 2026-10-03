import 'package:sheshield/features/helper/domain/entities/helper_status.dart';

/// Whether the helper is accepting alerts, and their search radius.
/// Failures surface as `AppFailure`.
abstract interface class HelperStatusRepository {
  Future<HelperStatus> fetchStatus();

  /// latitude/longitude are required by the backend when [isActive] is
  /// true; the server stores them as the helper's last known location with
  /// an expiry, so a stale location stops matching new alerts.
  Future<HelperStatus> setStatus({
    required bool isActive,
    required double radiusKm,
    double? latitude,
    double? longitude,
    bool mutualConnectionOptIn = false,
  });
}
