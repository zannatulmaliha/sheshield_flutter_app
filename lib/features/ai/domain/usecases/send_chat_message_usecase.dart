import 'package:sheshield/features/ai/domain/entities/chat_message.dart';
import 'package:sheshield/features/ai/domain/repositories/ai_repository.dart';

class SendChatMessageUseCase {
  const SendChatMessageUseCase(this._aiRepository);

  final AiRepository _aiRepository;

  Future<String> call(List<ChatMessage> history) =>
      _aiRepository.sendChatMessage(history);
}
