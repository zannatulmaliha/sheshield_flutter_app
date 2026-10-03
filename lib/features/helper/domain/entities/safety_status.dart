import 'package:freezed_annotation/freezed_annotation.dart';

part 'safety_status.freezed.dart';

/// Live duress / connectivity signals for an alert a helper is responding
/// to (Trust & Safety spec §8). Polled, not pushed.
@freezed
class SafetyStatus with _$SafetyStatus {
  const factory SafetyStatus({
    required bool duressActive,
    required bool connectivityLost,
  }) = _SafetyStatus;
}
