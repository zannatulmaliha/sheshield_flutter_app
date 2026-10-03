import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkin_state.freezed.dart';

enum CheckInStatus {
  /// No countdown running.
  idle,

  /// Counting down; the person can still check in to stop it.
  running,

  /// The countdown reached zero and an SOS was sent automatically.
  sosSent,
}

@freezed
class CheckInState with _$CheckInState {
  const CheckInState._();

  const factory CheckInState({
    @Default(CheckInStatus.idle) CheckInStatus status,
    @Default(0) int totalSeconds,
    @Default(0) int remainingSeconds,
  }) = _CheckInState;

  /// 0.0 (just started) to 1.0 (about to fire), for a progress indicator.
  double get progress =>
      totalSeconds == 0 ? 0 : 1 - (remainingSeconds / totalSeconds);
}
