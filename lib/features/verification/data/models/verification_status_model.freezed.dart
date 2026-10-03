// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerificationStatusModel _$VerificationStatusModelFromJson(
    Map<String, dynamic> json) {
  return _VerificationStatusModel.fromJson(json);
}

/// @nodoc
mixin _$VerificationStatusModel {
  String get status => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  @NullableDateTimeConverter()
  DateTime? get submittedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerificationStatusModelCopyWith<VerificationStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationStatusModelCopyWith<$Res> {
  factory $VerificationStatusModelCopyWith(VerificationStatusModel value,
          $Res Function(VerificationStatusModel) then) =
      _$VerificationStatusModelCopyWithImpl<$Res, VerificationStatusModel>;
  @useResult
  $Res call(
      {String status,
      String note,
      @NullableDateTimeConverter() DateTime? submittedAt});
}

/// @nodoc
class _$VerificationStatusModelCopyWithImpl<$Res,
        $Val extends VerificationStatusModel>
    implements $VerificationStatusModelCopyWith<$Res> {
  _$VerificationStatusModelCopyWithImpl(this._value, this._then);

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
              as String,
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
abstract class _$$VerificationStatusModelImplCopyWith<$Res>
    implements $VerificationStatusModelCopyWith<$Res> {
  factory _$$VerificationStatusModelImplCopyWith(
          _$VerificationStatusModelImpl value,
          $Res Function(_$VerificationStatusModelImpl) then) =
      __$$VerificationStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String note,
      @NullableDateTimeConverter() DateTime? submittedAt});
}

/// @nodoc
class __$$VerificationStatusModelImplCopyWithImpl<$Res>
    extends _$VerificationStatusModelCopyWithImpl<$Res,
        _$VerificationStatusModelImpl>
    implements _$$VerificationStatusModelImplCopyWith<$Res> {
  __$$VerificationStatusModelImplCopyWithImpl(
      _$VerificationStatusModelImpl _value,
      $Res Function(_$VerificationStatusModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? note = null,
    Object? submittedAt = freezed,
  }) {
    return _then(_$VerificationStatusModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$VerificationStatusModelImpl extends _VerificationStatusModel {
  const _$VerificationStatusModelImpl(
      {this.status = 'none',
      this.note = '',
      @NullableDateTimeConverter() this.submittedAt})
      : super._();

  factory _$VerificationStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerificationStatusModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String note;
  @override
  @NullableDateTimeConverter()
  final DateTime? submittedAt;

  @override
  String toString() {
    return 'VerificationStatusModel(status: $status, note: $note, submittedAt: $submittedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationStatusModelImpl &&
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
  _$$VerificationStatusModelImplCopyWith<_$VerificationStatusModelImpl>
      get copyWith => __$$VerificationStatusModelImplCopyWithImpl<
          _$VerificationStatusModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerificationStatusModelImplToJson(
      this,
    );
  }
}

abstract class _VerificationStatusModel extends VerificationStatusModel {
  const factory _VerificationStatusModel(
          {final String status,
          final String note,
          @NullableDateTimeConverter() final DateTime? submittedAt}) =
      _$VerificationStatusModelImpl;
  const _VerificationStatusModel._() : super._();

  factory _VerificationStatusModel.fromJson(Map<String, dynamic> json) =
      _$VerificationStatusModelImpl.fromJson;

  @override
  String get status;
  @override
  String get note;
  @override
  @NullableDateTimeConverter()
  DateTime? get submittedAt;
  @override
  @JsonKey(ignore: true)
  _$$VerificationStatusModelImplCopyWith<_$VerificationStatusModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
