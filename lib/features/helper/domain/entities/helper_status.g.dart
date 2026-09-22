// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HelperStatusImpl _$$HelperStatusImplFromJson(Map<String, dynamic> json) =>
    _$HelperStatusImpl(
      isActive: json['isActive'] as bool? ?? false,
      radiusKm: (json['radiusKm'] as num?)?.toDouble() ?? 3.0,
    );

Map<String, dynamic> _$$HelperStatusImplToJson(_$HelperStatusImpl instance) =>
    <String, dynamic>{
      'isActive': instance.isActive,
      'radiusKm': instance.radiusKm,
    };
