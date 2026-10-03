// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_invite_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContactInviteModel _$ContactInviteModelFromJson(Map<String, dynamic> json) {
  return _ContactInviteModel.fromJson(json);
}

/// @nodoc
mixin _$ContactInviteModel {
  String get code => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContactInviteModelCopyWith<ContactInviteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactInviteModelCopyWith<$Res> {
  factory $ContactInviteModelCopyWith(
          ContactInviteModel value, $Res Function(ContactInviteModel) then) =
      _$ContactInviteModelCopyWithImpl<$Res, ContactInviteModel>;
  @useResult
  $Res call({String code, @DateTimeConverter() DateTime expiresAt});
}

/// @nodoc
class _$ContactInviteModelCopyWithImpl<$Res, $Val extends ContactInviteModel>
    implements $ContactInviteModelCopyWith<$Res> {
  _$ContactInviteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? expiresAt = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactInviteModelImplCopyWith<$Res>
    implements $ContactInviteModelCopyWith<$Res> {
  factory _$$ContactInviteModelImplCopyWith(_$ContactInviteModelImpl value,
          $Res Function(_$ContactInviteModelImpl) then) =
      __$$ContactInviteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, @DateTimeConverter() DateTime expiresAt});
}

/// @nodoc
class __$$ContactInviteModelImplCopyWithImpl<$Res>
    extends _$ContactInviteModelCopyWithImpl<$Res, _$ContactInviteModelImpl>
    implements _$$ContactInviteModelImplCopyWith<$Res> {
  __$$ContactInviteModelImplCopyWithImpl(_$ContactInviteModelImpl _value,
      $Res Function(_$ContactInviteModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? expiresAt = null,
  }) {
    return _then(_$ContactInviteModelImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactInviteModelImpl extends _ContactInviteModel {
  const _$ContactInviteModelImpl(
      {required this.code, @DateTimeConverter() required this.expiresAt})
      : super._();

  factory _$ContactInviteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactInviteModelImplFromJson(json);

  @override
  final String code;
  @override
  @DateTimeConverter()
  final DateTime expiresAt;

  @override
  String toString() {
    return 'ContactInviteModel(code: $code, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactInviteModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, expiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactInviteModelImplCopyWith<_$ContactInviteModelImpl> get copyWith =>
      __$$ContactInviteModelImplCopyWithImpl<_$ContactInviteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactInviteModelImplToJson(
      this,
    );
  }
}

abstract class _ContactInviteModel extends ContactInviteModel {
  const factory _ContactInviteModel(
          {required final String code,
          @DateTimeConverter() required final DateTime expiresAt}) =
      _$ContactInviteModelImpl;
  const _ContactInviteModel._() : super._();

  factory _ContactInviteModel.fromJson(Map<String, dynamic> json) =
      _$ContactInviteModelImpl.fromJson;

  @override
  String get code;
  @override
  @DateTimeConverter()
  DateTime get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$ContactInviteModelImplCopyWith<_$ContactInviteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
