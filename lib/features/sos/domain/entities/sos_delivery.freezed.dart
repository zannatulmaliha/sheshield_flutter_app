// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_delivery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SosDelivery {
  String get contactId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  DeliveryStatus get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

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
      DeliveryStatus status,
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
              as DeliveryStatus,
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
      DeliveryStatus status,
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
              as DeliveryStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SosDeliveryImpl implements _SosDelivery {
  const _$SosDeliveryImpl(
      {required this.contactId,
      required this.name,
      required this.channel,
      required this.status,
      this.error});

  @override
  final String contactId;
  @override
  final String name;
  @override
  final String channel;
  @override
  final DeliveryStatus status;
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

  @override
  int get hashCode =>
      Object.hash(runtimeType, contactId, name, channel, status, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SosDeliveryImplCopyWith<_$SosDeliveryImpl> get copyWith =>
      __$$SosDeliveryImplCopyWithImpl<_$SosDeliveryImpl>(this, _$identity);
}

abstract class _SosDelivery implements SosDelivery {
  const factory _SosDelivery(
      {required final String contactId,
      required final String name,
      required final String channel,
      required final DeliveryStatus status,
      final String? error}) = _$SosDeliveryImpl;

  @override
  String get contactId;
  @override
  String get name;
  @override
  String get channel;
  @override
  DeliveryStatus get status;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$SosDeliveryImplCopyWith<_$SosDeliveryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
