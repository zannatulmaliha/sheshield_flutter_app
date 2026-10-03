import 'package:sheshield/features/ai/domain/entities/chat_message.dart';

/// Contract the presentation layer depends on. Failures surface as
/// `AppFailure`; no Dio type appears here.
abstract interface class AiRepository {
  /// Sends the full conversation so far and returns the assistant's reply.
  Future<String> sendChatMessage(List<ChatMessage> history);
}
