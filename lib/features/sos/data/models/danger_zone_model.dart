import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/sos/domain/entities/danger_zone.dart';
import 'package:sheshield/features/sos/domain/entities/danger_zone_risk.dart';

part 'danger_zone_model.freezed.dart';
part 'danger_zone_model.g.dart';

/// Wire shape of one row of `GET /alerts/heatmap`.
@freezed
class DangerZoneModel with _$DangerZoneModel {
  const DangerZoneModel._();

  const factory DangerZoneModel({
    required double latitude,
    required double longitude,
    required String riskLevel,
    @Default(0) int alertCount,
  }) = _DangerZoneModel;

  factory DangerZoneModel.fromJson(Map<String, dynamic> json) =>
      _$DangerZoneModelFromJson(json);

  DangerZone toEntity() => DangerZone(
        latitude: latitude,
        longitude: longitude,
        riskLevel: DangerZoneRisk.fromWireValue(riskLevel),
        alertCount: alertCount,
      );
}
