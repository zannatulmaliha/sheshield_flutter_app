import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/chat/domain/entities/responder_progress.dart';

export 'package:sheshield/features/chat/domain/entities/responder_progress.dart';

part 'responder_state.freezed.dart';

/// What the requester may know about who is helping (never who).
@freezed
class ResponderState with _$ResponderState {
  const factory ResponderState({
    required String status,
    required bool helperAccepted,
    required ResponderProgress progress,
  }) = _ResponderState;
}
