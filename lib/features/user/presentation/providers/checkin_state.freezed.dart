// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkin_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckInState {
  CheckInStatus get status => throw _privateConstructorUsedError;
  int get totalSeconds => throw _privateConstructorUsedError;
  int get remainingSeconds => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckInStateCopyWith<CheckInState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInStateCopyWith<$Res> {
  factory $CheckInStateCopyWith(
          CheckInState value, $Res Function(CheckInState) then) =
      _$CheckInStateCopyWithImpl<$Res, CheckInState>;
  @useResult
  $Res call({CheckInStatus status, int totalSeconds, int remainingSeconds});
}

/// @nodoc
class _$CheckInStateCopyWithImpl<$Res, $Val extends CheckInState>
    implements $CheckInStateCopyWith<$Res> {
  _$CheckInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? totalSeconds = null,
    Object? remainingSeconds = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CheckInStatus,
      totalSeconds: null == totalSeconds
          ? _value.totalSeconds
          : totalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      remainingSeconds: null == remainingSeconds
          ? _value.remainingSeconds
          : remainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckInStateImplCopyWith<$Res>
    implements $CheckInStateCopyWith<$Res> {
  factory _$$CheckInStateImplCopyWith(
          _$CheckInStateImpl value, $Res Function(_$CheckInStateImpl) then) =
      __$$CheckInStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CheckInStatus status, int totalSeconds, int remainingSeconds});
}

/// @nodoc
class __$$CheckInStateImplCopyWithImpl<$Res>
    extends _$CheckInStateCopyWithImpl<$Res, _$CheckInStateImpl>
    implements _$$CheckInStateImplCopyWith<$Res> {
  __$$CheckInStateImplCopyWithImpl(
      _$CheckInStateImpl _value, $Res Function(_$CheckInStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? totalSeconds = null,
    Object? remainingSeconds = null,
  }) {
    return _then(_$CheckInStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CheckInStatus,
      totalSeconds: null == totalSeconds
          ? _value.totalSeconds
          : totalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      remainingSeconds: null == remainingSeconds
          ? _value.remainingSeconds
          : remainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CheckInStateImpl extends _CheckInState {
  const _$CheckInStateImpl(
      {this.status = CheckInStatus.idle,
      this.totalSeconds = 0,
      this.remainingSeconds = 0})
      : super._();

  @override
  @JsonKey()
  final CheckInStatus status;
  @override
  @JsonKey()
  final int totalSeconds;
  @override
  @JsonKey()
  final int remainingSeconds;

  @override
  String toString() {
    return 'CheckInState(status: $status, totalSeconds: $totalSeconds, remainingSeconds: $remainingSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalSeconds, totalSeconds) ||
                other.totalSeconds == totalSeconds) &&
            (identical(other.remainingSeconds, remainingSeconds) ||
                other.remainingSeconds == remainingSeconds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, totalSeconds, remainingSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInStateImplCopyWith<_$CheckInStateImpl> get copyWith =>
      __$$CheckInStateImplCopyWithImpl<_$CheckInStateImpl>(this, _$identity);
}

abstract class _CheckInState extends CheckInState {
  const factory _CheckInState(
      {final CheckInStatus status,
      final int totalSeconds,
      final int remainingSeconds}) = _$CheckInStateImpl;
  const _CheckInState._() : super._();

  @override
  CheckInStatus get status;
  @override
  int get totalSeconds;
  @override
  int get remainingSeconds;
  @override
  @JsonKey(ignore: true)
  _$$CheckInStateImplCopyWith<_$CheckInStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
