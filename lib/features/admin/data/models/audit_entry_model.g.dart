// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuditEntryModelImpl _$$AuditEntryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AuditEntryModelImpl(
      id: json['id'] as String? ?? '',
      actorId: json['actorId'] as String? ?? '',
      action: json['action'] as String? ?? '',
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      targetId: json['targetId'] as String?,
    );

Map<String, dynamic> _$$AuditEntryModelImplToJson(
        _$AuditEntryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actorId': instance.actorId,
      'action': instance.action,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'targetId': instance.targetId,
    };
