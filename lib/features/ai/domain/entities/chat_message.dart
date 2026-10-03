import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/ai/domain/entities/chat_role.dart';

export 'package:sheshield/features/ai/domain/entities/chat_role.dart';

part 'chat_message.freezed.dart';

/// One turn in an Ask AI Guardian conversation. The whole list is sent back
/// on every request so the model sees the full conversation.
@freezed
class ChatMessage with _$ChatMessage {
  const ChatMessage._();

  const factory ChatMessage({
    required ChatRole role,
    required String content,
  }) = _ChatMessage;

  bool get isFromUser => role == ChatRole.user;
}
