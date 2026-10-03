import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/helper/domain/entities/risk_level.dart';

part 'nearby_alert.freezed.dart';

/// A nearby SOS alert as a helper sees it BEFORE responding. Only a rough
/// area, distance and WHAT is happening (never who) are exposed; the exact
/// address and phone number arrive only after `AcceptAlertUseCase`
/// succeeds (see `AcceptedAlert`). This entity structurally cannot carry
/// precise coordinates or identity.
@freezed
class NearbyAlert with _$NearbyAlert {
  const NearbyAlert._();

  const factory NearbyAlert({
    required String id,
    required double distanceMeters,
    required DateTime createdAt,
    @Default('Nearby') String roughArea,
    @Default(false) bool mutualConnection,

    /// What fired the SOS: manual | voice | motion_fall | motion_sprint |
    /// motion_struggle | motion_inactive | missed_checkin. Kept as text:
    /// the backend can add triggers without an app release.
    @Default('manual') String trigger,

    /// Plain-language reason shown on the card ("Possible fall detected").
    @Default('SOS button pressed') String label,
    @Default(RiskLevel.high) RiskLevel riskLevel,
    @Default(false) bool duressActive,
  }) = _NearbyAlert;

  bool get isHighRisk => riskLevel == RiskLevel.high;

  String get distanceLabel => distanceMeters < 1000
      ? '${distanceMeters.round()} m away'
      : '${(distanceMeters / 1000).toStringAsFixed(1)} km away';

  /// Rough ETA at ~25 km/h average urban speed: an estimate for triage
  /// only; the helper's map app gives the real one.
  int get etaMinutes => (distanceMeters / 1000 / 25 * 60).ceil().clamp(1, 999);
}
