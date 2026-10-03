// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'helper_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HelperStats {
  int get responses => throw _privateConstructorUsedError;
  int get completed => throw _privateConstructorUsedError;
  int get resolved => throw _privateConstructorUsedError;
  int get successRate => throw _privateConstructorUsedError;
  double? get avgResponseMinutes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HelperStatsCopyWith<HelperStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelperStatsCopyWith<$Res> {
  factory $HelperStatsCopyWith(
          HelperStats value, $Res Function(HelperStats) then) =
      _$HelperStatsCopyWithImpl<$Res, HelperStats>;
  @useResult
  $Res call(
      {int responses,
      int completed,
      int resolved,
      int successRate,
      double? avgResponseMinutes});
}

/// @nodoc
class _$HelperStatsCopyWithImpl<$Res, $Val extends HelperStats>
    implements $HelperStatsCopyWith<$Res> {
  _$HelperStatsCopyWithImpl(this._value, this._then);

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
abstract class _$$HelperStatsImplCopyWith<$Res>
    implements $HelperStatsCopyWith<$Res> {
  factory _$$HelperStatsImplCopyWith(
          _$HelperStatsImpl value, $Res Function(_$HelperStatsImpl) then) =
      __$$HelperStatsImplCopyWithImpl<$Res>;
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
class __$$HelperStatsImplCopyWithImpl<$Res>
    extends _$HelperStatsCopyWithImpl<$Res, _$HelperStatsImpl>
    implements _$$HelperStatsImplCopyWith<$Res> {
  __$$HelperStatsImplCopyWithImpl(
      _$HelperStatsImpl _value, $Res Function(_$HelperStatsImpl) _then)
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
    return _then(_$HelperStatsImpl(
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

class _$HelperStatsImpl extends _HelperStats {
  const _$HelperStatsImpl(
      {this.responses = 0,
      this.completed = 0,
      this.resolved = 0,
      this.successRate = 0,
      this.avgResponseMinutes})
      : super._();

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
    return 'HelperStats(responses: $responses, completed: $completed, resolved: $resolved, successRate: $successRate, avgResponseMinutes: $avgResponseMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HelperStatsImpl &&
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

  @override
  int get hashCode => Object.hash(runtimeType, responses, completed, resolved,
      successRate, avgResponseMinutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HelperStatsImplCopyWith<_$HelperStatsImpl> get copyWith =>
      __$$HelperStatsImplCopyWithImpl<_$HelperStatsImpl>(this, _$identity);
}

abstract class _HelperStats extends HelperStats {
  const factory _HelperStats(
      {final int responses,
      final int completed,
      final int resolved,
      final int successRate,
      final double? avgResponseMinutes}) = _$HelperStatsImpl;
  const _HelperStats._() : super._();

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
  _$$HelperStatsImplCopyWith<_$HelperStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
