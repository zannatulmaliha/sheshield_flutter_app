// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'danger_zone_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DangerZoneModel _$DangerZoneModelFromJson(Map<String, dynamic> json) {
  return _DangerZoneModel.fromJson(json);
}

/// @nodoc
mixin _$DangerZoneModel {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get riskLevel => throw _privateConstructorUsedError;
  int get alertCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DangerZoneModelCopyWith<DangerZoneModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DangerZoneModelCopyWith<$Res> {
  factory $DangerZoneModelCopyWith(
          DangerZoneModel value, $Res Function(DangerZoneModel) then) =
      _$DangerZoneModelCopyWithImpl<$Res, DangerZoneModel>;
  @useResult
  $Res call(
      {double latitude, double longitude, String riskLevel, int alertCount});
}

/// @nodoc
class _$DangerZoneModelCopyWithImpl<$Res, $Val extends DangerZoneModel>
    implements $DangerZoneModelCopyWith<$Res> {
  _$DangerZoneModelCopyWithImpl(this._value, this._then);

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
              as String,
      alertCount: null == alertCount
          ? _value.alertCount
          : alertCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DangerZoneModelImplCopyWith<$Res>
    implements $DangerZoneModelCopyWith<$Res> {
  factory _$$DangerZoneModelImplCopyWith(_$DangerZoneModelImpl value,
          $Res Function(_$DangerZoneModelImpl) then) =
      __$$DangerZoneModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double latitude, double longitude, String riskLevel, int alertCount});
}

/// @nodoc
class __$$DangerZoneModelImplCopyWithImpl<$Res>
    extends _$DangerZoneModelCopyWithImpl<$Res, _$DangerZoneModelImpl>
    implements _$$DangerZoneModelImplCopyWith<$Res> {
  __$$DangerZoneModelImplCopyWithImpl(
      _$DangerZoneModelImpl _value, $Res Function(_$DangerZoneModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? riskLevel = null,
    Object? alertCount = null,
  }) {
    return _then(_$DangerZoneModelImpl(
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
              as String,
      alertCount: null == alertCount
          ? _value.alertCount
          : alertCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DangerZoneModelImpl extends _DangerZoneModel {
  const _$DangerZoneModelImpl(
      {required this.latitude,
      required this.longitude,
      required this.riskLevel,
      this.alertCount = 0})
      : super._();

  factory _$DangerZoneModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DangerZoneModelImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String riskLevel;
  @override
  @JsonKey()
  final int alertCount;

  @override
  String toString() {
    return 'DangerZoneModel(latitude: $latitude, longitude: $longitude, riskLevel: $riskLevel, alertCount: $alertCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DangerZoneModelImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.alertCount, alertCount) ||
                other.alertCount == alertCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, riskLevel, alertCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DangerZoneModelImplCopyWith<_$DangerZoneModelImpl> get copyWith =>
      __$$DangerZoneModelImplCopyWithImpl<_$DangerZoneModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DangerZoneModelImplToJson(
      this,
    );
  }
}

abstract class _DangerZoneModel extends DangerZoneModel {
  const factory _DangerZoneModel(
      {required final double latitude,
      required final double longitude,
      required final String riskLevel,
      final int alertCount}) = _$DangerZoneModelImpl;
  const _DangerZoneModel._() : super._();

  factory _DangerZoneModel.fromJson(Map<String, dynamic> json) =
      _$DangerZoneModelImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get riskLevel;
  @override
  int get alertCount;
  @override
  @JsonKey(ignore: true)
  _$$DangerZoneModelImplCopyWith<_$DangerZoneModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
