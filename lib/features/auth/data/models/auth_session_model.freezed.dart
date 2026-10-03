// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) {
  return _AuthSessionModel.fromJson(json);
}

/// @nodoc
mixin _$AuthSessionModel {
  String get token => throw _privateConstructorUsedError;
  AppUserModel get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthSessionModelCopyWith<AuthSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthSessionModelCopyWith<$Res> {
  factory $AuthSessionModelCopyWith(
          AuthSessionModel value, $Res Function(AuthSessionModel) then) =
      _$AuthSessionModelCopyWithImpl<$Res, AuthSessionModel>;
  @useResult
  $Res call({String token, AppUserModel user});

  $AppUserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$AuthSessionModelCopyWithImpl<$Res, $Val extends AuthSessionModel>
    implements $AuthSessionModelCopyWith<$Res> {
  _$AuthSessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUserModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppUserModelCopyWith<$Res> get user {
    return $AppUserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthSessionModelImplCopyWith<$Res>
    implements $AuthSessionModelCopyWith<$Res> {
  factory _$$AuthSessionModelImplCopyWith(_$AuthSessionModelImpl value,
          $Res Function(_$AuthSessionModelImpl) then) =
      __$$AuthSessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, AppUserModel user});

  @override
  $AppUserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthSessionModelImplCopyWithImpl<$Res>
    extends _$AuthSessionModelCopyWithImpl<$Res, _$AuthSessionModelImpl>
    implements _$$AuthSessionModelImplCopyWith<$Res> {
  __$$AuthSessionModelImplCopyWithImpl(_$AuthSessionModelImpl _value,
      $Res Function(_$AuthSessionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? user = null,
  }) {
    return _then(_$AuthSessionModelImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUserModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthSessionModelImpl implements _AuthSessionModel {
  const _$AuthSessionModelImpl({required this.token, required this.user});

  factory _$AuthSessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthSessionModelImplFromJson(json);

  @override
  final String token;
  @override
  final AppUserModel user;

  @override
  String toString() {
    return 'AuthSessionModel(token: $token, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSessionModelImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSessionModelImplCopyWith<_$AuthSessionModelImpl> get copyWith =>
      __$$AuthSessionModelImplCopyWithImpl<_$AuthSessionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthSessionModelImplToJson(
      this,
    );
  }
}

abstract class _AuthSessionModel implements AuthSessionModel {
  const factory _AuthSessionModel(
      {required final String token,
      required final AppUserModel user}) = _$AuthSessionModelImpl;

  factory _AuthSessionModel.fromJson(Map<String, dynamic> json) =
      _$AuthSessionModelImpl.fromJson;

  @override
  String get token;
  @override
  AppUserModel get user;
  @override
  @JsonKey(ignore: true)
  _$$AuthSessionModelImplCopyWith<_$AuthSessionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
