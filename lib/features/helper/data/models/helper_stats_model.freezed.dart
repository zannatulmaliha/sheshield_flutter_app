// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'helper_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HelperStatsModel _$HelperStatsModelFromJson(Map<String, dynamic> json) {
  return _HelperStatsModel.fromJson(json);
}

/// @nodoc
mixin _$HelperStatsModel {
  int get responses => throw _privateConstructorUsedError;
  int get completed => throw _privateConstructorUsedError;
  int get resolved => throw _privateConstructorUsedError;
  int get successRate => throw _privateConstructorUsedError;
  double? get avgResponseMinutes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HelperStatsModelCopyWith<HelperStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelperStatsModelCopyWith<$Res> {
  factory $HelperStatsModelCopyWith(
          HelperStatsModel value, $Res Function(HelperStatsModel) then) =
      _$HelperStatsModelCopyWithImpl<$Res, HelperStatsModel>;
  @useResult
  $Res call(
      {int responses,
      int completed,
      int resolved,
      int successRate,
      double? avgResponseMinutes});
}

/// @nodoc
class _$HelperStatsModelCopyWithImpl<$Res, $Val extends HelperStatsModel>
    implements $HelperStatsModelCopyWith<$Res> {
  _$HelperStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responses = null,
    Object? completed = null,
    Object? resolved = null,
    Object? successRate = null,
    Object? avgResponseMinutes = freezed,
  }) {
    return _then(_value.copyWith(
      responses: null == responses
          ? _value.responses
          : responses // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      resolved: null == resolved
          ? _value.resolved
          : resolved // ignore: cast_nullable_to_non_nullable
              as int,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as int,
      avgResponseMinutes: freezed == avgResponseMinutes
          ? _value.avgResponseMinutes
          : avgResponseMinutes // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HelperStatsModelImplCopyWith<$Res>
    implements $HelperStatsModelCopyWith<$Res> {
  factory _$$HelperStatsModelImplCopyWith(_$HelperStatsModelImpl value,
          $Res Function(_$HelperStatsModelImpl) then) =
      __$$HelperStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int responses,
      int completed,
      int resolved,
      int successRate,
      double? avgResponseMinutes});
}

/// @nodoc
class __$$HelperStatsModelImplCopyWithImpl<$Res>
    extends _$HelperStatsModelCopyWithImpl<$Res, _$HelperStatsModelImpl>
    implements _$$HelperStatsModelImplCopyWith<$Res> {
  __$$HelperStatsModelImplCopyWithImpl(_$HelperStatsModelImpl _value,
      $Res Function(_$HelperStatsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responses = null,
    Object? completed = null,
    Object? resolved = null,
    Object? successRate = null,
    Object? avgResponseMinutes = freezed,
  }) {
    return _then(_$HelperStatsModelImpl(
      responses: null == responses
          ? _value.responses
          : responses // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      resolved: null == resolved
          ? _value.resolved
          : resolved // ignore: cast_nullable_to_non_nullable
              as int,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as int,
      avgResponseMinutes: freezed == avgResponseMinutes
          ? _value.avgResponseMinutes
          : avgResponseMinutes // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HelperStatsModelImpl extends _HelperStatsModel {
  const _$HelperStatsModelImpl(
      {this.responses = 0,
      this.completed = 0,
      this.resolved = 0,
      this.successRate = 0,
      this.avgResponseMinutes})
      : super._();

  factory _$HelperStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HelperStatsModelImplFromJson(json);

  @override
  @JsonKey()
  final int responses;
  @override
  @JsonKey()
  final int completed;
  @override
  @JsonKey()
  final int resolved;
  @override
  @JsonKey()
  final int successRate;
  @override
  final double? avgResponseMinutes;

  @override
  String toString() {
    return 'HelperStatsModel(responses: $responses, completed: $completed, resolved: $resolved, successRate: $successRate, avgResponseMinutes: $avgResponseMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HelperStatsModelImpl &&
            (identical(other.responses, responses) ||
                other.responses == responses) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.resolved, resolved) ||
                other.resolved == resolved) &&
            (identical(other.successRate, successRate) ||
                other.successRate == successRate) &&
            (identical(other.avgResponseMinutes, avgResponseMinutes) ||
                other.avgResponseMinutes == avgResponseMinutes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, responses, completed, resolved,
      successRate, avgResponseMinutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HelperStatsModelImplCopyWith<_$HelperStatsModelImpl> get copyWith =>
      __$$HelperStatsModelImplCopyWithImpl<_$HelperStatsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HelperStatsModelImplToJson(
      this,
    );
  }
}

abstract class _HelperStatsModel extends HelperStatsModel {
  const factory _HelperStatsModel(
      {final int responses,
      final int completed,
      final int resolved,
      final int successRate,
      final double? avgResponseMinutes}) = _$HelperStatsModelImpl;
  const _HelperStatsModel._() : super._();

  factory _HelperStatsModel.fromJson(Map<String, dynamic> json) =
      _$HelperStatsModelImpl.fromJson;

  @override
  int get responses;
  @override
  int get completed;
  @override
  int get resolved;
  @override
  int get successRate;
  @override
  double? get avgResponseMinutes;
  @override
  @JsonKey(ignore: true)
  _$$HelperStatsModelImplCopyWith<_$HelperStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
