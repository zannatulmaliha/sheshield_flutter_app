// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerificationStatus _$VerificationStatusFromJson(Map<String, dynamic> json) {
  return _VerificationStatus.fromJson(json);
}

/// @nodoc
mixin _$VerificationStatus {
  VerificationState get status => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  DateTime? get submittedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerificationStatusCopyWith<VerificationStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationStatusCopyWith<$Res> {
  factory $VerificationStatusCopyWith(
          VerificationStatus value, $Res Function(VerificationStatus) then) =
      _$VerificationStatusCopyWithImpl<$Res, VerificationStatus>;
  @useResult
  $Res call({VerificationState status, String note, DateTime? submittedAt});
}

/// @nodoc
class _$VerificationStatusCopyWithImpl<$Res, $Val extends VerificationStatus>
    implements $VerificationStatusCopyWith<$Res> {
  _$VerificationStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? note = null,
    Object? submittedAt = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VerificationState,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerificationStatusImplCopyWith<$Res>
    implements $VerificationStatusCopyWith<$Res> {
  factory _$$VerificationStatusImplCopyWith(_$VerificationStatusImpl value,
          $Res Function(_$VerificationStatusImpl) then) =
      __$$VerificationStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({VerificationState status, String note, DateTime? submittedAt});
}

/// @nodoc
class __$$VerificationStatusImplCopyWithImpl<$Res>
    extends _$VerificationStatusCopyWithImpl<$Res, _$VerificationStatusImpl>
    implements _$$VerificationStatusImplCopyWith<$Res> {
  __$$VerificationStatusImplCopyWithImpl(_$VerificationStatusImpl _value,
      $Res Function(_$VerificationStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? note = null,
    Object? submittedAt = freezed,
  }) {
    return _then(_$VerificationStatusImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VerificationState,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerificationStatusImpl implements _VerificationStatus {
  const _$VerificationStatusImpl(
      {required this.status, this.note = '', this.submittedAt});

  factory _$VerificationStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerificationStatusImplFromJson(json);

  @override
  final VerificationState status;
  @override
  @JsonKey()
  final String note;
  @override
  final DateTime? submittedAt;

  @override
  String toString() {
    return 'VerificationStatus(status: $status, note: $note, submittedAt: $submittedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationStatusImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, note, submittedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationStatusImplCopyWith<_$VerificationStatusImpl> get copyWith =>
      __$$VerificationStatusImplCopyWithImpl<_$VerificationStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerificationStatusImplToJson(
      this,
    );
  }
}

abstract class _VerificationStatus implements VerificationStatus {
  const factory _VerificationStatus(
      {required final VerificationState status,
      final String note,
      final DateTime? submittedAt}) = _$VerificationStatusImpl;

  factory _VerificationStatus.fromJson(Map<String, dynamic> json) =
      _$VerificationStatusImpl.fromJson;

  @override
  VerificationState get status;
  @override
  String get note;
  @override
  DateTime? get submittedAt;
  @override
  @JsonKey(ignore: true)
  _$$VerificationStatusImplCopyWith<_$VerificationStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
