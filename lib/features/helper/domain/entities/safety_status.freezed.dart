// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'safety_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SafetyStatus {
  bool get duressActive => throw _privateConstructorUsedError;
  bool get connectivityLost => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SafetyStatusCopyWith<SafetyStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SafetyStatusCopyWith<$Res> {
  factory $SafetyStatusCopyWith(
          SafetyStatus value, $Res Function(SafetyStatus) then) =
      _$SafetyStatusCopyWithImpl<$Res, SafetyStatus>;
  @useResult
  $Res call({bool duressActive, bool connectivityLost});
}

/// @nodoc
class _$SafetyStatusCopyWithImpl<$Res, $Val extends SafetyStatus>
    implements $SafetyStatusCopyWith<$Res> {
  _$SafetyStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duressActive = null,
    Object? connectivityLost = null,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$SafetyStatusImplCopyWith<$Res>
    implements $SafetyStatusCopyWith<$Res> {
  factory _$$SafetyStatusImplCopyWith(
          _$SafetyStatusImpl value, $Res Function(_$SafetyStatusImpl) then) =
      __$$SafetyStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool duressActive, bool connectivityLost});
}

/// @nodoc
class __$$SafetyStatusImplCopyWithImpl<$Res>
    extends _$SafetyStatusCopyWithImpl<$Res, _$SafetyStatusImpl>
    implements _$$SafetyStatusImplCopyWith<$Res> {
  __$$SafetyStatusImplCopyWithImpl(
      _$SafetyStatusImpl _value, $Res Function(_$SafetyStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duressActive = null,
    Object? connectivityLost = null,
  }) {
    return _then(_$SafetyStatusImpl(
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

class _$SafetyStatusImpl implements _SafetyStatus {
  const _$SafetyStatusImpl(
      {required this.duressActive, required this.connectivityLost});

  @override
  final bool duressActive;
  @override
  final bool connectivityLost;

  @override
  String toString() {
    return 'SafetyStatus(duressActive: $duressActive, connectivityLost: $connectivityLost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SafetyStatusImpl &&
            (identical(other.duressActive, duressActive) ||
                other.duressActive == duressActive) &&
            (identical(other.connectivityLost, connectivityLost) ||
                other.connectivityLost == connectivityLost));
  }

  @override
  int get hashCode => Object.hash(runtimeType, duressActive, connectivityLost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SafetyStatusImplCopyWith<_$SafetyStatusImpl> get copyWith =>
      __$$SafetyStatusImplCopyWithImpl<_$SafetyStatusImpl>(this, _$identity);
}

abstract class _SafetyStatus implements SafetyStatus {
  const factory _SafetyStatus(
      {required final bool duressActive,
      required final bool connectivityLost}) = _$SafetyStatusImpl;

  @override
  bool get duressActive;
  @override
  bool get connectivityLost;
  @override
  @JsonKey(ignore: true)
  _$$SafetyStatusImplCopyWith<_$SafetyStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
