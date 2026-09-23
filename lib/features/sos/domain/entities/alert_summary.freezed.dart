// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AlertSummary _$AlertSummaryFromJson(Map<String, dynamic> json) {
  return _AlertSummary.fromJson(json);
}

/// @nodoc
mixin _$AlertSummary {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @NullableDateTimeConverter()
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  int get sentCount => throw _privateConstructorUsedError;
  int get failedCount => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlertSummaryCopyWith<AlertSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertSummaryCopyWith<$Res> {
  factory $AlertSummaryCopyWith(
          AlertSummary value, $Res Function(AlertSummary) then) =
      _$AlertSummaryCopyWithImpl<$Res, AlertSummary>;
  @useResult
  $Res call(
      {String id,
      String status,
      @DateTimeConverter() DateTime createdAt,
      @NullableDateTimeConverter() DateTime? resolvedAt,
      int sentCount,
      int failedCount,
      int totalCount});
}

/// @nodoc
class _$AlertSummaryCopyWithImpl<$Res, $Val extends AlertSummary>
    implements $AlertSummaryCopyWith<$Res> {
  _$AlertSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
    Object? sentCount = null,
    Object? failedCount = null,
    Object? totalCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sentCount: null == sentCount
          ? _value.sentCount
          : sentCount // ignore: cast_nullable_to_non_nullable
              as int,
      failedCount: null == failedCount
          ? _value.failedCount
          : failedCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertSummaryImplCopyWith<$Res>
    implements $AlertSummaryCopyWith<$Res> {
  factory _$$AlertSummaryImplCopyWith(
          _$AlertSummaryImpl value, $Res Function(_$AlertSummaryImpl) then) =
      __$$AlertSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String status,
      @DateTimeConverter() DateTime createdAt,
      @NullableDateTimeConverter() DateTime? resolvedAt,
      int sentCount,
      int failedCount,
      int totalCount});
}

/// @nodoc
class __$$AlertSummaryImplCopyWithImpl<$Res>
    extends _$AlertSummaryCopyWithImpl<$Res, _$AlertSummaryImpl>
    implements _$$AlertSummaryImplCopyWith<$Res> {
  __$$AlertSummaryImplCopyWithImpl(
      _$AlertSummaryImpl _value, $Res Function(_$AlertSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
    Object? sentCount = null,
    Object? failedCount = null,
    Object? totalCount = null,
  }) {
    return _then(_$AlertSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sentCount: null == sentCount
          ? _value.sentCount
          : sentCount // ignore: cast_nullable_to_non_nullable
              as int,
      failedCount: null == failedCount
          ? _value.failedCount
          : failedCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertSummaryImpl extends _AlertSummary {
  const _$AlertSummaryImpl(
      {required this.id,
      required this.status,
      @DateTimeConverter() required this.createdAt,
      @NullableDateTimeConverter() this.resolvedAt,
      this.sentCount = 0,
      this.failedCount = 0,
      this.totalCount = 0})
      : super._();

  factory _$AlertSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String status;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  @NullableDateTimeConverter()
  final DateTime? resolvedAt;
  @override
  @JsonKey()
  final int sentCount;
  @override
  @JsonKey()
  final int failedCount;
  @override
  @JsonKey()
  final int totalCount;

  @override
  String toString() {
    return 'AlertSummary(id: $id, status: $status, createdAt: $createdAt, resolvedAt: $resolvedAt, sentCount: $sentCount, failedCount: $failedCount, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.sentCount, sentCount) ||
                other.sentCount == sentCount) &&
            (identical(other.failedCount, failedCount) ||
                other.failedCount == failedCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, createdAt,
      resolvedAt, sentCount, failedCount, totalCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertSummaryImplCopyWith<_$AlertSummaryImpl> get copyWith =>
      __$$AlertSummaryImplCopyWithImpl<_$AlertSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertSummaryImplToJson(
      this,
    );
  }
}

abstract class _AlertSummary extends AlertSummary {
  const factory _AlertSummary(
      {required final String id,
      required final String status,
      @DateTimeConverter() required final DateTime createdAt,
      @NullableDateTimeConverter() final DateTime? resolvedAt,
      final int sentCount,
      final int failedCount,
      final int totalCount}) = _$AlertSummaryImpl;
  const _AlertSummary._() : super._();

  factory _AlertSummary.fromJson(Map<String, dynamic> json) =
      _$AlertSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get status;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @NullableDateTimeConverter()
  DateTime? get resolvedAt;
  @override
  int get sentCount;
  @override
  int get failedCount;
  @override
  int get totalCount;
  @override
  @JsonKey(ignore: true)
  _$$AlertSummaryImplCopyWith<_$AlertSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
