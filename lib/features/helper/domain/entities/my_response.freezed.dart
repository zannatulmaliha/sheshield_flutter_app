// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyResponse {
  AcceptedAlert get alert => throw _privateConstructorUsedError;
  ResponseStage get stage => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  RiskLevel get riskLevel => throw _privateConstructorUsedError;
  bool get duressActive => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyResponseCopyWith<MyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyResponseCopyWith<$Res> {
  factory $MyResponseCopyWith(
          MyResponse value, $Res Function(MyResponse) then) =
      _$MyResponseCopyWithImpl<$Res, MyResponse>;
  @useResult
  $Res call(
      {AcceptedAlert alert,
      ResponseStage stage,
      String label,
      RiskLevel riskLevel,
      bool duressActive});

  $AcceptedAlertCopyWith<$Res> get alert;
}

/// @nodoc
class _$MyResponseCopyWithImpl<$Res, $Val extends MyResponse>
    implements $MyResponseCopyWith<$Res> {
  _$MyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alert = null,
    Object? stage = null,
    Object? label = null,
    Object? riskLevel = null,
    Object? duressActive = null,
  }) {
    return _then(_value.copyWith(
      alert: null == alert
          ? _value.alert
          : alert // ignore: cast_nullable_to_non_nullable
              as AcceptedAlert,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as ResponseStage,
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

  @override
  @pragma('vm:prefer-inline')
  $AcceptedAlertCopyWith<$Res> get alert {
    return $AcceptedAlertCopyWith<$Res>(_value.alert, (value) {
      return _then(_value.copyWith(alert: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MyResponseImplCopyWith<$Res>
    implements $MyResponseCopyWith<$Res> {
  factory _$$MyResponseImplCopyWith(
          _$MyResponseImpl value, $Res Function(_$MyResponseImpl) then) =
      __$$MyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AcceptedAlert alert,
      ResponseStage stage,
      String label,
      RiskLevel riskLevel,
      bool duressActive});

  @override
  $AcceptedAlertCopyWith<$Res> get alert;
}

/// @nodoc
class __$$MyResponseImplCopyWithImpl<$Res>
    extends _$MyResponseCopyWithImpl<$Res, _$MyResponseImpl>
    implements _$$MyResponseImplCopyWith<$Res> {
  __$$MyResponseImplCopyWithImpl(
      _$MyResponseImpl _value, $Res Function(_$MyResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alert = null,
    Object? stage = null,
    Object? label = null,
    Object? riskLevel = null,
    Object? duressActive = null,
  }) {
    return _then(_$MyResponseImpl(
      alert: null == alert
          ? _value.alert
          : alert // ignore: cast_nullable_to_non_nullable
              as AcceptedAlert,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as ResponseStage,
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

class _$MyResponseImpl implements _MyResponse {
  const _$MyResponseImpl(
      {required this.alert,
      required this.stage,
      required this.label,
      required this.riskLevel,
      required this.duressActive});

  @override
  final AcceptedAlert alert;
  @override
  final ResponseStage stage;
  @override
  final String label;
  @override
  final RiskLevel riskLevel;
  @override
  final bool duressActive;

  @override
  String toString() {
    return 'MyResponse(alert: $alert, stage: $stage, label: $label, riskLevel: $riskLevel, duressActive: $duressActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyResponseImpl &&
            (identical(other.alert, alert) || other.alert == alert) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            (identical(other.duressActive, duressActive) ||
                other.duressActive == duressActive));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, alert, stage, label, riskLevel, duressActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyResponseImplCopyWith<_$MyResponseImpl> get copyWith =>
      __$$MyResponseImplCopyWithImpl<_$MyResponseImpl>(this, _$identity);
}

abstract class _MyResponse implements MyResponse {
  const factory _MyResponse(
      {required final AcceptedAlert alert,
      required final ResponseStage stage,
      required final String label,
      required final RiskLevel riskLevel,
      required final bool duressActive}) = _$MyResponseImpl;

  @override
  AcceptedAlert get alert;
  @override
  ResponseStage get stage;
  @override
  String get label;
  @override
  RiskLevel get riskLevel;
  @override
  bool get duressActive;
  @override
  @JsonKey(ignore: true)
  _$$MyResponseImplCopyWith<_$MyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
