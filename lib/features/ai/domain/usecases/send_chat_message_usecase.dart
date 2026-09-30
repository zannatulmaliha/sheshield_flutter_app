import '../entities/chat_message.dart';
import '../repositories/i_ai_repository.dart';

class SendChatMessageUseCase {
  const SendChatMessageUseCase(this._repository);
  final IAiRepository _repository;

  Future<String> call(List<ChatMessage> history) =>
      _repository.sendMessage(history);
}
