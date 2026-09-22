// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trusted_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrustedContactImpl _$$TrustedContactImplFromJson(Map<String, dynamic> json) =>
    _$TrustedContactImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      relation: json['relation'] as String,
      phone: json['phone'] as String,
      countryCode: json['countryCode'] as String,
      createdAt: const DateTimeConverter().fromJson(json['createdAt']),
      linkedUserUid: json['linkedUserUid'] as String?,
    );

Map<String, dynamic> _$$TrustedContactImplToJson(
        _$TrustedContactImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'relation': instance.relation,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'linkedUserUid': instance.linkedUserUid,
    };
