import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_reply_model.freezed.dart';
part 'chat_reply_model.g.dart';

/// Wire shape of the assistant's answer: `{ "reply": "..." }`.
@freezed
class ChatReplyModel with _$ChatReplyModel {
  const factory ChatReplyModel({required String reply}) = _ChatReplyModel;

  factory ChatReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ChatReplyModelFromJson(json);
}
