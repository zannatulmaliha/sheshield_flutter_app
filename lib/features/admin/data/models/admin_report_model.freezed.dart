// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminReportModel _$AdminReportModelFromJson(Map<String, dynamic> json) {
  return _AdminReportModel.fromJson(json);
}

/// @nodoc
mixin _$AdminReportModel {
  String get id => throw _privateConstructorUsedError;
  String get reporterId => throw _privateConstructorUsedError;
  String get reportedId => throw _privateConstructorUsedError;
  String get reporterRole => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get reviewStatus => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get sosId => throw _privateConstructorUsedError;
  String? get reviewerId => throw _privateConstructorUsedError;
  String? get resolution => throw _privateConstructorUsedError;
  @NullableDateTimeConverter()
  DateTime? get reviewedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdminReportModelCopyWith<AdminReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminReportModelCopyWith<$Res> {
  factory $AdminReportModelCopyWith(
          AdminReportModel value, $Res Function(AdminReportModel) then) =
      _$AdminReportModelCopyWithImpl<$Res, AdminReportModel>;
  @useResult
  $Res call(
      {String id,
      String reporterId,
      String reportedId,
      String reporterRole,
      String category,
      String reviewStatus,
      @DateTimeConverter() DateTime createdAt,
      String? sosId,
      String? reviewerId,
      String? resolution,
      @NullableDateTimeConverter() DateTime? reviewedAt});
}

/// @nodoc
class _$AdminReportModelCopyWithImpl<$Res, $Val extends AdminReportModel>
    implements $AdminReportModelCopyWith<$Res> {
  _$AdminReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reporterId = null,
    Object? reportedId = null,
    Object? reporterRole = null,
    Object? category = null,
    Object? reviewStatus = null,
    Object? createdAt = null,
    Object? sosId = freezed,
    Object? reviewerId = freezed,
    Object? resolution = freezed,
    Object? reviewedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      reporterId: null == reporterId
          ? _value.reporterId
          : reporterId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedId: null == reportedId
          ? _value.reportedId
          : reportedId // ignore: cast_nullable_to_non_nullable
              as String,
      reporterRole: null == reporterRole
          ? _value.reporterRole
          : reporterRole // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      reviewStatus: null == reviewStatus
          ? _value.reviewStatus
          : reviewStatus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sosId: freezed == sosId
          ? _value.sosId
          : sosId // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewerId: freezed == reviewerId
          ? _value.reviewerId
          : reviewerId // ignore: cast_nullable_to_non_nullable
              as String?,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminReportModelImplCopyWith<$Res>
    implements $AdminReportModelCopyWith<$Res> {
  factory _$$AdminReportModelImplCopyWith(_$AdminReportModelImpl value,
          $Res Function(_$AdminReportModelImpl) then) =
      __$$AdminReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String reporterId,
      String reportedId,
      String reporterRole,
      String category,
      String reviewStatus,
      @DateTimeConverter() DateTime createdAt,
      String? sosId,
      String? reviewerId,
      String? resolution,
      @NullableDateTimeConverter() DateTime? reviewedAt});
}

/// @nodoc
class __$$AdminReportModelImplCopyWithImpl<$Res>
    extends _$AdminReportModelCopyWithImpl<$Res, _$AdminReportModelImpl>
    implements _$$AdminReportModelImplCopyWith<$Res> {
  __$$AdminReportModelImplCopyWithImpl(_$AdminReportModelImpl _value,
      $Res Function(_$AdminReportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reporterId = null,
    Object? reportedId = null,
    Object? reporterRole = null,
    Object? category = null,
    Object? reviewStatus = null,
    Object? createdAt = null,
    Object? sosId = freezed,
    Object? reviewerId = freezed,
    Object? resolution = freezed,
    Object? reviewedAt = freezed,
  }) {
    return _then(_$AdminReportModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      reporterId: null == reporterId
          ? _value.reporterId
          : reporterId // ignore: cast_nullable_to_non_nullable
              as String,
      reportedId: null == reportedId
          ? _value.reportedId
          : reportedId // ignore: cast_nullable_to_non_nullable
              as String,
      reporterRole: null == reporterRole
          ? _value.reporterRole
          : reporterRole // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      reviewStatus: null == reviewStatus
          ? _value.reviewStatus
          : reviewStatus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sosId: freezed == sosId
          ? _value.sosId
          : sosId // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewerId: freezed == reviewerId
          ? _value.reviewerId
          : reviewerId // ignore: cast_nullable_to_non_nullable
              as String?,
      resolution: freezed == resolution
          ? _value.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminReportModelImpl extends _AdminReportModel {
  const _$AdminReportModelImpl(
      {required this.id,
      this.reporterId = '',
      this.reportedId = '',
      this.reporterRole = '',
      this.category = '',
      this.reviewStatus = 'pending',
      @DateTimeConverter() required this.createdAt,
      this.sosId,
      this.reviewerId,
      this.resolution,
      @NullableDateTimeConverter() this.reviewedAt})
      : super._();

  factory _$AdminReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminReportModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String reporterId;
  @override
  @JsonKey()
  final String reportedId;
  @override
  @JsonKey()
  final String reporterRole;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String reviewStatus;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  final String? sosId;
  @override
  final String? reviewerId;
  @override
  final String? resolution;
  @override
  @NullableDateTimeConverter()
  final DateTime? reviewedAt;

  @override
  String toString() {
    return 'AdminReportModel(id: $id, reporterId: $reporterId, reportedId: $reportedId, reporterRole: $reporterRole, category: $category, reviewStatus: $reviewStatus, createdAt: $createdAt, sosId: $sosId, reviewerId: $reviewerId, resolution: $resolution, reviewedAt: $reviewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminReportModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reporterId, reporterId) ||
                other.reporterId == reporterId) &&
            (identical(other.reportedId, reportedId) ||
                other.reportedId == reportedId) &&
            (identical(other.reporterRole, reporterRole) ||
                other.reporterRole == reporterRole) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.reviewStatus, reviewStatus) ||
                other.reviewStatus == reviewStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.sosId, sosId) || other.sosId == sosId) &&
            (identical(other.reviewerId, reviewerId) ||
                other.reviewerId == reviewerId) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      reporterId,
      reportedId,
      reporterRole,
      category,
      reviewStatus,
      createdAt,
      sosId,
      reviewerId,
      resolution,
      reviewedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminReportModelImplCopyWith<_$AdminReportModelImpl> get copyWith =>
      __$$AdminReportModelImplCopyWithImpl<_$AdminReportModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminReportModelImplToJson(
      this,
    );
  }
}

abstract class _AdminReportModel extends AdminReportModel {
  const factory _AdminReportModel(
          {required final String id,
          final String reporterId,
          final String reportedId,
          final String reporterRole,
          final String category,
          final String reviewStatus,
          @DateTimeConverter() required final DateTime createdAt,
          final String? sosId,
          final String? reviewerId,
          final String? resolution,
          @NullableDateTimeConverter() final DateTime? reviewedAt}) =
      _$AdminReportModelImpl;
  const _AdminReportModel._() : super._();

  factory _AdminReportModel.fromJson(Map<String, dynamic> json) =
      _$AdminReportModelImpl.fromJson;

  @override
  String get id;
  @override
  String get reporterId;
  @override
  String get reportedId;
  @override
  String get reporterRole;
  @override
  String get category;
  @override
  String get reviewStatus;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  String? get sosId;
  @override
  String? get reviewerId;
  @override
  String? get resolution;
  @override
  @NullableDateTimeConverter()
  DateTime? get reviewedAt;
  @override
  @JsonKey(ignore: true)
  _$$AdminReportModelImplCopyWith<_$AdminReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
