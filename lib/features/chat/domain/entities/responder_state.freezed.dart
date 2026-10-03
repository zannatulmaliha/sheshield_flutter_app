// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'responder_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResponderState {
  String get status => throw _privateConstructorUsedError;
  bool get helperAccepted => throw _privateConstructorUsedError;
  ResponderProgress get progress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResponderStateCopyWith<ResponderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponderStateCopyWith<$Res> {
  factory $ResponderStateCopyWith(
          ResponderState value, $Res Function(ResponderState) then) =
      _$ResponderStateCopyWithImpl<$Res, ResponderState>;
  @useResult
  $Res call({String status, bool helperAccepted, ResponderProgress progress});
}

/// @nodoc
class _$ResponderStateCopyWithImpl<$Res, $Val extends ResponderState>
    implements $ResponderStateCopyWith<$Res> {
  _$ResponderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? helperAccepted = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      helperAccepted: null == helperAccepted
          ? _value.helperAccepted
          : helperAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as ResponderProgress,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResponderStateImplCopyWith<$Res>
    implements $ResponderStateCopyWith<$Res> {
  factory _$$ResponderStateImplCopyWith(_$ResponderStateImpl value,
          $Res Function(_$ResponderStateImpl) then) =
      __$$ResponderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, bool helperAccepted, ResponderProgress progress});
}

/// @nodoc
class __$$ResponderStateImplCopyWithImpl<$Res>
    extends _$ResponderStateCopyWithImpl<$Res, _$ResponderStateImpl>
    implements _$$ResponderStateImplCopyWith<$Res> {
  __$$ResponderStateImplCopyWithImpl(
      _$ResponderStateImpl _value, $Res Function(_$ResponderStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? helperAccepted = null,
    Object? progress = null,
  }) {
    return _then(_$ResponderStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      helperAccepted: null == helperAccepted
          ? _value.helperAccepted
          : helperAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as ResponderProgress,
    ));
  }
}

/// @nodoc

class _$ResponderStateImpl implements _ResponderState {
  const _$ResponderStateImpl(
      {required this.status,
      required this.helperAccepted,
      required this.progress});

  @override
  final String status;
  @override
  final bool helperAccepted;
  @override
  final ResponderProgress progress;

  @override
  String toString() {
    return 'ResponderState(status: $status, helperAccepted: $helperAccepted, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponderStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.helperAccepted, helperAccepted) ||
                other.helperAccepted == helperAccepted) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, helperAccepted, progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponderStateImplCopyWith<_$ResponderStateImpl> get copyWith =>
      __$$ResponderStateImplCopyWithImpl<_$ResponderStateImpl>(
          this, _$identity);
}

abstract class _ResponderState implements ResponderState {
  const factory _ResponderState(
      {required final String status,
      required final bool helperAccepted,
      required final ResponderProgress progress}) = _$ResponderStateImpl;

  @override
  String get status;
  @override
  bool get helperAccepted;
  @override
  ResponderProgress get progress;
  @override
  @JsonKey(ignore: true)
  _$$ResponderStateImplCopyWith<_$ResponderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
