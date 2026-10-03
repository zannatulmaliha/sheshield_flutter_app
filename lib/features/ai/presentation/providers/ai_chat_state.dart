import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/ai/domain/entities/chat_message.dart';

part 'ai_chat_state.freezed.dart';

@freezed
class AiChatState with _$AiChatState {
  const factory AiChatState({
    @Default(<ChatMessage>[]) List<ChatMessage> messages,
    @Default(false) bool isSending,
  }) = _AiChatState;
}
