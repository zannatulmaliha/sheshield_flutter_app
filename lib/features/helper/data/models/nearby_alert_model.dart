import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/domain/entities/risk_level.dart';

part 'nearby_alert_model.freezed.dart';
part 'nearby_alert_model.g.dart';

/// Wire shape of one row of `GET /helper/alerts/nearby`. Deliberately has
/// no precise coordinates or identity fields.
@freezed
class NearbyAlertModel with _$NearbyAlertModel {
  const NearbyAlertModel._();

  const factory NearbyAlertModel({
    required String id,
    required double distanceMeters,
    @DateTimeConverter() required DateTime createdAt,
    @Default('Nearby') String roughArea,
    @Default(false) bool mutualConnection,
    @Default('manual') String trigger,
    @Default('SOS button pressed') String label,
    @Default('high') String riskLevel,
    @Default(false) bool duressActive,
  }) = _NearbyAlertModel;

  factory NearbyAlertModel.fromJson(Map<String, dynamic> json) =>
      _$NearbyAlertModelFromJson(json);

  NearbyAlert toEntity() => NearbyAlert(
        id: id,
        distanceMeters: distanceMeters,
        createdAt: createdAt,
        roughArea: roughArea,
        mutualConnection: mutualConnection,
        trigger: trigger,
        label: label,
        riskLevel: RiskLevel.fromWireValue(riskLevel),
        duressActive: duressActive,
      );
}
