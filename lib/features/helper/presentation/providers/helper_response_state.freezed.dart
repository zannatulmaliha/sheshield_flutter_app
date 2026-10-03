// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'helper_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HelperResponseState {
  ResponseStage get stage => throw _privateConstructorUsedError;
  LiveState? get live => throw _privateConstructorUsedError;

  /// Set once, when the response is over; polling stops at that point.
  HelperResponseEnd? get ended => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HelperResponseStateCopyWith<HelperResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelperResponseStateCopyWith<$Res> {
  factory $HelperResponseStateCopyWith(
          HelperResponseState value, $Res Function(HelperResponseState) then) =
      _$HelperResponseStateCopyWithImpl<$Res, HelperResponseState>;
  @useResult
  $Res call({ResponseStage stage, LiveState? live, HelperResponseEnd? ended});

  $LiveStateCopyWith<$Res>? get live;
}

/// @nodoc
class _$HelperResponseStateCopyWithImpl<$Res, $Val extends HelperResponseState>
    implements $HelperResponseStateCopyWith<$Res> {
  _$HelperResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = null,
    Object? live = freezed,
    Object? ended = freezed,
  }) {
    return _then(_value.copyWith(
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as ResponseStage,
      live: freezed == live
          ? _value.live
          : live // ignore: cast_nullable_to_non_nullable
              as LiveState?,
      ended: freezed == ended
          ? _value.ended
          : ended // ignore: cast_nullable_to_non_nullable
              as HelperResponseEnd?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LiveStateCopyWith<$Res>? get live {
    if (_value.live == null) {
      return null;
    }

    return $LiveStateCopyWith<$Res>(_value.live!, (value) {
      return _then(_value.copyWith(live: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HelperResponseStateImplCopyWith<$Res>
    implements $HelperResponseStateCopyWith<$Res> {
  factory _$$HelperResponseStateImplCopyWith(_$HelperResponseStateImpl value,
          $Res Function(_$HelperResponseStateImpl) then) =
      __$$HelperResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ResponseStage stage, LiveState? live, HelperResponseEnd? ended});

  @override
  $LiveStateCopyWith<$Res>? get live;
}

/// @nodoc
class __$$HelperResponseStateImplCopyWithImpl<$Res>
    extends _$HelperResponseStateCopyWithImpl<$Res, _$HelperResponseStateImpl>
    implements _$$HelperResponseStateImplCopyWith<$Res> {
  __$$HelperResponseStateImplCopyWithImpl(_$HelperResponseStateImpl _value,
      $Res Function(_$HelperResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stage = null,
    Object? live = freezed,
    Object? ended = freezed,
  }) {
    return _then(_$HelperResponseStateImpl(
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as ResponseStage,
      live: freezed == live
          ? _value.live
          : live // ignore: cast_nullable_to_non_nullable
              as LiveState?,
      ended: freezed == ended
          ? _value.ended
          : ended // ignore: cast_nullable_to_non_nullable
              as HelperResponseEnd?,
    ));
  }
}

/// @nodoc

class _$HelperResponseStateImpl implements _HelperResponseState {
  const _$HelperResponseStateImpl({required this.stage, this.live, this.ended});

  @override
  final ResponseStage stage;
  @override
  final LiveState? live;

  /// Set once, when the response is over; polling stops at that point.
  @override
  final HelperResponseEnd? ended;

  @override
  String toString() {
    return 'HelperResponseState(stage: $stage, live: $live, ended: $ended)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HelperResponseStateImpl &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.live, live) || other.live == live) &&
            (identical(other.ended, ended) || other.ended == ended));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stage, live, ended);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HelperResponseStateImplCopyWith<_$HelperResponseStateImpl> get copyWith =>
      __$$HelperResponseStateImplCopyWithImpl<_$HelperResponseStateImpl>(
          this, _$identity);
}

abstract class _HelperResponseState implements HelperResponseState {
  const factory _HelperResponseState(
      {required final ResponseStage stage,
      final LiveState? live,
      final HelperResponseEnd? ended}) = _$HelperResponseStateImpl;

  @override
  ResponseStage get stage;
  @override
  LiveState? get live;
  @override

  /// Set once, when the response is over; polling stops at that point.
  HelperResponseEnd? get ended;
  @override
  @JsonKey(ignore: true)
  _$$HelperResponseStateImplCopyWith<_$HelperResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
