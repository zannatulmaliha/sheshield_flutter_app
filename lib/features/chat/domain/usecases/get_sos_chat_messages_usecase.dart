import 'package:sheshield/features/chat/domain/entities/sos_chat_message.dart';
import 'package:sheshield/features/chat/domain/repositories/sos_chat_repository.dart';

class GetSosChatMessagesUseCase {
  const GetSosChatMessagesUseCase(this._sosChatRepository);

  final SosChatRepository _sosChatRepository;

  Future<List<SosChatMessage>> call(String sosId, {int afterSequence = 0}) =>
      _sosChatRepository.fetchMessages(sosId, afterSequence: afterSequence);
}
