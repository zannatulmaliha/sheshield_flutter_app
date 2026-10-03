// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminVerificationModelImpl _$$AdminVerificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminVerificationModelImpl(
      id: json['id'] as String? ?? '',
      userUid: json['userUid'] as String? ?? '',
      status: json['status'] as String? ?? '',
      note: json['note'] as String? ?? '',
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      userName: json['userName'] as String? ?? '',
      userEmail: json['userEmail'] as String? ?? '',
      userPhone: json['userPhone'] as String? ?? '',
      userType: json['userType'] as String? ?? '',
      reviewedAt:
          const NullableDateTimeConverter().fromJson(json['reviewedAt']),
    );

Map<String, dynamic> _$$AdminVerificationModelImplToJson(
        _$AdminVerificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userUid': instance.userUid,
      'status': instance.status,
      'note': instance.note,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userPhone': instance.userPhone,
      'userType': instance.userType,
      'reviewedAt':
          const NullableDateTimeConverter().toJson(instance.reviewedAt),
    };
