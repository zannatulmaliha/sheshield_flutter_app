// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_alert_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SosAlertModel _$SosAlertModelFromJson(Map<String, dynamic> json) {
  return _SosAlertModel.fromJson(json);
}

/// @nodoc
mixin _$SosAlertModel {
  String get id => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<SosDeliveryModel> get deliveries => throw _privateConstructorUsedError;
  String? get shareUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SosAlertModelCopyWith<SosAlertModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosAlertModelCopyWith<$Res> {
  factory $SosAlertModelCopyWith(
          SosAlertModel value, $Res Function(SosAlertModel) then) =
      _$SosAlertModelCopyWithImpl<$Res, SosAlertModel>;
  @useResult
  $Res call(
      {String id,
      @DateTimeConverter() DateTime createdAt,
      List<SosDeliveryModel> deliveries,
      String? shareUrl});
}

/// @nodoc
class _$SosAlertModelCopyWithImpl<$Res, $Val extends SosAlertModel>
    implements $SosAlertModelCopyWith<$Res> {
  _$SosAlertModelCopyWithImpl(this._value, this._then);

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
              as List<SosDeliveryModel>,
      shareUrl: freezed == shareUrl
          ? _value.shareUrl
          : shareUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosAlertModelImplCopyWith<$Res>
    implements $SosAlertModelCopyWith<$Res> {
  factory _$$SosAlertModelImplCopyWith(
          _$SosAlertModelImpl value, $Res Function(_$SosAlertModelImpl) then) =
      __$$SosAlertModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @DateTimeConverter() DateTime createdAt,
      List<SosDeliveryModel> deliveries,
      String? shareUrl});
}

/// @nodoc
class __$$SosAlertModelImplCopyWithImpl<$Res>
    extends _$SosAlertModelCopyWithImpl<$Res, _$SosAlertModelImpl>
    implements _$$SosAlertModelImplCopyWith<$Res> {
  __$$SosAlertModelImplCopyWithImpl(
      _$SosAlertModelImpl _value, $Res Function(_$SosAlertModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? deliveries = null,
    Object? shareUrl = freezed,
  }) {
    return _then(_$SosAlertModelImpl(
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
              as List<SosDeliveryModel>,
      shareUrl: freezed == shareUrl
          ? _value.shareUrl
          : shareUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosAlertModelImpl extends _SosAlertModel {
  const _$SosAlertModelImpl(
      {required this.id,
      @DateTimeConverter() required this.createdAt,
      final List<SosDeliveryModel> deliveries = const <SosDeliveryModel>[],
      this.shareUrl})
      : _deliveries = deliveries,
        super._();

  factory _$SosAlertModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosAlertModelImplFromJson(json);

  @override
  final String id;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  final List<SosDeliveryModel> _deliveries;
  @override
  @JsonKey()
  List<SosDeliveryModel> get deliveries {
    if (_deliveries is EqualUnmodifiableListView) return _deliveries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deliveries);
  }

  @override
  final String? shareUrl;

  @override
  String toString() {
    return 'SosAlertModel(id: $id, createdAt: $createdAt, deliveries: $deliveries, shareUrl: $shareUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosAlertModelImpl &&
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
  _$$SosAlertModelImplCopyWith<_$SosAlertModelImpl> get copyWith =>
      __$$SosAlertModelImplCopyWithImpl<_$SosAlertModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosAlertModelImplToJson(
      this,
    );
  }
}

abstract class _SosAlertModel extends SosAlertModel {
  const factory _SosAlertModel(
      {required final String id,
      @DateTimeConverter() required final DateTime createdAt,
      final List<SosDeliveryModel> deliveries,
      final String? shareUrl}) = _$SosAlertModelImpl;
  const _SosAlertModel._() : super._();

  factory _SosAlertModel.fromJson(Map<String, dynamic> json) =
      _$SosAlertModelImpl.fromJson;

  @override
  String get id;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  List<SosDeliveryModel> get deliveries;
  @override
  String? get shareUrl;
  @override
  @JsonKey(ignore: true)
  _$$SosAlertModelImplCopyWith<_$SosAlertModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
