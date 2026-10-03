import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/helper/domain/entities/safety_status.dart';

part 'safety_status_model.freezed.dart';
part 'safety_status_model.g.dart';

/// Wire shape of `GET /helper/alerts/{id}/safety-status`.
@freezed
class SafetyStatusModel with _$SafetyStatusModel {
  const SafetyStatusModel._();

  const factory SafetyStatusModel({
    @Default(false) bool duressActive,
    @Default(false) bool connectivityLost,
  }) = _SafetyStatusModel;

  factory SafetyStatusModel.fromJson(Map<String, dynamic> json) =>
      _$SafetyStatusModelFromJson(json);

  SafetyStatus toEntity() => SafetyStatus(
        duressActive: duressActive,
        connectivityLost: connectivityLost,
      );
}
