import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/ai/domain/entities/chat_message.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

/// Wire shape of one `{ role, content }` history entry
/// (`POST /api/v1/ai/chat`, internal/ai/handler.go).
@freezed
class ChatMessageModel with _$ChatMessageModel {
  const ChatMessageModel._();

  const factory ChatMessageModel({
    required String role,
    required String content,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  factory ChatMessageModel.fromEntity(ChatMessage message) => ChatMessageModel(
        role: message.role.wireValue,
        content: message.content,
      );

  ChatMessage toEntity() => ChatMessage(
        role: ChatRole.fromWireValue(role),
        content: content,
      );
}
