import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/helper/domain/entities/live_alert_status.dart';
import 'package:sheshield/features/helper/domain/entities/live_state.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';

part 'live_state_model.freezed.dart';
part 'live_state_model.g.dart';

/// Wire shape of `GET /helper/alerts/{id}/live`.
@freezed
class LiveStateModel with _$LiveStateModel {
  const LiveStateModel._();

  const factory LiveStateModel({
    @Default('accepted') String status,
    @Default('') String progress,
    @Default(false) bool duressActive,
    @Default(false) bool connectivityLost,
    double? latitude,
    double? longitude,
    @NullableDateTimeConverter() DateTime? updatedAt,
  }) = _LiveStateModel;

  factory LiveStateModel.fromJson(Map<String, dynamic> json) =>
      _$LiveStateModelFromJson(json);

  LiveState toEntity() => LiveState(
        status: LiveAlertStatus.fromWireValue(status),
        latitude: latitude,
        longitude: longitude,
        updatedAt: updatedAt,
        stage: ResponseStage.fromWireValue(progress),
        duressActive: duressActive,
        connectivityLost: connectivityLost,
      );
}
