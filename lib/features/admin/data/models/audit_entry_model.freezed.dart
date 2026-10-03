// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuditEntryModel _$AuditEntryModelFromJson(Map<String, dynamic> json) {
  return _AuditEntryModel.fromJson(json);
}

/// @nodoc
mixin _$AuditEntryModel {
  String get id => throw _privateConstructorUsedError;
  String get actorId => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get targetId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuditEntryModelCopyWith<AuditEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditEntryModelCopyWith<$Res> {
  factory $AuditEntryModelCopyWith(
          AuditEntryModel value, $Res Function(AuditEntryModel) then) =
      _$AuditEntryModelCopyWithImpl<$Res, AuditEntryModel>;
  @useResult
  $Res call(
      {String id,
      String actorId,
      String action,
      @DateTimeConverter() DateTime createdAt,
      String? targetId});
}

/// @nodoc
class _$AuditEntryModelCopyWithImpl<$Res, $Val extends AuditEntryModel>
    implements $AuditEntryModelCopyWith<$Res> {
  _$AuditEntryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actorId = null,
    Object? action = null,
    Object? createdAt = null,
    Object? targetId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      actorId: null == actorId
          ? _value.actorId
          : actorId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuditEntryModelImplCopyWith<$Res>
    implements $AuditEntryModelCopyWith<$Res> {
  factory _$$AuditEntryModelImplCopyWith(_$AuditEntryModelImpl value,
          $Res Function(_$AuditEntryModelImpl) then) =
      __$$AuditEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String actorId,
      String action,
      @DateTimeConverter() DateTime createdAt,
      String? targetId});
}

/// @nodoc
class __$$AuditEntryModelImplCopyWithImpl<$Res>
    extends _$AuditEntryModelCopyWithImpl<$Res, _$AuditEntryModelImpl>
    implements _$$AuditEntryModelImplCopyWith<$Res> {
  __$$AuditEntryModelImplCopyWithImpl(
      _$AuditEntryModelImpl _value, $Res Function(_$AuditEntryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actorId = null,
    Object? action = null,
    Object? createdAt = null,
    Object? targetId = freezed,
  }) {
    return _then(_$AuditEntryModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      actorId: null == actorId
          ? _value.actorId
          : actorId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuditEntryModelImpl extends _AuditEntryModel {
  const _$AuditEntryModelImpl(
      {this.id = '',
      this.actorId = '',
      this.action = '',
      @DateTimeConverter() required this.createdAt,
      this.targetId})
      : super._();

  factory _$AuditEntryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditEntryModelImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String actorId;
  @override
  @JsonKey()
  final String action;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  final String? targetId;

  @override
  String toString() {
    return 'AuditEntryModel(id: $id, actorId: $actorId, action: $action, createdAt: $createdAt, targetId: $targetId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditEntryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.actorId, actorId) || other.actorId == actorId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, actorId, action, createdAt, targetId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditEntryModelImplCopyWith<_$AuditEntryModelImpl> get copyWith =>
      __$$AuditEntryModelImplCopyWithImpl<_$AuditEntryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditEntryModelImplToJson(
      this,
    );
  }
}

abstract class _AuditEntryModel extends AuditEntryModel {
  const factory _AuditEntryModel(
      {final String id,
      final String actorId,
      final String action,
      @DateTimeConverter() required final DateTime createdAt,
      final String? targetId}) = _$AuditEntryModelImpl;
  const _AuditEntryModel._() : super._();

  factory _AuditEntryModel.fromJson(Map<String, dynamic> json) =
      _$AuditEntryModelImpl.fromJson;

  @override
  String get id;
  @override
  String get actorId;
  @override
  String get action;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  String? get targetId;
  @override
  @JsonKey(ignore: true)
  _$$AuditEntryModelImplCopyWith<_$AuditEntryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
