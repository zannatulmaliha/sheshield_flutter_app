// ignore_for_file: invalid_annotation_target
// `@JsonKey` on a freezed constructor parameter is the documented freezed
// pattern; the analyzer's annotation-target check doesn't know freezed
// moves it onto the generated class, so it flags a false positive here.
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/chat/domain/entities/sos_chat_message.dart';

part 'sos_chat_message_model.freezed.dart';
part 'sos_chat_message_model.g.dart';

/// Wire shape of one message (backend internal/sosmsg).
@freezed
class SosChatMessageModel with _$SosChatMessageModel {
  const SosChatMessageModel._();

  const factory SosChatMessageModel({
    @JsonKey(name: 'seq') required int sequence,
    required String id,
    @JsonKey(name: 'from') required String sender,
    required String body,
    @DateTimeConverter() required DateTime createdAt,
    @JsonKey(name: 'mine') @Default(false) bool isMine,
  }) = _SosChatMessageModel;

  factory SosChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$SosChatMessageModelFromJson(json);

  SosChatMessage toEntity() => SosChatMessage(
        sequence: sequence,
        id: id,
        sender: sender,
        isMine: isMine,
        body: body,
        createdAt: createdAt,
      );
}
