// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SosChatMessageModelImpl _$$SosChatMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SosChatMessageModelImpl(
      sequence: (json['seq'] as num).toInt(),
      id: json['id'] as String,
      sender: json['from'] as String,
      body: json['body'] as String,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      isMine: json['mine'] as bool? ?? false,
    );

Map<String, dynamic> _$$SosChatMessageModelImplToJson(
        _$SosChatMessageModelImpl instance) =>
    <String, dynamic>{
      'seq': instance.sequence,
      'id': instance.id,
      'from': instance.sender,
      'body': instance.body,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'mine': instance.isMine,
    };
