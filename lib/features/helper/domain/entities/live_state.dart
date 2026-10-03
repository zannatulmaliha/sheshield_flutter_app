import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/helper/domain/entities/live_alert_status.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';

part 'live_state.freezed.dart';

/// Polled while responding (`GET /helper/alerts/{id}/live`).
@freezed
class LiveState with _$LiveState {
  const LiveState._();

  const factory LiveState({
    required LiveAlertStatus status,
    double? latitude,
    double? longitude,
    DateTime? updatedAt,
    @Default(ResponseStage.none) ResponseStage stage,
    @Default(false) bool duressActive,
    @Default(false) bool connectivityLost,
  }) = _LiveState;

  bool get isOpen => status == LiveAlertStatus.accepted;

  bool get endedByRequester => status == LiveAlertStatus.resolved;
}
