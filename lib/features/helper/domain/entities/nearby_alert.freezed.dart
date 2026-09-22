// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NearbyAlert _$NearbyAlertFromJson(Map<String, dynamic> json) {
  return _NearbyAlert.fromJson(json);
}

/// @nodoc
mixin _$NearbyAlert {
  String get id => throw _privateConstructorUsedError;
  String get roughArea => throw _privateConstructorUsedError;
  double get distanceMeters => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NearbyAlertCopyWith<NearbyAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearbyAlertCopyWith<$Res> {
  factory $NearbyAlertCopyWith(
          NearbyAlert value, $Res Function(NearbyAlert) then) =
      _$NearbyAlertCopyWithImpl<$Res, NearbyAlert>;
  @useResult
  $Res call(
      {String id,
      String roughArea,
      double distanceMeters,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$NearbyAlertCopyWithImpl<$Res, $Val extends NearbyAlert>
    implements $NearbyAlertCopyWith<$Res> {
  _$NearbyAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roughArea = null,
    Object? distanceMeters = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roughArea: null == roughArea
          ? _value.roughArea
          : roughArea // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NearbyAlertImplCopyWith<$Res>
    implements $NearbyAlertCopyWith<$Res> {
  factory _$$NearbyAlertImplCopyWith(
          _$NearbyAlertImpl value, $Res Function(_$NearbyAlertImpl) then) =
      __$$NearbyAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String roughArea,
      double distanceMeters,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$$NearbyAlertImplCopyWithImpl<$Res>
    extends _$NearbyAlertCopyWithImpl<$Res, _$NearbyAlertImpl>
    implements _$$NearbyAlertImplCopyWith<$Res> {
  __$$NearbyAlertImplCopyWithImpl(
      _$NearbyAlertImpl _value, $Res Function(_$NearbyAlertImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roughArea = null,
    Object? distanceMeters = null,
    Object? createdAt = null,
  }) {
    return _then(_$NearbyAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roughArea: null == roughArea
          ? _value.roughArea
          : roughArea // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NearbyAlertImpl extends _NearbyAlert {
  const _$NearbyAlertImpl(
      {required this.id,
      this.roughArea = 'Nearby',
      required this.distanceMeters,
      @DateTimeConverter() required this.createdAt})
      : super._();

  factory _$NearbyAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$NearbyAlertImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String roughArea;
  @override
  final double distanceMeters;
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'NearbyAlert(id: $id, roughArea: $roughArea, distanceMeters: $distanceMeters, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NearbyAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roughArea, roughArea) ||
                other.roughArea == roughArea) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, roughArea, distanceMeters, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NearbyAlertImplCopyWith<_$NearbyAlertImpl> get copyWith =>
      __$$NearbyAlertImplCopyWithImpl<_$NearbyAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NearbyAlertImplToJson(
      this,
    );
  }
}

abstract class _NearbyAlert extends NearbyAlert {
  const factory _NearbyAlert(
          {required final String id,
          final String roughArea,
          required final double distanceMeters,
          @DateTimeConverter() required final DateTime createdAt}) =
      _$NearbyAlertImpl;
  const _NearbyAlert._() : super._();

  factory _NearbyAlert.fromJson(Map<String, dynamic> json) =
      _$NearbyAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get roughArea;
  @override
  double get distanceMeters;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$NearbyAlertImplCopyWith<_$NearbyAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
