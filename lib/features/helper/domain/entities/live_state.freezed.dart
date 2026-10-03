// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LiveState {
  LiveAlertStatus get status => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  ResponseStage get stage => throw _privateConstructorUsedError;
  bool get duressActive => throw _privateConstructorUsedError;
  bool get connectivityLost => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LiveStateCopyWith<LiveState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveStateCopyWith<$Res> {
  factory $LiveStateCopyWith(LiveState value, $Res Function(LiveState) then) =
      _$LiveStateCopyWithImpl<$Res, LiveState>;
  @useResult
  $Res call(
      {LiveAlertStatus status,
      double? latitude,
      double? longitude,
      DateTime? updatedAt,
      ResponseStage stage,
      bool duressActive,
      bool connectivityLost});
}

/// @nodoc
class _$LiveStateCopyWithImpl<$Res, $Val extends LiveState>
    implements $LiveStateCopyWith<$Res> {
  _$LiveStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? updatedAt = freezed,
    Object? stage = null,
    Object? duressActive = null,
    Object? connectivityLost = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LiveAlertStatus,
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
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as ResponseStage,
      duressActive: null == duressActive
          ? _value.duressActive
          : duressActive // ignore: cast_nullable_to_non_nullable
              as bool,
      connectivityLost: null == connectivityLost
          ? _value.connectivityLost
          : connectivityLost // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveStateImplCopyWith<$Res>
    implements $LiveStateCopyWith<$Res> {
  factory _$$LiveStateImplCopyWith(
          _$LiveStateImpl value, $Res Function(_$LiveStateImpl) then) =
      __$$LiveStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LiveAlertStatus status,
      double? latitude,
      double? longitude,
      DateTime? updatedAt,
      ResponseStage stage,
      bool duressActive,
      bool connectivityLost});
}

/// @nodoc
class __$$LiveStateImplCopyWithImpl<$Res>
    extends _$LiveStateCopyWithImpl<$Res, _$LiveStateImpl>
    implements _$$LiveStateImplCopyWith<$Res> {
  __$$LiveStateImplCopyWithImpl(
      _$LiveStateImpl _value, $Res Function(_$LiveStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? updatedAt = freezed,
    Object? stage = null,
    Object? duressActive = null,
    Object? connectivityLost = null,
  }) {
    return _then(_$LiveStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LiveAlertStatus,
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
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as ResponseStage,
      duressActive: null == duressActive
          ? _value.duressActive
          : duressActive // ignore: cast_nullable_to_non_nullable
              as bool,
      connectivityLost: null == connectivityLost
          ? _value.connectivityLost
          : connectivityLost // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LiveStateImpl extends _LiveState {
  const _$LiveStateImpl(
      {required this.status,
      this.latitude,
      this.longitude,
      this.updatedAt,
      this.stage = ResponseStage.none,
      this.duressActive = false,
      this.connectivityLost = false})
      : super._();

  @override
  final LiveAlertStatus status;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final ResponseStage stage;
  @override
  @JsonKey()
  final bool duressActive;
  @override
  @JsonKey()
  final bool connectivityLost;

  @override
  String toString() {
    return 'LiveState(status: $status, latitude: $latitude, longitude: $longitude, updatedAt: $updatedAt, stage: $stage, duressActive: $duressActive, connectivityLost: $connectivityLost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.duressActive, duressActive) ||
                other.duressActive == duressActive) &&
            (identical(other.connectivityLost, connectivityLost) ||
                other.connectivityLost == connectivityLost));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, latitude, longitude,
      updatedAt, stage, duressActive, connectivityLost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveStateImplCopyWith<_$LiveStateImpl> get copyWith =>
      __$$LiveStateImplCopyWithImpl<_$LiveStateImpl>(this, _$identity);
}

abstract class _LiveState extends LiveState {
  const factory _LiveState(
      {required final LiveAlertStatus status,
      final double? latitude,
      final double? longitude,
      final DateTime? updatedAt,
      final ResponseStage stage,
      final bool duressActive,
      final bool connectivityLost}) = _$LiveStateImpl;
  const _LiveState._() : super._();

  @override
  LiveAlertStatus get status;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  DateTime? get updatedAt;
  @override
  ResponseStage get stage;
  @override
  bool get duressActive;
  @override
  bool get connectivityLost;
  @override
  @JsonKey(ignore: true)
  _$$LiveStateImplCopyWith<_$LiveStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
