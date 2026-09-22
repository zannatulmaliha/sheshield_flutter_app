// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerificationStatusImpl _$$VerificationStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationStatusImpl(
      status: $enumDecode(_$VerificationStateEnumMap, json['status']),
      note: json['note'] as String? ?? '',
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
    );

Map<String, dynamic> _$$VerificationStatusImplToJson(
        _$VerificationStatusImpl instance) =>
    <String, dynamic>{
      'status': _$VerificationStateEnumMap[instance.status]!,
      'note': instance.note,
      'submittedAt': instance.submittedAt?.toIso8601String(),
    };

const _$VerificationStateEnumMap = {
  VerificationState.none: 'none',
  VerificationState.pending: 'pending',
  VerificationState.approved: 'approved',
  VerificationState.rejected: 'rejected',
};
