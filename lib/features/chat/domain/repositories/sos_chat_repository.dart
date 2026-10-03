import 'package:sheshield/features/chat/domain/entities/responder_state.dart';
import 'package:sheshield/features/chat/domain/entities/sos_chat_message.dart';

/// In-app requester <-> helper messages for one SOS. Polling with a
/// sequence cursor keeps this dependency-free; it can move to SSE or
/// websockets later without touching the UI. Failures surface as
/// `AppFailure`.
abstract interface class SosChatRepository {
  /// Messages newer than [afterSequence] (0 = from the start).
  Future<List<SosChatMessage>> fetchMessages(String sosId, {int afterSequence = 0});

  Future<SosChatMessage> sendMessage(String sosId, String body);

  /// Has a helper accepted my SOS, and how far along are they?
  Future<ResponderState> fetchResponderState(String sosId);
}
