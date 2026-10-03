// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_report_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AdminReportDetail {
  AdminReport get report => throw _privateConstructorUsedError;
  List<AuditEntry> get auditTrail => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdminReportDetailCopyWith<AdminReportDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminReportDetailCopyWith<$Res> {
  factory $AdminReportDetailCopyWith(
          AdminReportDetail value, $Res Function(AdminReportDetail) then) =
      _$AdminReportDetailCopyWithImpl<$Res, AdminReportDetail>;
  @useResult
  $Res call({AdminReport report, List<AuditEntry> auditTrail});

  $AdminReportCopyWith<$Res> get report;
}

/// @nodoc
class _$AdminReportDetailCopyWithImpl<$Res, $Val extends AdminReportDetail>
    implements $AdminReportDetailCopyWith<$Res> {
  _$AdminReportDetailCopyWithImpl(this._value, this._then);

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
              as AdminReport,
      auditTrail: null == auditTrail
          ? _value.auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as List<AuditEntry>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AdminReportCopyWith<$Res> get report {
    return $AdminReportCopyWith<$Res>(_value.report, (value) {
      return _then(_value.copyWith(report: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdminReportDetailImplCopyWith<$Res>
    implements $AdminReportDetailCopyWith<$Res> {
  factory _$$AdminReportDetailImplCopyWith(_$AdminReportDetailImpl value,
          $Res Function(_$AdminReportDetailImpl) then) =
      __$$AdminReportDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AdminReport report, List<AuditEntry> auditTrail});

  @override
  $AdminReportCopyWith<$Res> get report;
}

/// @nodoc
class __$$AdminReportDetailImplCopyWithImpl<$Res>
    extends _$AdminReportDetailCopyWithImpl<$Res, _$AdminReportDetailImpl>
    implements _$$AdminReportDetailImplCopyWith<$Res> {
  __$$AdminReportDetailImplCopyWithImpl(_$AdminReportDetailImpl _value,
      $Res Function(_$AdminReportDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? report = null,
    Object? auditTrail = null,
  }) {
    return _then(_$AdminReportDetailImpl(
      report: null == report
          ? _value.report
          : report // ignore: cast_nullable_to_non_nullable
              as AdminReport,
      auditTrail: null == auditTrail
          ? _value._auditTrail
          : auditTrail // ignore: cast_nullable_to_non_nullable
              as List<AuditEntry>,
    ));
  }
}

/// @nodoc

class _$AdminReportDetailImpl implements _AdminReportDetail {
  const _$AdminReportDetailImpl(
      {required this.report, required final List<AuditEntry> auditTrail})
      : _auditTrail = auditTrail;

  @override
  final AdminReport report;
  final List<AuditEntry> _auditTrail;
  @override
  List<AuditEntry> get auditTrail {
    if (_auditTrail is EqualUnmodifiableListView) return _auditTrail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_auditTrail);
  }

  @override
  String toString() {
    return 'AdminReportDetail(report: $report, auditTrail: $auditTrail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminReportDetailImpl &&
            (identical(other.report, report) || other.report == report) &&
            const DeepCollectionEquality()
                .equals(other._auditTrail, _auditTrail));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, report, const DeepCollectionEquality().hash(_auditTrail));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminReportDetailImplCopyWith<_$AdminReportDetailImpl> get copyWith =>
      __$$AdminReportDetailImplCopyWithImpl<_$AdminReportDetailImpl>(
          this, _$identity);
}

abstract class _AdminReportDetail implements AdminReportDetail {
  const factory _AdminReportDetail(
      {required final AdminReport report,
      required final List<AuditEntry> auditTrail}) = _$AdminReportDetailImpl;

  @override
  AdminReport get report;
  @override
  List<AuditEntry> get auditTrail;
  @override
  @JsonKey(ignore: true)
  _$$AdminReportDetailImplCopyWith<_$AdminReportDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
