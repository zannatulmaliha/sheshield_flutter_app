// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responder_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponderStateModelImpl _$$ResponderStateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ResponderStateModelImpl(
      status: json['status'] as String? ?? '',
      helperAccepted: json['helperAccepted'] as bool? ?? false,
      progress: json['helperProgress'] as String? ?? '',
    );

Map<String, dynamic> _$$ResponderStateModelImplToJson(
        _$ResponderStateModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'helperAccepted': instance.helperAccepted,
      'helperProgress': instance.progress,
    };
