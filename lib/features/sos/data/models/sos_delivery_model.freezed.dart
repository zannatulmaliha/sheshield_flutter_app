// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_delivery_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SosDeliveryModel _$SosDeliveryModelFromJson(Map<String, dynamic> json) {
  return _SosDeliveryModel.fromJson(json);
}

/// @nodoc
mixin _$SosDeliveryModel {
  String get contactId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SosDeliveryModelCopyWith<SosDeliveryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosDeliveryModelCopyWith<$Res> {
  factory $SosDeliveryModelCopyWith(
          SosDeliveryModel value, $Res Function(SosDeliveryModel) then) =
      _$SosDeliveryModelCopyWithImpl<$Res, SosDeliveryModel>;
  @useResult
  $Res call(
      {String contactId,
      String name,
      String channel,
      String status,
      String? error});
}

/// @nodoc
class _$SosDeliveryModelCopyWithImpl<$Res, $Val extends SosDeliveryModel>
    implements $SosDeliveryModelCopyWith<$Res> {
  _$SosDeliveryModelCopyWithImpl(this._value, this._then);

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
abstract class _$$SosDeliveryModelImplCopyWith<$Res>
    implements $SosDeliveryModelCopyWith<$Res> {
  factory _$$SosDeliveryModelImplCopyWith(_$SosDeliveryModelImpl value,
          $Res Function(_$SosDeliveryModelImpl) then) =
      __$$SosDeliveryModelImplCopyWithImpl<$Res>;
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
class __$$SosDeliveryModelImplCopyWithImpl<$Res>
    extends _$SosDeliveryModelCopyWithImpl<$Res, _$SosDeliveryModelImpl>
    implements _$$SosDeliveryModelImplCopyWith<$Res> {
  __$$SosDeliveryModelImplCopyWithImpl(_$SosDeliveryModelImpl _value,
      $Res Function(_$SosDeliveryModelImpl) _then)
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
    return _then(_$SosDeliveryModelImpl(
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
class _$SosDeliveryModelImpl extends _SosDeliveryModel {
  const _$SosDeliveryModelImpl(
      {required this.contactId,
      required this.name,
      required this.channel,
      required this.status,
      this.error})
      : super._();

  factory _$SosDeliveryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosDeliveryModelImplFromJson(json);

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
    return 'SosDeliveryModel(contactId: $contactId, name: $name, channel: $channel, status: $status, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosDeliveryModelImpl &&
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
  _$$SosDeliveryModelImplCopyWith<_$SosDeliveryModelImpl> get copyWith =>
      __$$SosDeliveryModelImplCopyWithImpl<_$SosDeliveryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosDeliveryModelImplToJson(
      this,
    );
  }
}

abstract class _SosDeliveryModel extends SosDeliveryModel {
  const factory _SosDeliveryModel(
      {required final String contactId,
      required final String name,
      required final String channel,
      required final String status,
      final String? error}) = _$SosDeliveryModelImpl;
  const _SosDeliveryModel._() : super._();

  factory _SosDeliveryModel.fromJson(Map<String, dynamic> json) =
      _$SosDeliveryModelImpl.fromJson;

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
  _$$SosDeliveryModelImplCopyWith<_$SosDeliveryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
