import 'package:freezed_annotation/freezed_annotation.dart';

part 'sos_chat_message.freezed.dart';

/// One in-app message between requester and helper. Never carries a name
/// or phone number: [sender] is only "requester" or "helper".
@freezed
class SosChatMessage with _$SosChatMessage {
  const factory SosChatMessage({
    /// Monotonic cursor used to ask only for newer messages.
    required int sequence,
    required String id,
    required String sender,
    required bool isMine,
    required String body,
    required DateTime createdAt,
  }) = _SosChatMessage;
}
