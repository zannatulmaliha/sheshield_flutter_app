import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/ai/domain/entities/chat_message.dart';
import 'package:sheshield/features/ai/domain/repositories/i_ai_repository.dart';
import 'package:sheshield/features/ai/domain/usecases/send_chat_message_usecase.dart';

part 'ai_chat_provider.g.dart';

/// Caps the history sent to the backend on every turn, so a long-running
/// conversation doesn't balloon into an ever-growing request body.
const _kMaxHistoryMessages = 20;

class AiChatState {
  const AiChatState({this.messages = const [], this.isSending = false});
  final List<ChatMessage> messages;
  final bool isSending;

  AiChatState copyWith({List<ChatMessage>? messages, bool? isSending}) =>
      AiChatState(
        messages: messages ?? this.messages,
        isSending: isSending ?? this.isSending,
      );
}

/// Owns the Ask AI Guardian conversation for the lifetime of the app
/// session (in-memory only -- a fresh app launch starts a new chat).
@riverpod
class AiChatController extends _$AiChatController {
  @override
  AiChatState build() => const AiChatState();

  /// Appends [userText] immediately (optimistic), then the assistant's
  /// reply once the backend answers. Unlike contacts there is nothing to
  /// roll back on failure -- the user's own message is still real
  /// conversation history -- so an [AiFailure] is surfaced as a synthetic
  /// assistant-role message instead of discarding the turn.
  Future<void> send(String userText) async {
    final trimmed = userText.trim();
    if (trimmed.isEmpty || state.isSending) return;

    final withUser = [
      ...state.messages,
      ChatMessage(role: 'user', content: trimmed)
    ];
    state = state.copyWith(messages: withUser, isSending: true);

    final capped = withUser.length > _kMaxHistoryMessages
        ? withUser.sublist(withUser.length - _kMaxHistoryMessages)
        : withUser;

    try {
      final reply = await getIt<SendChatMessageUseCase>().call(capped);
      state = state.copyWith(
        messages: [
          ...state.messages,
          ChatMessage(role: 'assistant', content: reply)
        ],
        isSending: false,
      );
    } on AiFailure catch (e) {
      state = state.copyWith(
        messages: [
          ...state.messages,
          ChatMessage(role: 'assistant', content: e.message)
        ],
        isSending: false,
      );
    }
  }
}
