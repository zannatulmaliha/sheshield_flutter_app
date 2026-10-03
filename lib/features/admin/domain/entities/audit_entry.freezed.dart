// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuditEntry {
  String get id => throw _privateConstructorUsedError;
  String get actorId => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get targetId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuditEntryCopyWith<AuditEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditEntryCopyWith<$Res> {
  factory $AuditEntryCopyWith(
          AuditEntry value, $Res Function(AuditEntry) then) =
      _$AuditEntryCopyWithImpl<$Res, AuditEntry>;
  @useResult
  $Res call(
      {String id,
      String actorId,
      String action,
      DateTime createdAt,
      String? targetId});
}

/// @nodoc
class _$AuditEntryCopyWithImpl<$Res, $Val extends AuditEntry>
    implements $AuditEntryCopyWith<$Res> {
  _$AuditEntryCopyWithImpl(this._value, this._then);

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
abstract class _$$AuditEntryImplCopyWith<$Res>
    implements $AuditEntryCopyWith<$Res> {
  factory _$$AuditEntryImplCopyWith(
          _$AuditEntryImpl value, $Res Function(_$AuditEntryImpl) then) =
      __$$AuditEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String actorId,
      String action,
      DateTime createdAt,
      String? targetId});
}

/// @nodoc
class __$$AuditEntryImplCopyWithImpl<$Res>
    extends _$AuditEntryCopyWithImpl<$Res, _$AuditEntryImpl>
    implements _$$AuditEntryImplCopyWith<$Res> {
  __$$AuditEntryImplCopyWithImpl(
      _$AuditEntryImpl _value, $Res Function(_$AuditEntryImpl) _then)
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
    return _then(_$AuditEntryImpl(
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

class _$AuditEntryImpl implements _AuditEntry {
  const _$AuditEntryImpl(
      {required this.id,
      required this.actorId,
      required this.action,
      required this.createdAt,
      this.targetId});

  @override
  final String id;
  @override
  final String actorId;
  @override
  final String action;
  @override
  final DateTime createdAt;
  @override
  final String? targetId;

  @override
  String toString() {
    return 'AuditEntry(id: $id, actorId: $actorId, action: $action, createdAt: $createdAt, targetId: $targetId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.actorId, actorId) || other.actorId == actorId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, actorId, action, createdAt, targetId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditEntryImplCopyWith<_$AuditEntryImpl> get copyWith =>
      __$$AuditEntryImplCopyWithImpl<_$AuditEntryImpl>(this, _$identity);
}

abstract class _AuditEntry implements AuditEntry {
  const factory _AuditEntry(
      {required final String id,
      required final String actorId,
      required final String action,
      required final DateTime createdAt,
      final String? targetId}) = _$AuditEntryImpl;

  @override
  String get id;
  @override
  String get actorId;
  @override
  String get action;
  @override
  DateTime get createdAt;
  @override
  String? get targetId;
  @override
  @JsonKey(ignore: true)
  _$$AuditEntryImplCopyWith<_$AuditEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
