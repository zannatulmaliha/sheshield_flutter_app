import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/helper/domain/entities/live_state.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';

part 'helper_response_state.freezed.dart';

/// Why a response ended. Each reason carries the message (if any) the
/// helper should see.
enum HelperResponseEnd {
  requesterMarkedSafe('The person marked themselves safe. Thank you for responding.'),
  notAssignedAnymore('This alert is no longer assigned to you.'),
  resolvedByHelper('Alert resolved. Thank you for helping.'),
  backedOut(null);

  const HelperResponseEnd(this.userMessage);

  final String? userMessage;
}

@freezed
class HelperResponseState with _$HelperResponseState {
  const factory HelperResponseState({
    required ResponseStage stage,
    LiveState? live,

    /// Set once, when the response is over; polling stops at that point.
    HelperResponseEnd? ended,
  }) = _HelperResponseState;
}
