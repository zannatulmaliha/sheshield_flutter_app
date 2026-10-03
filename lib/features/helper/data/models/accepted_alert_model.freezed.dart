// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accepted_alert_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AcceptedAlertModel _$AcceptedAlertModelFromJson(Map<String, dynamic> json) {
  return _AcceptedAlertModel.fromJson(json);
}

/// @nodoc
mixin _$AcceptedAlertModel {
  String get id => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get acceptedAt => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;
  String get requesterUid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AcceptedAlertModelCopyWith<AcceptedAlertModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcceptedAlertModelCopyWith<$Res> {
  factory $AcceptedAlertModelCopyWith(
          AcceptedAlertModel value, $Res Function(AcceptedAlertModel) then) =
      _$AcceptedAlertModelCopyWithImpl<$Res, AcceptedAlertModel>;
  @useResult
  $Res call(
      {String id,
      String userName,
      String phone,
      double latitude,
      double longitude,
      @DateTimeConverter() DateTime acceptedAt,
      String countryCode,
      String requesterUid});
}

/// @nodoc
class _$AcceptedAlertModelCopyWithImpl<$Res, $Val extends AcceptedAlertModel>
    implements $AcceptedAlertModelCopyWith<$Res> {
  _$AcceptedAlertModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? phone = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? acceptedAt = null,
    Object? countryCode = null,
    Object? requesterUid = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      acceptedAt: null == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      requesterUid: null == requesterUid
          ? _value.requesterUid
          : requesterUid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AcceptedAlertModelImplCopyWith<$Res>
    implements $AcceptedAlertModelCopyWith<$Res> {
  factory _$$AcceptedAlertModelImplCopyWith(_$AcceptedAlertModelImpl value,
          $Res Function(_$AcceptedAlertModelImpl) then) =
      __$$AcceptedAlertModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userName,
      String phone,
      double latitude,
      double longitude,
      @DateTimeConverter() DateTime acceptedAt,
      String countryCode,
      String requesterUid});
}

/// @nodoc
class __$$AcceptedAlertModelImplCopyWithImpl<$Res>
    extends _$AcceptedAlertModelCopyWithImpl<$Res, _$AcceptedAlertModelImpl>
    implements _$$AcceptedAlertModelImplCopyWith<$Res> {
  __$$AcceptedAlertModelImplCopyWithImpl(_$AcceptedAlertModelImpl _value,
      $Res Function(_$AcceptedAlertModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? phone = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? acceptedAt = null,
    Object? countryCode = null,
    Object? requesterUid = null,
  }) {
    return _then(_$AcceptedAlertModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      acceptedAt: null == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      requesterUid: null == requesterUid
          ? _value.requesterUid
          : requesterUid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AcceptedAlertModelImpl extends _AcceptedAlertModel {
  const _$AcceptedAlertModelImpl(
      {required this.id,
      required this.userName,
      required this.phone,
      required this.latitude,
      required this.longitude,
      @DateTimeConverter() required this.acceptedAt,
      this.countryCode = '',
      this.requesterUid = ''})
      : super._();

  factory _$AcceptedAlertModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AcceptedAlertModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userName;
  @override
  final String phone;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @DateTimeConverter()
  final DateTime acceptedAt;
  @override
  @JsonKey()
  final String countryCode;
  @override
  @JsonKey()
  final String requesterUid;

  @override
  String toString() {
    return 'AcceptedAlertModel(id: $id, userName: $userName, phone: $phone, latitude: $latitude, longitude: $longitude, acceptedAt: $acceptedAt, countryCode: $countryCode, requesterUid: $requesterUid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptedAlertModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.requesterUid, requesterUid) ||
                other.requesterUid == requesterUid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userName, phone, latitude,
      longitude, acceptedAt, countryCode, requesterUid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptedAlertModelImplCopyWith<_$AcceptedAlertModelImpl> get copyWith =>
      __$$AcceptedAlertModelImplCopyWithImpl<_$AcceptedAlertModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AcceptedAlertModelImplToJson(
      this,
    );
  }
}

abstract class _AcceptedAlertModel extends AcceptedAlertModel {
  const factory _AcceptedAlertModel(
      {required final String id,
      required final String userName,
      required final String phone,
      required final double latitude,
      required final double longitude,
      @DateTimeConverter() required final DateTime acceptedAt,
      final String countryCode,
      final String requesterUid}) = _$AcceptedAlertModelImpl;
  const _AcceptedAlertModel._() : super._();

  factory _AcceptedAlertModel.fromJson(Map<String, dynamic> json) =
      _$AcceptedAlertModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userName;
  @override
  String get phone;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @DateTimeConverter()
  DateTime get acceptedAt;
  @override
  String get countryCode;
  @override
  String get requesterUid;
  @override
  @JsonKey(ignore: true)
  _$$AcceptedAlertModelImplCopyWith<_$AcceptedAlertModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
