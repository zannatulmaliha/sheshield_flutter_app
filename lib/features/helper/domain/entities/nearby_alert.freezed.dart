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

/// @nodoc
mixin _$NearbyAlert {
  String get id => throw _privateConstructorUsedError;
  double get distanceMeters => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get roughArea => throw _privateConstructorUsedError;
  bool get mutualConnection => throw _privateConstructorUsedError;

  /// What fired the SOS: manual | voice | motion_fall | motion_sprint |
  /// motion_struggle | motion_inactive | missed_checkin. Kept as text:
  /// the backend can add triggers without an app release.
  String get trigger => throw _privateConstructorUsedError;

  /// Plain-language reason shown on the card ("Possible fall detected").
  String get label => throw _privateConstructorUsedError;
  RiskLevel get riskLevel => throw _privateConstructorUsedError;
  bool get duressActive => throw _privateConstructorUsedError;

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
      double distanceMeters,
      DateTime createdAt,
      String roughArea,
      bool mutualConnection,
      String trigger,
      String label,
      RiskLevel riskLevel,
      bool duressActive});
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
    Object? distanceMeters = null,
    Object? createdAt = null,
    Object? roughArea = null,
    Object? mutualConnection = null,
    Object? trigger = null,
    Object? label = null,
    Object? riskLevel = null,
    Object? duressActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      roughArea: null == roughArea
          ? _value.roughArea
          : roughArea // ignore: cast_nullable_to_non_nullable
              as String,
      mutualConnection: null == mutualConnection
          ? _value.mutualConnection
          : mutualConnection // ignore: cast_nullable_to_non_nullable
              as bool,
      trigger: null == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
      duressActive: null == duressActive
          ? _value.duressActive
          : duressActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
      double distanceMeters,
      DateTime createdAt,
      String roughArea,
      bool mutualConnection,
      String trigger,
      String label,
      RiskLevel riskLevel,
      bool duressActive});
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
    Object? distanceMeters = null,
    Object? createdAt = null,
    Object? roughArea = null,
    Object? mutualConnection = null,
    Object? trigger = null,
    Object? label = null,
    Object? riskLevel = null,
    Object? duressActive = null,
  }) {
    return _then(_$NearbyAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      distanceMeters: null == distanceMeters
          ? _value.distanceMeters
          : distanceMeters // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      roughArea: null == roughArea
          ? _value.roughArea
          : roughArea // ignore: cast_nullable_to_non_nullable
              as String,
      mutualConnection: null == mutualConnection
          ? _value.mutualConnection
          : mutualConnection // ignore: cast_nullable_to_non_nullable
              as bool,
      trigger: null == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
      duressActive: null == duressActive
          ? _value.duressActive
          : duressActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NearbyAlertImpl extends _NearbyAlert {
  const _$NearbyAlertImpl(
      {required this.id,
      required this.distanceMeters,
      required this.createdAt,
      this.roughArea = 'Nearby',
      this.mutualConnection = false,
      this.trigger = 'manual',
      this.label = 'SOS button pressed',
      this.riskLevel = RiskLevel.high,
      this.duressActive = false})
      : super._();

  @override
  final String id;
  @override
  final double distanceMeters;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final String roughArea;
  @override
  @JsonKey()
  final bool mutualConnection;

  /// What fired the SOS: manual | voice | motion_fall | motion_sprint |
  /// motion_struggle | motion_inactive | missed_checkin. Kept as text:
  /// the backend can add triggers without an app release.
  @override
  @JsonKey()
  final String trigger;

  /// Plain-language reason shown on the card ("Possible fall detected").
  @override
  @JsonKey()
  final String label;
  @override
  @JsonKey()
  final RiskLevel riskLevel;
  @override
  @JsonKey()
  final bool duressActive;

  @override
  String toString() {
    return 'NearbyAlert(id: $id, distanceMeters: $distanceMeters, createdAt: $createdAt, roughArea: $roughArea, mutualConnection: $mutualConnection, trigger: $trigger, label: $label, riskLevel: $riskLevel, duressActive: $duressActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NearbyAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.roughArea, roughArea) ||
                other.roughArea == roughArea) &&
            (identical(other.mutualConnection, mutualConnection) ||
                other.mutualConnection == mutualConnection) &&
            (identical(other.trigger, trigger) || other.trigger == trigger) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.duressActive, duressActive) ||
                other.duressActive == duressActive));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, distanceMeters, createdAt,
      roughArea, mutualConnection, trigger, label, riskLevel, duressActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NearbyAlertImplCopyWith<_$NearbyAlertImpl> get copyWith =>
      __$$NearbyAlertImplCopyWithImpl<_$NearbyAlertImpl>(this, _$identity);
}

abstract class _NearbyAlert extends NearbyAlert {
  const factory _NearbyAlert(
      {required final String id,
      required final double distanceMeters,
      required final DateTime createdAt,
      final String roughArea,
      final bool mutualConnection,
      final String trigger,
      final String label,
      final RiskLevel riskLevel,
      final bool duressActive}) = _$NearbyAlertImpl;
  const _NearbyAlert._() : super._();

  @override
  String get id;
  @override
  double get distanceMeters;
  @override
  DateTime get createdAt;
  @override
  String get roughArea;
  @override
  bool get mutualConnection;
  @override

  /// What fired the SOS: manual | voice | motion_fall | motion_sprint |
  /// motion_struggle | motion_inactive | missed_checkin. Kept as text:
  /// the backend can add triggers without an app release.
  String get trigger;
  @override

  /// Plain-language reason shown on the card ("Possible fall detected").
  String get label;
  @override
  RiskLevel get riskLevel;
  @override
  bool get duressActive;
  @override
  @JsonKey(ignore: true)
  _$$NearbyAlertImplCopyWith<_$NearbyAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
