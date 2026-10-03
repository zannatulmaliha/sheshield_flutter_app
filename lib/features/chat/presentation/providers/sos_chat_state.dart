import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/chat/domain/entities/sos_chat_message.dart';

part 'sos_chat_state.freezed.dart';

@freezed
class SosChatState with _$SosChatState {
  const SosChatState._();

  const factory SosChatState({
    @Default(<SosChatMessage>[]) List<SosChatMessage> messages,
    @Default(false) bool isSending,

    /// The emergency ended (alert resolved / helper released): no more sends
    /// and no more polling.
    @Default(false) bool isClosed,
    String? errorMessage,
  }) = _SosChatState;

  /// Cursor for "messages newer than what I have".
  int get lastSequence => messages.isEmpty ? 0 : messages.last.sequence;
}
