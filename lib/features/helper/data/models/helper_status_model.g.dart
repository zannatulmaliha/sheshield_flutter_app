// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HelperStatusModelImpl _$$HelperStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HelperStatusModelImpl(
      isActive: json['isActive'] as bool? ?? false,
      radiusKm: (json['radiusKm'] as num?)?.toDouble() ?? 3.0,
      mutualConnectionOptIn: json['mutualConnectionOptIn'] as bool? ?? false,
    );

Map<String, dynamic> _$$HelperStatusModelImplToJson(
        _$HelperStatusModelImpl instance) =>
    <String, dynamic>{
      'isActive': instance.isActive,
      'radiusKm': instance.radiusKm,
      'mutualConnectionOptIn': instance.mutualConnectionOptIn,
    };
