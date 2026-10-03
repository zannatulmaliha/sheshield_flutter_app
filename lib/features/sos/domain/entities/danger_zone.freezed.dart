// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'danger_zone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DangerZone {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  DangerZoneRisk get riskLevel => throw _privateConstructorUsedError;
  int get alertCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DangerZoneCopyWith<DangerZone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DangerZoneCopyWith<$Res> {
  factory $DangerZoneCopyWith(
          DangerZone value, $Res Function(DangerZone) then) =
      _$DangerZoneCopyWithImpl<$Res, DangerZone>;
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      DangerZoneRisk riskLevel,
      int alertCount});
}

/// @nodoc
class _$DangerZoneCopyWithImpl<$Res, $Val extends DangerZone>
    implements $DangerZoneCopyWith<$Res> {
  _$DangerZoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? riskLevel = null,
    Object? alertCount = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as DangerZoneRisk,
      alertCount: null == alertCount
          ? _value.alertCount
          : alertCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DangerZoneImplCopyWith<$Res>
    implements $DangerZoneCopyWith<$Res> {
  factory _$$DangerZoneImplCopyWith(
          _$DangerZoneImpl value, $Res Function(_$DangerZoneImpl) then) =
      __$$DangerZoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      DangerZoneRisk riskLevel,
      int alertCount});
}

/// @nodoc
class __$$DangerZoneImplCopyWithImpl<$Res>
    extends _$DangerZoneCopyWithImpl<$Res, _$DangerZoneImpl>
    implements _$$DangerZoneImplCopyWith<$Res> {
  __$$DangerZoneImplCopyWithImpl(
      _$DangerZoneImpl _value, $Res Function(_$DangerZoneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? riskLevel = null,
    Object? alertCount = null,
  }) {
    return _then(_$DangerZoneImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as DangerZoneRisk,
      alertCount: null == alertCount
          ? _value.alertCount
          : alertCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DangerZoneImpl implements _DangerZone {
  const _$DangerZoneImpl(
      {required this.latitude,
      required this.longitude,
      required this.riskLevel,
      required this.alertCount});

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final DangerZoneRisk riskLevel;
  @override
  final int alertCount;

  @override
  String toString() {
    return 'DangerZone(latitude: $latitude, longitude: $longitude, riskLevel: $riskLevel, alertCount: $alertCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DangerZoneImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.alertCount, alertCount) ||
                other.alertCount == alertCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, riskLevel, alertCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DangerZoneImplCopyWith<_$DangerZoneImpl> get copyWith =>
      __$$DangerZoneImplCopyWithImpl<_$DangerZoneImpl>(this, _$identity);
}

abstract class _DangerZone implements DangerZone {
  const factory _DangerZone(
      {required final double latitude,
      required final double longitude,
      required final DangerZoneRisk riskLevel,
      required final int alertCount}) = _$DangerZoneImpl;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  DangerZoneRisk get riskLevel;
  @override
  int get alertCount;
  @override
  @JsonKey(ignore: true)
  _$$DangerZoneImplCopyWith<_$DangerZoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
