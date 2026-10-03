// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_verification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminVerificationModel _$AdminVerificationModelFromJson(
    Map<String, dynamic> json) {
  return _AdminVerificationModel.fromJson(json);
}

/// @nodoc
mixin _$AdminVerificationModel {
  String get id => throw _privateConstructorUsedError;
  String get userUid => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userEmail => throw _privateConstructorUsedError;
  String get userPhone => throw _privateConstructorUsedError;
  String get userType => throw _privateConstructorUsedError;
  @NullableDateTimeConverter()
  DateTime? get reviewedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdminVerificationModelCopyWith<AdminVerificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminVerificationModelCopyWith<$Res> {
  factory $AdminVerificationModelCopyWith(AdminVerificationModel value,
          $Res Function(AdminVerificationModel) then) =
      _$AdminVerificationModelCopyWithImpl<$Res, AdminVerificationModel>;
  @useResult
  $Res call(
      {String id,
      String userUid,
      String status,
      String note,
      @DateTimeConverter() DateTime createdAt,
      String userName,
      String userEmail,
      String userPhone,
      String userType,
      @NullableDateTimeConverter() DateTime? reviewedAt});
}

/// @nodoc
class _$AdminVerificationModelCopyWithImpl<$Res,
        $Val extends AdminVerificationModel>
    implements $AdminVerificationModelCopyWith<$Res> {
  _$AdminVerificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userUid = null,
    Object? status = null,
    Object? note = null,
    Object? createdAt = null,
    Object? userName = null,
    Object? userEmail = null,
    Object? userPhone = null,
    Object? userType = null,
    Object? reviewedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: null == userUid
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      userPhone: null == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminVerificationModelImplCopyWith<$Res>
    implements $AdminVerificationModelCopyWith<$Res> {
  factory _$$AdminVerificationModelImplCopyWith(
          _$AdminVerificationModelImpl value,
          $Res Function(_$AdminVerificationModelImpl) then) =
      __$$AdminVerificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userUid,
      String status,
      String note,
      @DateTimeConverter() DateTime createdAt,
      String userName,
      String userEmail,
      String userPhone,
      String userType,
      @NullableDateTimeConverter() DateTime? reviewedAt});
}

/// @nodoc
class __$$AdminVerificationModelImplCopyWithImpl<$Res>
    extends _$AdminVerificationModelCopyWithImpl<$Res,
        _$AdminVerificationModelImpl>
    implements _$$AdminVerificationModelImplCopyWith<$Res> {
  __$$AdminVerificationModelImplCopyWithImpl(
      _$AdminVerificationModelImpl _value,
      $Res Function(_$AdminVerificationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userUid = null,
    Object? status = null,
    Object? note = null,
    Object? createdAt = null,
    Object? userName = null,
    Object? userEmail = null,
    Object? userPhone = null,
    Object? userType = null,
    Object? reviewedAt = freezed,
  }) {
    return _then(_$AdminVerificationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: null == userUid
          ? _value.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userEmail: null == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String,
      userPhone: null == userPhone
          ? _value.userPhone
          : userPhone // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminVerificationModelImpl extends _AdminVerificationModel {
  const _$AdminVerificationModelImpl(
      {this.id = '',
      this.userUid = '',
      this.status = '',
      this.note = '',
      @DateTimeConverter() required this.createdAt,
      this.userName = '',
      this.userEmail = '',
      this.userPhone = '',
      this.userType = '',
      @NullableDateTimeConverter() this.reviewedAt})
      : super._();

  factory _$AdminVerificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminVerificationModelImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String userUid;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String note;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String userEmail;
  @override
  @JsonKey()
  final String userPhone;
  @override
  @JsonKey()
  final String userType;
  @override
  @NullableDateTimeConverter()
  final DateTime? reviewedAt;

  @override
  String toString() {
    return 'AdminVerificationModel(id: $id, userUid: $userUid, status: $status, note: $note, createdAt: $createdAt, userName: $userName, userEmail: $userEmail, userPhone: $userPhone, userType: $userType, reviewedAt: $reviewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminVerificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userUid, userUid) || other.userUid == userUid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userUid, status, note,
      createdAt, userName, userEmail, userPhone, userType, reviewedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminVerificationModelImplCopyWith<_$AdminVerificationModelImpl>
      get copyWith => __$$AdminVerificationModelImplCopyWithImpl<
          _$AdminVerificationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminVerificationModelImplToJson(
      this,
    );
  }
}

abstract class _AdminVerificationModel extends AdminVerificationModel {
  const factory _AdminVerificationModel(
          {final String id,
          final String userUid,
          final String status,
          final String note,
          @DateTimeConverter() required final DateTime createdAt,
          final String userName,
          final String userEmail,
          final String userPhone,
          final String userType,
          @NullableDateTimeConverter() final DateTime? reviewedAt}) =
      _$AdminVerificationModelImpl;
  const _AdminVerificationModel._() : super._();

  factory _AdminVerificationModel.fromJson(Map<String, dynamic> json) =
      _$AdminVerificationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userUid;
  @override
  String get status;
  @override
  String get note;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  String get userName;
  @override
  String get userEmail;
  @override
  String get userPhone;
  @override
  String get userType;
  @override
  @NullableDateTimeConverter()
  DateTime? get reviewedAt;
  @override
  @JsonKey(ignore: true)
  _$$AdminVerificationModelImplCopyWith<_$AdminVerificationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
