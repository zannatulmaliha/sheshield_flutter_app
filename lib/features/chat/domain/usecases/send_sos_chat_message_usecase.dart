import 'package:sheshield/features/chat/domain/entities/sos_chat_message.dart';
import 'package:sheshield/features/chat/domain/repositories/sos_chat_repository.dart';

class SendSosChatMessageUseCase {
  const SendSosChatMessageUseCase(this._sosChatRepository);

  final SosChatRepository _sosChatRepository;

  Future<SosChatMessage> call(String sosId, String body) =>
      _sosChatRepository.sendMessage(sosId, body);
}
