// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trusted_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrustedContact _$TrustedContactFromJson(Map<String, dynamic> json) {
  return _TrustedContact.fromJson(json);
}

/// @nodoc
mixin _$TrustedContact {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get relation => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrustedContactCopyWith<TrustedContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrustedContactCopyWith<$Res> {
  factory $TrustedContactCopyWith(
          TrustedContact value, $Res Function(TrustedContact) then) =
      _$TrustedContactCopyWithImpl<$Res, TrustedContact>;
  @useResult
  $Res call(
      {String id,
      String name,
      String relation,
      String phone,
      String countryCode,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$TrustedContactCopyWithImpl<$Res, $Val extends TrustedContact>
    implements $TrustedContactCopyWith<$Res> {
  _$TrustedContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? relation = null,
    Object? phone = null,
    Object? countryCode = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      relation: null == relation
          ? _value.relation
          : relation // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrustedContactImplCopyWith<$Res>
    implements $TrustedContactCopyWith<$Res> {
  factory _$$TrustedContactImplCopyWith(_$TrustedContactImpl value,
          $Res Function(_$TrustedContactImpl) then) =
      __$$TrustedContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String relation,
      String phone,
      String countryCode,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$$TrustedContactImplCopyWithImpl<$Res>
    extends _$TrustedContactCopyWithImpl<$Res, _$TrustedContactImpl>
    implements _$$TrustedContactImplCopyWith<$Res> {
  __$$TrustedContactImplCopyWithImpl(
      _$TrustedContactImpl _value, $Res Function(_$TrustedContactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? relation = null,
    Object? phone = null,
    Object? countryCode = null,
    Object? createdAt = null,
  }) {
    return _then(_$TrustedContactImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      relation: null == relation
          ? _value.relation
          : relation // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
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
class _$TrustedContactImpl extends _TrustedContact {
  const _$TrustedContactImpl(
      {required this.id,
      required this.name,
      required this.relation,
      required this.phone,
      required this.countryCode,
      @DateTimeConverter() required this.createdAt})
      : super._();

  factory _$TrustedContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrustedContactImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String relation;
  @override
  final String phone;
  @override
  final String countryCode;
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'TrustedContact(id: $id, name: $name, relation: $relation, phone: $phone, countryCode: $countryCode, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrustedContactImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.relation, relation) ||
                other.relation == relation) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, relation, phone, countryCode, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrustedContactImplCopyWith<_$TrustedContactImpl> get copyWith =>
      __$$TrustedContactImplCopyWithImpl<_$TrustedContactImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrustedContactImplToJson(
      this,
    );
  }
}

abstract class _TrustedContact extends TrustedContact {
  const factory _TrustedContact(
          {required final String id,
          required final String name,
          required final String relation,
          required final String phone,
          required final String countryCode,
          @DateTimeConverter() required final DateTime createdAt}) =
      _$TrustedContactImpl;
  const _TrustedContact._() : super._();

  factory _TrustedContact.fromJson(Map<String, dynamic> json) =
      _$TrustedContactImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get relation;
  @override
  String get phone;
  @override
  String get countryCode;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TrustedContactImplCopyWith<_$TrustedContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
