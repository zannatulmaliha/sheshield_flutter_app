// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'helper_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HelperHistoryItem {
  String get id => throw _privateConstructorUsedError;
  String get alertId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  DateTime get acceptedAt => throw _privateConstructorUsedError;
  ResponseOutcome get outcome => throw _privateConstructorUsedError;
  DateTime? get arrivedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  double? get responseMinutes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HelperHistoryItemCopyWith<HelperHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelperHistoryItemCopyWith<$Res> {
  factory $HelperHistoryItemCopyWith(
          HelperHistoryItem value, $Res Function(HelperHistoryItem) then) =
      _$HelperHistoryItemCopyWithImpl<$Res, HelperHistoryItem>;
  @useResult
  $Res call(
      {String id,
      String alertId,
      String label,
      DateTime acceptedAt,
      ResponseOutcome outcome,
      DateTime? arrivedAt,
      DateTime? endedAt,
      double? responseMinutes});
}

/// @nodoc
class _$HelperHistoryItemCopyWithImpl<$Res, $Val extends HelperHistoryItem>
    implements $HelperHistoryItemCopyWith<$Res> {
  _$HelperHistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? alertId = null,
    Object? label = null,
    Object? acceptedAt = null,
    Object? outcome = null,
    Object? arrivedAt = freezed,
    Object? endedAt = freezed,
    Object? responseMinutes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      alertId: null == alertId
          ? _value.alertId
          : alertId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      acceptedAt: null == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      outcome: null == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as ResponseOutcome,
      arrivedAt: freezed == arrivedAt
          ? _value.arrivedAt
          : arrivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      responseMinutes: freezed == responseMinutes
          ? _value.responseMinutes
          : responseMinutes // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HelperHistoryItemImplCopyWith<$Res>
    implements $HelperHistoryItemCopyWith<$Res> {
  factory _$$HelperHistoryItemImplCopyWith(_$HelperHistoryItemImpl value,
          $Res Function(_$HelperHistoryItemImpl) then) =
      __$$HelperHistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String alertId,
      String label,
      DateTime acceptedAt,
      ResponseOutcome outcome,
      DateTime? arrivedAt,
      DateTime? endedAt,
      double? responseMinutes});
}

/// @nodoc
class __$$HelperHistoryItemImplCopyWithImpl<$Res>
    extends _$HelperHistoryItemCopyWithImpl<$Res, _$HelperHistoryItemImpl>
    implements _$$HelperHistoryItemImplCopyWith<$Res> {
  __$$HelperHistoryItemImplCopyWithImpl(_$HelperHistoryItemImpl _value,
      $Res Function(_$HelperHistoryItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? alertId = null,
    Object? label = null,
    Object? acceptedAt = null,
    Object? outcome = null,
    Object? arrivedAt = freezed,
    Object? endedAt = freezed,
    Object? responseMinutes = freezed,
  }) {
    return _then(_$HelperHistoryItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      alertId: null == alertId
          ? _value.alertId
          : alertId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      acceptedAt: null == acceptedAt
          ? _value.acceptedAt
          : acceptedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      outcome: null == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as ResponseOutcome,
      arrivedAt: freezed == arrivedAt
          ? _value.arrivedAt
          : arrivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      responseMinutes: freezed == responseMinutes
          ? _value.responseMinutes
          : responseMinutes // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$HelperHistoryItemImpl implements _HelperHistoryItem {
  const _$HelperHistoryItemImpl(
      {required this.id,
      required this.alertId,
      required this.label,
      required this.acceptedAt,
      required this.outcome,
      this.arrivedAt,
      this.endedAt,
      this.responseMinutes});

  @override
  final String id;
  @override
  final String alertId;
  @override
  final String label;
  @override
  final DateTime acceptedAt;
  @override
  final ResponseOutcome outcome;
  @override
  final DateTime? arrivedAt;
  @override
  final DateTime? endedAt;
  @override
  final double? responseMinutes;

  @override
  String toString() {
    return 'HelperHistoryItem(id: $id, alertId: $alertId, label: $label, acceptedAt: $acceptedAt, outcome: $outcome, arrivedAt: $arrivedAt, endedAt: $endedAt, responseMinutes: $responseMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HelperHistoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.alertId, alertId) || other.alertId == alertId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.acceptedAt, acceptedAt) ||
                other.acceptedAt == acceptedAt) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            (identical(other.arrivedAt, arrivedAt) ||
                other.arrivedAt == arrivedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.responseMinutes, responseMinutes) ||
                other.responseMinutes == responseMinutes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, alertId, label, acceptedAt,
      outcome, arrivedAt, endedAt, responseMinutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HelperHistoryItemImplCopyWith<_$HelperHistoryItemImpl> get copyWith =>
      __$$HelperHistoryItemImplCopyWithImpl<_$HelperHistoryItemImpl>(
          this, _$identity);
}

abstract class _HelperHistoryItem implements HelperHistoryItem {
  const factory _HelperHistoryItem(
      {required final String id,
      required final String alertId,
      required final String label,
      required final DateTime acceptedAt,
      required final ResponseOutcome outcome,
      final DateTime? arrivedAt,
      final DateTime? endedAt,
      final double? responseMinutes}) = _$HelperHistoryItemImpl;

  @override
  String get id;
  @override
  String get alertId;
  @override
  String get label;
  @override
  DateTime get acceptedAt;
  @override
  ResponseOutcome get outcome;
  @override
  DateTime? get arrivedAt;
  @override
  DateTime? get endedAt;
  @override
  double? get responseMinutes;
  @override
  @JsonKey(ignore: true)
  _$$HelperHistoryItemImplCopyWith<_$HelperHistoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
