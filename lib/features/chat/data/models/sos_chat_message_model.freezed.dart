// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_chat_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SosChatMessageModel _$SosChatMessageModelFromJson(Map<String, dynamic> json) {
  return _SosChatMessageModel.fromJson(json);
}

/// @nodoc
mixin _$SosChatMessageModel {
  @JsonKey(name: 'seq')
  int get sequence => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'from')
  String get sender => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'mine')
  bool get isMine => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SosChatMessageModelCopyWith<SosChatMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosChatMessageModelCopyWith<$Res> {
  factory $SosChatMessageModelCopyWith(
          SosChatMessageModel value, $Res Function(SosChatMessageModel) then) =
      _$SosChatMessageModelCopyWithImpl<$Res, SosChatMessageModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'seq') int sequence,
      String id,
      @JsonKey(name: 'from') String sender,
      String body,
      @DateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'mine') bool isMine});
}

/// @nodoc
class _$SosChatMessageModelCopyWithImpl<$Res, $Val extends SosChatMessageModel>
    implements $SosChatMessageModelCopyWith<$Res> {
  _$SosChatMessageModelCopyWithImpl(this._value, this._then);

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
    Object? body = null,
    Object? createdAt = null,
    Object? isMine = null,
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
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMine: null == isMine
          ? _value.isMine
          : isMine // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SosChatMessageModelImplCopyWith<$Res>
    implements $SosChatMessageModelCopyWith<$Res> {
  factory _$$SosChatMessageModelImplCopyWith(_$SosChatMessageModelImpl value,
          $Res Function(_$SosChatMessageModelImpl) then) =
      __$$SosChatMessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'seq') int sequence,
      String id,
      @JsonKey(name: 'from') String sender,
      String body,
      @DateTimeConverter() DateTime createdAt,
      @JsonKey(name: 'mine') bool isMine});
}

/// @nodoc
class __$$SosChatMessageModelImplCopyWithImpl<$Res>
    extends _$SosChatMessageModelCopyWithImpl<$Res, _$SosChatMessageModelImpl>
    implements _$$SosChatMessageModelImplCopyWith<$Res> {
  __$$SosChatMessageModelImplCopyWithImpl(_$SosChatMessageModelImpl _value,
      $Res Function(_$SosChatMessageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequence = null,
    Object? id = null,
    Object? sender = null,
    Object? body = null,
    Object? createdAt = null,
    Object? isMine = null,
  }) {
    return _then(_$SosChatMessageModelImpl(
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
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMine: null == isMine
          ? _value.isMine
          : isMine // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SosChatMessageModelImpl extends _SosChatMessageModel {
  const _$SosChatMessageModelImpl(
      {@JsonKey(name: 'seq') required this.sequence,
      required this.id,
      @JsonKey(name: 'from') required this.sender,
      required this.body,
      @DateTimeConverter() required this.createdAt,
      @JsonKey(name: 'mine') this.isMine = false})
      : super._();

  factory _$SosChatMessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosChatMessageModelImplFromJson(json);

  @override
  @JsonKey(name: 'seq')
  final int sequence;
  @override
  final String id;
  @override
  @JsonKey(name: 'from')
  final String sender;
  @override
  final String body;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  @JsonKey(name: 'mine')
  final bool isMine;

  @override
  String toString() {
    return 'SosChatMessageModel(sequence: $sequence, id: $id, sender: $sender, body: $body, createdAt: $createdAt, isMine: $isMine)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosChatMessageModelImpl &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isMine, isMine) || other.isMine == isMine));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sequence, id, sender, body, createdAt, isMine);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SosChatMessageModelImplCopyWith<_$SosChatMessageModelImpl> get copyWith =>
      __$$SosChatMessageModelImplCopyWithImpl<_$SosChatMessageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosChatMessageModelImplToJson(
      this,
    );
  }
}

abstract class _SosChatMessageModel extends SosChatMessageModel {
  const factory _SosChatMessageModel(
      {@JsonKey(name: 'seq') required final int sequence,
      required final String id,
      @JsonKey(name: 'from') required final String sender,
      required final String body,
      @DateTimeConverter() required final DateTime createdAt,
      @JsonKey(name: 'mine') final bool isMine}) = _$SosChatMessageModelImpl;
  const _SosChatMessageModel._() : super._();

  factory _SosChatMessageModel.fromJson(Map<String, dynamic> json) =
      _$SosChatMessageModelImpl.fromJson;

  @override
  @JsonKey(name: 'seq')
  int get sequence;
  @override
  String get id;
  @override
  @JsonKey(name: 'from')
  String get sender;
  @override
  String get body;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(name: 'mine')
  bool get isMine;
  @override
  @JsonKey(ignore: true)
  _$$SosChatMessageModelImplCopyWith<_$SosChatMessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
