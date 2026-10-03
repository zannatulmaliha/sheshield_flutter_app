// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accepted_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AcceptedAlert {
  String get id => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  DateTime get acceptedAt => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;
  String get requesterUid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AcceptedAlertCopyWith<AcceptedAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcceptedAlertCopyWith<$Res> {
  factory $AcceptedAlertCopyWith(
          AcceptedAlert value, $Res Function(AcceptedAlert) then) =
      _$AcceptedAlertCopyWithImpl<$Res, AcceptedAlert>;
  @useResult
  $Res call(
      {String id,
      String userName,
      String phone,
      double latitude,
      double longitude,
      DateTime acceptedAt,
      String countryCode,
      String requesterUid});
}

/// @nodoc
class _$AcceptedAlertCopyWithImpl<$Res, $Val extends AcceptedAlert>
    implements $AcceptedAlertCopyWith<$Res> {
  _$AcceptedAlertCopyWithImpl(this._value, this._then);

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
abstract class _$$AcceptedAlertImplCopyWith<$Res>
    implements $AcceptedAlertCopyWith<$Res> {
  factory _$$AcceptedAlertImplCopyWith(
          _$AcceptedAlertImpl value, $Res Function(_$AcceptedAlertImpl) then) =
      __$$AcceptedAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userName,
      String phone,
      double latitude,
      double longitude,
      DateTime acceptedAt,
      String countryCode,
      String requesterUid});
}

/// @nodoc
class __$$AcceptedAlertImplCopyWithImpl<$Res>
    extends _$AcceptedAlertCopyWithImpl<$Res, _$AcceptedAlertImpl>
    implements _$$AcceptedAlertImplCopyWith<$Res> {
  __$$AcceptedAlertImplCopyWithImpl(
      _$AcceptedAlertImpl _value, $Res Function(_$AcceptedAlertImpl) _then)
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
    return _then(_$AcceptedAlertImpl(
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

class _$AcceptedAlertImpl extends _AcceptedAlert {
  const _$AcceptedAlertImpl(
      {required this.id,
      required this.userName,
      required this.phone,
      required this.latitude,
      required this.longitude,
      required this.acceptedAt,
      this.countryCode = '',
      this.requesterUid = ''})
      : super._();

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
  final DateTime acceptedAt;
  @override
  @JsonKey()
  final String countryCode;
  @override
  @JsonKey()
  final String requesterUid;

  @override
  String toString() {
    return 'AcceptedAlert(id: $id, userName: $userName, phone: $phone, latitude: $latitude, longitude: $longitude, acceptedAt: $acceptedAt, countryCode: $countryCode, requesterUid: $requesterUid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcceptedAlertImpl &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, userName, phone, latitude,
      longitude, acceptedAt, countryCode, requesterUid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AcceptedAlertImplCopyWith<_$AcceptedAlertImpl> get copyWith =>
      __$$AcceptedAlertImplCopyWithImpl<_$AcceptedAlertImpl>(this, _$identity);
}

abstract class _AcceptedAlert extends AcceptedAlert {
  const factory _AcceptedAlert(
      {required final String id,
      required final String userName,
      required final String phone,
      required final double latitude,
      required final double longitude,
      required final DateTime acceptedAt,
      final String countryCode,
      final String requesterUid}) = _$AcceptedAlertImpl;
  const _AcceptedAlert._() : super._();

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
  DateTime get acceptedAt;
  @override
  String get countryCode;
  @override
  String get requesterUid;
  @override
  @JsonKey(ignore: true)
  _$$AcceptedAlertImplCopyWith<_$AcceptedAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
