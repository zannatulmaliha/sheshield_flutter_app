import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/sos/domain/entities/danger_zone_risk.dart';

part 'danger_zone.freezed.dart';

/// One ~1.1km grid cell of the Danger Zone heat map
/// (`GET /alerts/heatmap`). [alertCount] is how many past alerts fell in
/// this cell, never which ones -- the backend never returns per-alert
/// locations here.
@freezed
class DangerZone with _$DangerZone {
  const factory DangerZone({
    required double latitude,
    required double longitude,
    required DangerZoneRisk riskLevel,
    required int alertCount,
  }) = _DangerZone;
}
