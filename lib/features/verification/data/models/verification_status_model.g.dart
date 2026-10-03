// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerificationStatusModelImpl _$$VerificationStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationStatusModelImpl(
      status: json['status'] as String? ?? 'none',
      note: json['note'] as String? ?? '',
      submittedAt:
          const NullableDateTimeConverter().fromJson(json['submittedAt']),
    );

Map<String, dynamic> _$$VerificationStatusModelImplToJson(
        _$VerificationStatusModelImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'note': instance.note,
      'submittedAt':
          const NullableDateTimeConverter().toJson(instance.submittedAt),
    };
