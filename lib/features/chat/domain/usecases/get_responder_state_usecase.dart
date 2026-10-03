import 'package:sheshield/features/chat/domain/entities/responder_state.dart';
import 'package:sheshield/features/chat/domain/repositories/sos_chat_repository.dart';

class GetResponderStateUseCase {
  const GetResponderStateUseCase(this._sosChatRepository);

  final SosChatRepository _sosChatRepository;

  Future<ResponderState> call(String sosId) =>
      _sosChatRepository.fetchResponderState(sosId);
}
