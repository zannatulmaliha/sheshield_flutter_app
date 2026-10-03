import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/ai/domain/entities/chat_message.dart';
import 'package:sheshield/features/ai/domain/usecases/send_chat_message_usecase.dart';
import 'package:sheshield/features/ai/presentation/providers/ai_chat_state.dart';
import 'package:sheshield/features/ai/presentation/providers/ai_use_case_providers.dart';

part 'ai_chat_provider.g.dart';

/// Caps the history sent on every turn so a long conversation doesn't
/// balloon into an ever-growing request body.
const _maxHistoryMessages = 20;

/// Owns the Ask AI Guardian conversation for the app session (in memory
/// only; a fresh launch starts a new chat).
@riverpod
class AiChatController extends _$AiChatController {
  late final SendChatMessageUseCase _sendChatMessage =
      ref.read(sendChatMessageUseCaseProvider);

  @override
  AiChatState build() => const AiChatState();

  /// Appends [userText] at once (optimistic), then the assistant's reply.
  /// There is nothing to roll back on failure, since the person's message is
  /// still real history, so an [AppFailure] becomes an assistant-role
  /// message instead of discarding the turn.
  Future<void> send(String userText) async {
    final trimmedText = userText.trim();
    if (trimmedText.isEmpty || state.isSending) return;

    final messagesWithUserTurn = [
      ...state.messages,
      ChatMessage(role: ChatRole.user, content: trimmedText),
    ];
    state = state.copyWith(messages: messagesWithUserTurn, isSending: true);

    final assistantTurn = await _requestAssistantTurn(messagesWithUserTurn);
    state = state.copyWith(
      messages: [...state.messages, assistantTurn],
      isSending: false,
    );
  }

  Future<ChatMessage> _requestAssistantTurn(List<ChatMessage> history) async {
    final cappedHistory = history.length > _maxHistoryMessages
        ? history.sublist(history.length - _maxHistoryMessages)
        : history;
    try {
      final replyText = await _sendChatMessage(cappedHistory);
      return ChatMessage(role: ChatRole.assistant, content: replyText);
    } on AppFailure catch (failure) {
      return ChatMessage(role: ChatRole.assistant, content: failure.message);
    }
  }
}
