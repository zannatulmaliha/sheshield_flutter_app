import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

/// One turn in an Ask AI Guardian conversation. `role`/`content` mirror
/// the Go backend's chat history shape exactly (`POST /api/v1/ai/chat`,
/// internal/ai/handler.go) -- the whole list is sent back on every
/// request so the model sees the full conversation, not just the latest
/// message.
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String role,
    required String content,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
