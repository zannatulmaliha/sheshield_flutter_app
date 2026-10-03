// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LiveStateModel _$LiveStateModelFromJson(Map<String, dynamic> json) {
  return _LiveStateModel.fromJson(json);
}

/// @nodoc
mixin _$LiveStateModel {
  String get status => throw _privateConstructorUsedError;
  String get progress => throw _privateConstructorUsedError;
  bool get duressActive => throw _privateConstructorUsedError;
  bool get connectivityLost => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @NullableDateTimeConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiveStateModelCopyWith<LiveStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveStateModelCopyWith<$Res> {
  factory $LiveStateModelCopyWith(
          LiveStateModel value, $Res Function(LiveStateModel) then) =
      _$LiveStateModelCopyWithImpl<$Res, LiveStateModel>;
  @useResult
  $Res call(
      {String status,
      String progress,
      bool duressActive,
      bool connectivityLost,
      double? latitude,
      double? longitude,
      @NullableDateTimeConverter() DateTime? updatedAt});
}

/// @nodoc
class _$LiveStateModelCopyWithImpl<$Res, $Val extends LiveStateModel>
    implements $LiveStateModelCopyWith<$Res> {
  _$LiveStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? progress = null,
    Object? duressActive = null,
    Object? connectivityLost = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as String,
      duressActive: null == duressActive
          ? _value.duressActive
          : duressActive // ignore: cast_nullable_to_non_nullable
              as bool,
      connectivityLost: null == connectivityLost
          ? _value.connectivityLost
          : connectivityLost // ignore: cast_nullable_to_non_nullable
              as bool,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveStateModelImplCopyWith<$Res>
    implements $LiveStateModelCopyWith<$Res> {
  factory _$$LiveStateModelImplCopyWith(_$LiveStateModelImpl value,
          $Res Function(_$LiveStateModelImpl) then) =
      __$$LiveStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String progress,
      bool duressActive,
      bool connectivityLost,
      double? latitude,
      double? longitude,
      @NullableDateTimeConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$LiveStateModelImplCopyWithImpl<$Res>
    extends _$LiveStateModelCopyWithImpl<$Res, _$LiveStateModelImpl>
    implements _$$LiveStateModelImplCopyWith<$Res> {
  __$$LiveStateModelImplCopyWithImpl(
      _$LiveStateModelImpl _value, $Res Function(_$LiveStateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? progress = null,
    Object? duressActive = null,
    Object? connectivityLost = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$LiveStateModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as String,
      duressActive: null == duressActive
          ? _value.duressActive
          : duressActive // ignore: cast_nullable_to_non_nullable
              as bool,
      connectivityLost: null == connectivityLost
          ? _value.connectivityLost
          : connectivityLost // ignore: cast_nullable_to_non_nullable
              as bool,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveStateModelImpl extends _LiveStateModel {
  const _$LiveStateModelImpl(
      {this.status = 'accepted',
      this.progress = '',
      this.duressActive = false,
      this.connectivityLost = false,
      this.latitude,
      this.longitude,
      @NullableDateTimeConverter() this.updatedAt})
      : super._();

  factory _$LiveStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveStateModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String progress;
  @override
  @JsonKey()
  final bool duressActive;
  @override
  @JsonKey()
  final bool connectivityLost;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @NullableDateTimeConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LiveStateModel(status: $status, progress: $progress, duressActive: $duressActive, connectivityLost: $connectivityLost, latitude: $latitude, longitude: $longitude, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveStateModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.duressActive, duressActive) ||
                other.duressActive == duressActive) &&
            (identical(other.connectivityLost, connectivityLost) ||
                other.connectivityLost == connectivityLost) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, progress, duressActive,
      connectivityLost, latitude, longitude, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveStateModelImplCopyWith<_$LiveStateModelImpl> get copyWith =>
      __$$LiveStateModelImplCopyWithImpl<_$LiveStateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveStateModelImplToJson(
      this,
    );
  }
}

abstract class _LiveStateModel extends LiveStateModel {
  const factory _LiveStateModel(
          {final String status,
          final String progress,
          final bool duressActive,
          final bool connectivityLost,
          final double? latitude,
          final double? longitude,
          @NullableDateTimeConverter() final DateTime? updatedAt}) =
      _$LiveStateModelImpl;
  const _LiveStateModel._() : super._();

  factory _LiveStateModel.fromJson(Map<String, dynamic> json) =
      _$LiveStateModelImpl.fromJson;

  @override
  String get status;
  @override
  String get progress;
  @override
  bool get duressActive;
  @override
  bool get connectivityLost;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @NullableDateTimeConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$LiveStateModelImplCopyWith<_$LiveStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
