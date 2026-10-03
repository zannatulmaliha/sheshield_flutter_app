// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_reply_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatReplyModel _$ChatReplyModelFromJson(Map<String, dynamic> json) {
  return _ChatReplyModel.fromJson(json);
}

/// @nodoc
mixin _$ChatReplyModel {
  String get reply => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatReplyModelCopyWith<ChatReplyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatReplyModelCopyWith<$Res> {
  factory $ChatReplyModelCopyWith(
          ChatReplyModel value, $Res Function(ChatReplyModel) then) =
      _$ChatReplyModelCopyWithImpl<$Res, ChatReplyModel>;
  @useResult
  $Res call({String reply});
}

/// @nodoc
class _$ChatReplyModelCopyWithImpl<$Res, $Val extends ChatReplyModel>
    implements $ChatReplyModelCopyWith<$Res> {
  _$ChatReplyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reply = null,
  }) {
    return _then(_value.copyWith(
      reply: null == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatReplyModelImplCopyWith<$Res>
    implements $ChatReplyModelCopyWith<$Res> {
  factory _$$ChatReplyModelImplCopyWith(_$ChatReplyModelImpl value,
          $Res Function(_$ChatReplyModelImpl) then) =
      __$$ChatReplyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reply});
}

/// @nodoc
class __$$ChatReplyModelImplCopyWithImpl<$Res>
    extends _$ChatReplyModelCopyWithImpl<$Res, _$ChatReplyModelImpl>
    implements _$$ChatReplyModelImplCopyWith<$Res> {
  __$$ChatReplyModelImplCopyWithImpl(
      _$ChatReplyModelImpl _value, $Res Function(_$ChatReplyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reply = null,
  }) {
    return _then(_$ChatReplyModelImpl(
      reply: null == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatReplyModelImpl implements _ChatReplyModel {
  const _$ChatReplyModelImpl({required this.reply});

  factory _$ChatReplyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatReplyModelImplFromJson(json);

  @override
  final String reply;

  @override
  String toString() {
    return 'ChatReplyModel(reply: $reply)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatReplyModelImpl &&
            (identical(other.reply, reply) || other.reply == reply));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, reply);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatReplyModelImplCopyWith<_$ChatReplyModelImpl> get copyWith =>
      __$$ChatReplyModelImplCopyWithImpl<_$ChatReplyModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatReplyModelImplToJson(
      this,
    );
  }
}

abstract class _ChatReplyModel implements ChatReplyModel {
  const factory _ChatReplyModel({required final String reply}) =
      _$ChatReplyModelImpl;

  factory _ChatReplyModel.fromJson(Map<String, dynamic> json) =
      _$ChatReplyModelImpl.fromJson;

  @override
  String get reply;
  @override
  @JsonKey(ignore: true)
  _$$ChatReplyModelImplCopyWith<_$ChatReplyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
