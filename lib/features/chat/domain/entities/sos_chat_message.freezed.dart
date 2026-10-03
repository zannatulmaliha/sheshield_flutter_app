// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SosChatMessage {
  /// Monotonic cursor used to ask only for newer messages.
  int get sequence => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  bool get isMine => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SosChatMessageCopyWith<SosChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosChatMessageCopyWith<$Res> {
  factory $SosChatMessageCopyWith(
          SosChatMessage value, $Res Function(SosChatMessage) then) =
      _$SosChatMessageCopyWithImpl<$Res, SosChatMessage>;
  @useResult
  $Res call(
      {int sequence,
      String id,
      String sender,
      bool isMine,
      String body,
      DateTime createdAt});
}

/// @nodoc
class _$SosChatMessageCopyWithImpl<$Res, $Val extends SosChatMessage>
    implements $SosChatMessageCopyWith<$Res> {
  _$SosChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = null,
    Object? id = null,
    Object? sender = null,
    Object? isMine = null,
    Object? body = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      sequence: null == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      isMine: null == isMine
          ? _value.isMine
          : isMine // ignore: cast_nullable_to_non_nullable
              as bool,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosChatMessageImplCopyWith<$Res>
    implements $SosChatMessageCopyWith<$Res> {
  factory _$$SosChatMessageImplCopyWith(_$SosChatMessageImpl value,
          $Res Function(_$SosChatMessageImpl) then) =
      __$$SosChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int sequence,
      String id,
      String sender,
      bool isMine,
      String body,
      DateTime createdAt});
}

/// @nodoc
class __$$SosChatMessageImplCopyWithImpl<$Res>
    extends _$SosChatMessageCopyWithImpl<$Res, _$SosChatMessageImpl>
    implements _$$SosChatMessageImplCopyWith<$Res> {
  __$$SosChatMessageImplCopyWithImpl(
      _$SosChatMessageImpl _value, $Res Function(_$SosChatMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = null,
    Object? id = null,
    Object? sender = null,
    Object? isMine = null,
    Object? body = null,
    Object? createdAt = null,
  }) {
    return _then(_$SosChatMessageImpl(
      sequence: null == sequence
          ? _value.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      isMine: null == isMine
          ? _value.isMine
          : isMine // ignore: cast_nullable_to_non_nullable
              as bool,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$SosChatMessageImpl implements _SosChatMessage {
  const _$SosChatMessageImpl(
      {required this.sequence,
      required this.id,
      required this.sender,
      required this.isMine,
      required this.body,
      required this.createdAt});

  /// Monotonic cursor used to ask only for newer messages.
  @override
  final int sequence;
  @override
  final String id;
  @override
  final String sender;
  @override
  final bool isMine;
  @override
  final String body;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'SosChatMessage(sequence: $sequence, id: $id, sender: $sender, isMine: $isMine, body: $body, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosChatMessageImpl &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.isMine, isMine) || other.isMine == isMine) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, sequence, id, sender, isMine, body, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SosChatMessageImplCopyWith<_$SosChatMessageImpl> get copyWith =>
      __$$SosChatMessageImplCopyWithImpl<_$SosChatMessageImpl>(
          this, _$identity);
}

abstract class _SosChatMessage implements SosChatMessage {
  const factory _SosChatMessage(
      {required final int sequence,
      required final String id,
      required final String sender,
      required final bool isMine,
      required final String body,
      required final DateTime createdAt}) = _$SosChatMessageImpl;

  @override

  /// Monotonic cursor used to ask only for newer messages.
  int get sequence;
  @override
  String get id;
  @override
  String get sender;
  @override
  bool get isMine;
  @override
  String get body;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$SosChatMessageImplCopyWith<_$SosChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
