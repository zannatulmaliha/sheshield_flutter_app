// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'safety_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SafetyStatusModel _$SafetyStatusModelFromJson(Map<String, dynamic> json) {
  return _SafetyStatusModel.fromJson(json);
}

/// @nodoc
mixin _$SafetyStatusModel {
  bool get duressActive => throw _privateConstructorUsedError;
  bool get connectivityLost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SafetyStatusModelCopyWith<SafetyStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SafetyStatusModelCopyWith<$Res> {
  factory $SafetyStatusModelCopyWith(
          SafetyStatusModel value, $Res Function(SafetyStatusModel) then) =
      _$SafetyStatusModelCopyWithImpl<$Res, SafetyStatusModel>;
  @useResult
  $Res call({bool duressActive, bool connectivityLost});
}

/// @nodoc
class _$SafetyStatusModelCopyWithImpl<$Res, $Val extends SafetyStatusModel>
    implements $SafetyStatusModelCopyWith<$Res> {
  _$SafetyStatusModelCopyWithImpl(this._value, this._then);

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
abstract class _$$SafetyStatusModelImplCopyWith<$Res>
    implements $SafetyStatusModelCopyWith<$Res> {
  factory _$$SafetyStatusModelImplCopyWith(_$SafetyStatusModelImpl value,
          $Res Function(_$SafetyStatusModelImpl) then) =
      __$$SafetyStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool duressActive, bool connectivityLost});
}

/// @nodoc
class __$$SafetyStatusModelImplCopyWithImpl<$Res>
    extends _$SafetyStatusModelCopyWithImpl<$Res, _$SafetyStatusModelImpl>
    implements _$$SafetyStatusModelImplCopyWith<$Res> {
  __$$SafetyStatusModelImplCopyWithImpl(_$SafetyStatusModelImpl _value,
      $Res Function(_$SafetyStatusModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duressActive = null,
    Object? connectivityLost = null,
  }) {
    return _then(_$SafetyStatusModelImpl(
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
@JsonSerializable()
class _$SafetyStatusModelImpl extends _SafetyStatusModel {
  const _$SafetyStatusModelImpl(
      {this.duressActive = false, this.connectivityLost = false})
      : super._();

  factory _$SafetyStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SafetyStatusModelImplFromJson(json);

  @override
  @JsonKey()
  final bool duressActive;
  @override
  @JsonKey()
  final bool connectivityLost;

  @override
  String toString() {
    return 'SafetyStatusModel(duressActive: $duressActive, connectivityLost: $connectivityLost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SafetyStatusModelImpl &&
            (identical(other.duressActive, duressActive) ||
                other.duressActive == duressActive) &&
            (identical(other.connectivityLost, connectivityLost) ||
                other.connectivityLost == connectivityLost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, duressActive, connectivityLost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SafetyStatusModelImplCopyWith<_$SafetyStatusModelImpl> get copyWith =>
      __$$SafetyStatusModelImplCopyWithImpl<_$SafetyStatusModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SafetyStatusModelImplToJson(
      this,
    );
  }
}

abstract class _SafetyStatusModel extends SafetyStatusModel {
  const factory _SafetyStatusModel(
      {final bool duressActive,
      final bool connectivityLost}) = _$SafetyStatusModelImpl;
  const _SafetyStatusModel._() : super._();

  factory _SafetyStatusModel.fromJson(Map<String, dynamic> json) =
      _$SafetyStatusModelImpl.fromJson;

  @override
  bool get duressActive;
  @override
  bool get connectivityLost;
  @override
  @JsonKey(ignore: true)
  _$$SafetyStatusModelImplCopyWith<_$SafetyStatusModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
