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

/// @nodoc
mixin _$SosAlert {
  String get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<SosDelivery> get deliveries => throw _privateConstructorUsedError;

  /// Public live-tracking link contacts get in their SMS. Null until the
  /// server starts sending it.
  String? get shareUrl => throw _privateConstructorUsedError;

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
      DateTime createdAt,
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
      DateTime createdAt,
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

class _$SosAlertImpl extends _SosAlert {
  const _$SosAlertImpl(
      {required this.id,
      required this.createdAt,
      required final List<SosDelivery> deliveries,
      this.shareUrl})
      : _deliveries = deliveries,
        super._();

  @override
  final String id;
  @override
  final DateTime createdAt;
  final List<SosDelivery> _deliveries;
  @override
  List<SosDelivery> get deliveries {
    if (_deliveries is EqualUnmodifiableListView) return _deliveries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deliveries);
  }

  /// Public live-tracking link contacts get in their SMS. Null until the
  /// server starts sending it.
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

  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt,
      const DeepCollectionEquality().hash(_deliveries), shareUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SosAlertImplCopyWith<_$SosAlertImpl> get copyWith =>
      __$$SosAlertImplCopyWithImpl<_$SosAlertImpl>(this, _$identity);
}

abstract class _SosAlert extends SosAlert {
  const factory _SosAlert(
      {required final String id,
      required final DateTime createdAt,
      required final List<SosDelivery> deliveries,
      final String? shareUrl}) = _$SosAlertImpl;
  const _SosAlert._() : super._();

  @override
  String get id;
  @override
  DateTime get createdAt;
  @override
  List<SosDelivery> get deliveries;
  @override

  /// Public live-tracking link contacts get in their SMS. Null until the
  /// server starts sending it.
  String? get shareUrl;
  @override
  @JsonKey(ignore: true)
  _$$SosAlertImplCopyWith<_$SosAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
