// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blocked_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BlockedUser _$BlockedUserFromJson(Map<String, dynamic> json) {
  return _BlockedUser.fromJson(json);
}

/// @nodoc
mixin _$BlockedUser {
  String get blockerId => throw _privateConstructorUsedError;
  String get blockedId => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlockedUserCopyWith<BlockedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockedUserCopyWith<$Res> {
  factory $BlockedUserCopyWith(
          BlockedUser value, $Res Function(BlockedUser) then) =
      _$BlockedUserCopyWithImpl<$Res, BlockedUser>;
  @useResult
  $Res call(
      {String blockerId,
      String blockedId,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$BlockedUserCopyWithImpl<$Res, $Val extends BlockedUser>
    implements $BlockedUserCopyWith<$Res> {
  _$BlockedUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blockerId = null,
    Object? blockedId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      blockerId: null == blockerId
          ? _value.blockerId
          : blockerId // ignore: cast_nullable_to_non_nullable
              as String,
      blockedId: null == blockedId
          ? _value.blockedId
          : blockedId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BlockedUserImplCopyWith<$Res>
    implements $BlockedUserCopyWith<$Res> {
  factory _$$BlockedUserImplCopyWith(
          _$BlockedUserImpl value, $Res Function(_$BlockedUserImpl) then) =
      __$$BlockedUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String blockerId,
      String blockedId,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$$BlockedUserImplCopyWithImpl<$Res>
    extends _$BlockedUserCopyWithImpl<$Res, _$BlockedUserImpl>
    implements _$$BlockedUserImplCopyWith<$Res> {
  __$$BlockedUserImplCopyWithImpl(
      _$BlockedUserImpl _value, $Res Function(_$BlockedUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blockerId = null,
    Object? blockedId = null,
    Object? createdAt = null,
  }) {
    return _then(_$BlockedUserImpl(
      blockerId: null == blockerId
          ? _value.blockerId
          : blockerId // ignore: cast_nullable_to_non_nullable
              as String,
      blockedId: null == blockedId
          ? _value.blockedId
          : blockedId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BlockedUserImpl implements _BlockedUser {
  const _$BlockedUserImpl(
      {required this.blockerId,
      required this.blockedId,
      @DateTimeConverter() required this.createdAt});

  factory _$BlockedUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlockedUserImplFromJson(json);

  @override
  final String blockerId;
  @override
  final String blockedId;
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'BlockedUser(blockerId: $blockerId, blockedId: $blockedId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockedUserImpl &&
            (identical(other.blockerId, blockerId) ||
                other.blockerId == blockerId) &&
            (identical(other.blockedId, blockedId) ||
                other.blockedId == blockedId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, blockerId, blockedId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockedUserImplCopyWith<_$BlockedUserImpl> get copyWith =>
      __$$BlockedUserImplCopyWithImpl<_$BlockedUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlockedUserImplToJson(
      this,
    );
  }
}

abstract class _BlockedUser implements BlockedUser {
  const factory _BlockedUser(
          {required final String blockerId,
          required final String blockedId,
          @DateTimeConverter() required final DateTime createdAt}) =
      _$BlockedUserImpl;

  factory _BlockedUser.fromJson(Map<String, dynamic> json) =
      _$BlockedUserImpl.fromJson;

  @override
  String get blockerId;
  @override
  String get blockedId;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$BlockedUserImplCopyWith<_$BlockedUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
