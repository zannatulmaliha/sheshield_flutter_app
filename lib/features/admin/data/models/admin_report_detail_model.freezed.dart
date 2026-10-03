// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_report_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminReportDetailModel _$AdminReportDetailModelFromJson(
    Map<String, dynamic> json) {
  return _AdminReportDetailModel.fromJson(json);
}

/// @nodoc
mixin _$AdminReportDetailModel {
  AdminReportModel get report => throw _privateConstructorUsedError;
  List<AuditEntryModel> get auditTrail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdminReportDetailModelCopyWith<AdminReportDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminReportDetailModelCopyWith<$Res> {
  factory $AdminReportDetailModelCopyWith(AdminReportDetailModel value,
          $Res Function(AdminReportDetailModel) then) =
      _$AdminReportDetailModelCopyWithImpl<$Res, AdminReportDetailModel>;
  @useResult
  $Res call({AdminReportModel report, List<AuditEntryModel> auditTrail});

  $AdminReportModelCopyWith<$Res> get report;
}

/// @nodoc
class _$AdminReportDetailModelCopyWithImpl<$Res,
        $Val extends AdminReportDetailModel>
    implements $AdminReportDetailModelCopyWith<$Res> {
  _$AdminReportDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? report = null,
    Object? auditTrail = null,
  }) {
    return _then(_value.copyWith(
      report: null == report
          ? _value.report
          : report // ignore: cast_nullable_to_non_nullable
              as AdminReportModel,
      auditTrail: null == auditTrail
          ? _value.auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as List<AuditEntryModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AdminReportModelCopyWith<$Res> get report {
    return $AdminReportModelCopyWith<$Res>(_value.report, (value) {
      return _then(_value.copyWith(report: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdminReportDetailModelImplCopyWith<$Res>
    implements $AdminReportDetailModelCopyWith<$Res> {
  factory _$$AdminReportDetailModelImplCopyWith(
          _$AdminReportDetailModelImpl value,
          $Res Function(_$AdminReportDetailModelImpl) then) =
      __$$AdminReportDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AdminReportModel report, List<AuditEntryModel> auditTrail});

  @override
  $AdminReportModelCopyWith<$Res> get report;
}

/// @nodoc
class __$$AdminReportDetailModelImplCopyWithImpl<$Res>
    extends _$AdminReportDetailModelCopyWithImpl<$Res,
        _$AdminReportDetailModelImpl>
    implements _$$AdminReportDetailModelImplCopyWith<$Res> {
  __$$AdminReportDetailModelImplCopyWithImpl(
      _$AdminReportDetailModelImpl _value,
      $Res Function(_$AdminReportDetailModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? report = null,
    Object? auditTrail = null,
  }) {
    return _then(_$AdminReportDetailModelImpl(
      report: null == report
          ? _value.report
          : report // ignore: cast_nullable_to_non_nullable
              as AdminReportModel,
      auditTrail: null == auditTrail
          ? _value._auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as List<AuditEntryModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminReportDetailModelImpl extends _AdminReportDetailModel {
  const _$AdminReportDetailModelImpl(
      {required this.report,
      final List<AuditEntryModel> auditTrail = const <AuditEntryModel>[]})
      : _auditTrail = auditTrail,
        super._();

  factory _$AdminReportDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminReportDetailModelImplFromJson(json);

  @override
  final AdminReportModel report;
  final List<AuditEntryModel> _auditTrail;
  @override
  @JsonKey()
  List<AuditEntryModel> get auditTrail {
    if (_auditTrail is EqualUnmodifiableListView) return _auditTrail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_auditTrail);
  }

  @override
  String toString() {
    return 'AdminReportDetailModel(report: $report, auditTrail: $auditTrail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminReportDetailModelImpl &&
            (identical(other.report, report) || other.report == report) &&
            const DeepCollectionEquality()
                .equals(other._auditTrail, _auditTrail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, report, const DeepCollectionEquality().hash(_auditTrail));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminReportDetailModelImplCopyWith<_$AdminReportDetailModelImpl>
      get copyWith => __$$AdminReportDetailModelImplCopyWithImpl<
          _$AdminReportDetailModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminReportDetailModelImplToJson(
      this,
    );
  }
}

abstract class _AdminReportDetailModel extends AdminReportDetailModel {
  const factory _AdminReportDetailModel(
      {required final AdminReportModel report,
      final List<AuditEntryModel> auditTrail}) = _$AdminReportDetailModelImpl;
  const _AdminReportDetailModel._() : super._();

  factory _AdminReportDetailModel.fromJson(Map<String, dynamic> json) =
      _$AdminReportDetailModelImpl.fromJson;

  @override
  AdminReportModel get report;
  @override
  List<AuditEntryModel> get auditTrail;
  @override
  @JsonKey(ignore: true)
  _$$AdminReportDetailModelImplCopyWith<_$AdminReportDetailModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
