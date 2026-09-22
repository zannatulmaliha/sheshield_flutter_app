// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SosAlert _$SosAlertFromJson(Map<String, dynamic> json) {
  return _SosAlert.fromJson(json);
}

/// @nodoc
mixin _$SosAlert {
  String get id => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<SosDelivery> get deliveries =>
      throw _privateConstructorUsedError; // Public link to the live-tracking page (location + alarm) contacts
// get in their SMS. Null if the server hasn't started sending it yet.
  String? get shareUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SosAlertCopyWith<SosAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosAlertCopyWith<$Res> {
  factory $SosAlertCopyWith(SosAlert value, $Res Function(SosAlert) then) =
      _$SosAlertCopyWithImpl<$Res, SosAlert>;
  @useResult
  $Res call(
      {String id,
      @DateTimeConverter() DateTime createdAt,
      List<SosDelivery> deliveries,
      String? shareUrl});
}

/// @nodoc
class _$SosAlertCopyWithImpl<$Res, $Val extends SosAlert>
    implements $SosAlertCopyWith<$Res> {
  _$SosAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? deliveries = null,
    Object? shareUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deliveries: null == deliveries
          ? _value.deliveries
          : deliveries // ignore: cast_nullable_to_non_nullable
              as List<SosDelivery>,
      shareUrl: freezed == shareUrl
          ? _value.shareUrl
          : shareUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosAlertImplCopyWith<$Res>
    implements $SosAlertCopyWith<$Res> {
  factory _$$SosAlertImplCopyWith(
          _$SosAlertImpl value, $Res Function(_$SosAlertImpl) then) =
      __$$SosAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @DateTimeConverter() DateTime createdAt,
      List<SosDelivery> deliveries,
      String? shareUrl});
}

/// @nodoc
class __$$SosAlertImplCopyWithImpl<$Res>
    extends _$SosAlertCopyWithImpl<$Res, _$SosAlertImpl>
    implements _$$SosAlertImplCopyWith<$Res> {
  __$$SosAlertImplCopyWithImpl(
      _$SosAlertImpl _value, $Res Function(_$SosAlertImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? deliveries = null,
    Object? shareUrl = freezed,
  }) {
    return _then(_$SosAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deliveries: null == deliveries
          ? _value._deliveries
          : deliveries // ignore: cast_nullable_to_non_nullable
              as List<SosDelivery>,
      shareUrl: freezed == shareUrl
          ? _value.shareUrl
          : shareUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosAlertImpl extends _SosAlert {
  const _$SosAlertImpl(
      {required this.id,
      @DateTimeConverter() required this.createdAt,
      required final List<SosDelivery> deliveries,
      this.shareUrl})
      : _deliveries = deliveries,
        super._();

  factory _$SosAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosAlertImplFromJson(json);

  @override
  final String id;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  final List<SosDelivery> _deliveries;
  @override
  List<SosDelivery> get deliveries {
    if (_deliveries is EqualUnmodifiableListView) return _deliveries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deliveries);
  }

// Public link to the live-tracking page (location + alarm) contacts
// get in their SMS. Null if the server hasn't started sending it yet.
  @override
  final String? shareUrl;

  @override
  String toString() {
    return 'SosAlert(id: $id, createdAt: $createdAt, deliveries: $deliveries, shareUrl: $shareUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._deliveries, _deliveries) &&
            (identical(other.shareUrl, shareUrl) ||
                other.shareUrl == shareUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt,
      const DeepCollectionEquality().hash(_deliveries), shareUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SosAlertImplCopyWith<_$SosAlertImpl> get copyWith =>
      __$$SosAlertImplCopyWithImpl<_$SosAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosAlertImplToJson(
      this,
    );
  }
}

abstract class _SosAlert extends SosAlert {
  const factory _SosAlert(
      {required final String id,
      @DateTimeConverter() required final DateTime createdAt,
      required final List<SosDelivery> deliveries,
      final String? shareUrl}) = _$SosAlertImpl;
  const _SosAlert._() : super._();

  factory _SosAlert.fromJson(Map<String, dynamic> json) =
      _$SosAlertImpl.fromJson;

  @override
  String get id;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  List<SosDelivery> get deliveries;
  @override // Public link to the live-tracking page (location + alarm) contacts
// get in their SMS. Null if the server hasn't started sending it yet.
  String? get shareUrl;
  @override
  @JsonKey(ignore: true)
  _$$SosAlertImplCopyWith<_$SosAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SosDelivery _$SosDeliveryFromJson(Map<String, dynamic> json) {
  return _SosDelivery.fromJson(json);
}

/// @nodoc
mixin _$SosDelivery {
  String get contactId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SosDeliveryCopyWith<SosDelivery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosDeliveryCopyWith<$Res> {
  factory $SosDeliveryCopyWith(
          SosDelivery value, $Res Function(SosDelivery) then) =
      _$SosDeliveryCopyWithImpl<$Res, SosDelivery>;
  @useResult
  $Res call(
      {String contactId,
      String name,
      String channel,
      String status,
      String? error});
}

/// @nodoc
class _$SosDeliveryCopyWithImpl<$Res, $Val extends SosDelivery>
    implements $SosDeliveryCopyWith<$Res> {
  _$SosDeliveryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactId = null,
    Object? name = null,
    Object? channel = null,
    Object? status = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      contactId: null == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosDeliveryImplCopyWith<$Res>
    implements $SosDeliveryCopyWith<$Res> {
  factory _$$SosDeliveryImplCopyWith(
          _$SosDeliveryImpl value, $Res Function(_$SosDeliveryImpl) then) =
      __$$SosDeliveryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String contactId,
      String name,
      String channel,
      String status,
      String? error});
}

/// @nodoc
class __$$SosDeliveryImplCopyWithImpl<$Res>
    extends _$SosDeliveryCopyWithImpl<$Res, _$SosDeliveryImpl>
    implements _$$SosDeliveryImplCopyWith<$Res> {
  __$$SosDeliveryImplCopyWithImpl(
      _$SosDeliveryImpl _value, $Res Function(_$SosDeliveryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactId = null,
    Object? name = null,
    Object? channel = null,
    Object? status = null,
    Object? error = freezed,
  }) {
    return _then(_$SosDeliveryImpl(
      contactId: null == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosDeliveryImpl implements _SosDelivery {
  const _$SosDeliveryImpl(
      {required this.contactId,
      required this.name,
      required this.channel,
      required this.status,
      this.error});

  factory _$SosDeliveryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosDeliveryImplFromJson(json);

  @override
  final String contactId;
  @override
  final String name;
  @override
  final String channel;
  @override
  final String status;
  @override
  final String? error;

  @override
  String toString() {
    return 'SosDelivery(contactId: $contactId, name: $name, channel: $channel, status: $status, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosDeliveryImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, contactId, name, channel, status, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SosDeliveryImplCopyWith<_$SosDeliveryImpl> get copyWith =>
      __$$SosDeliveryImplCopyWithImpl<_$SosDeliveryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosDeliveryImplToJson(
      this,
    );
  }
}

abstract class _SosDelivery implements SosDelivery {
  const factory _SosDelivery(
      {required final String contactId,
      required final String name,
      required final String channel,
      required final String status,
      final String? error}) = _$SosDeliveryImpl;

  factory _SosDelivery.fromJson(Map<String, dynamic> json) =
      _$SosDeliveryImpl.fromJson;

  @override
  String get contactId;
  @override
  String get name;
  @override
  String get channel;
  @override
  String get status;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$SosDeliveryImplCopyWith<_$SosDeliveryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
