// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'responder_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResponderStateModel _$ResponderStateModelFromJson(Map<String, dynamic> json) {
  return _ResponderStateModel.fromJson(json);
}

/// @nodoc
mixin _$ResponderStateModel {
  String get status => throw _privateConstructorUsedError;
  bool get helperAccepted => throw _privateConstructorUsedError;
  @JsonKey(name: 'helperProgress')
  String get progress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponderStateModelCopyWith<ResponderStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponderStateModelCopyWith<$Res> {
  factory $ResponderStateModelCopyWith(
          ResponderStateModel value, $Res Function(ResponderStateModel) then) =
      _$ResponderStateModelCopyWithImpl<$Res, ResponderStateModel>;
  @useResult
  $Res call(
      {String status,
      bool helperAccepted,
      @JsonKey(name: 'helperProgress') String progress});
}

/// @nodoc
class _$ResponderStateModelCopyWithImpl<$Res, $Val extends ResponderStateModel>
    implements $ResponderStateModelCopyWith<$Res> {
  _$ResponderStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? helperAccepted = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      helperAccepted: null == helperAccepted
          ? _value.helperAccepted
          : helperAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResponderStateModelImplCopyWith<$Res>
    implements $ResponderStateModelCopyWith<$Res> {
  factory _$$ResponderStateModelImplCopyWith(_$ResponderStateModelImpl value,
          $Res Function(_$ResponderStateModelImpl) then) =
      __$$ResponderStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      bool helperAccepted,
      @JsonKey(name: 'helperProgress') String progress});
}

/// @nodoc
class __$$ResponderStateModelImplCopyWithImpl<$Res>
    extends _$ResponderStateModelCopyWithImpl<$Res, _$ResponderStateModelImpl>
    implements _$$ResponderStateModelImplCopyWith<$Res> {
  __$$ResponderStateModelImplCopyWithImpl(_$ResponderStateModelImpl _value,
      $Res Function(_$ResponderStateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? helperAccepted = null,
    Object? progress = null,
  }) {
    return _then(_$ResponderStateModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      helperAccepted: null == helperAccepted
          ? _value.helperAccepted
          : helperAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResponderStateModelImpl extends _ResponderStateModel {
  const _$ResponderStateModelImpl(
      {this.status = '',
      this.helperAccepted = false,
      @JsonKey(name: 'helperProgress') this.progress = ''})
      : super._();

  factory _$ResponderStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResponderStateModelImplFromJson(json);

  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final bool helperAccepted;
  @override
  @JsonKey(name: 'helperProgress')
  final String progress;

  @override
  String toString() {
    return 'ResponderStateModel(status: $status, helperAccepted: $helperAccepted, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponderStateModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.helperAccepted, helperAccepted) ||
                other.helperAccepted == helperAccepted) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, helperAccepted, progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponderStateModelImplCopyWith<_$ResponderStateModelImpl> get copyWith =>
      __$$ResponderStateModelImplCopyWithImpl<_$ResponderStateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResponderStateModelImplToJson(
      this,
    );
  }
}

abstract class _ResponderStateModel extends ResponderStateModel {
  const factory _ResponderStateModel(
          {final String status,
          final bool helperAccepted,
          @JsonKey(name: 'helperProgress') final String progress}) =
      _$ResponderStateModelImpl;
  const _ResponderStateModel._() : super._();

  factory _ResponderStateModel.fromJson(Map<String, dynamic> json) =
      _$ResponderStateModelImpl.fromJson;

  @override
  String get status;
  @override
  bool get helperAccepted;
  @override
  @JsonKey(name: 'helperProgress')
  String get progress;
  @override
  @JsonKey(ignore: true)
  _$$ResponderStateModelImplCopyWith<_$ResponderStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
