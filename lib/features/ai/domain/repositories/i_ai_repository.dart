import '../entities/chat_message.dart';

/// Contract the presentation layer depends on. No Dio type appears here
/// -- data/ translates transport errors into [AiFailure].
abstract class IAiRepository {
  /// Sends the full conversation so far and returns the assistant's
  /// reply text.
  Future<String> sendMessage(List<ChatMessage> history);
}

class AiFailure implements Exception {
  const AiFailure(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}
