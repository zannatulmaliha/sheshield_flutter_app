// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppFailure {
  String get message => throw _privateConstructorUsedError;
  bool get unauthorized => throw _privateConstructorUsedError;

  /// HTTP status when the failure came from a server response.
  int? get statusCode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppFailureCopyWith<AppFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppFailureCopyWith<$Res> {
  factory $AppFailureCopyWith(
          AppFailure value, $Res Function(AppFailure) then) =
      _$AppFailureCopyWithImpl<$Res, AppFailure>;
  @useResult
  $Res call({String message, bool unauthorized, int? statusCode});
}

/// @nodoc
class _$AppFailureCopyWithImpl<$Res, $Val extends AppFailure>
    implements $AppFailureCopyWith<$Res> {
  _$AppFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? unauthorized = null,
    Object? statusCode = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      unauthorized: null == unauthorized
          ? _value.unauthorized
          : unauthorized // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppFailureImplCopyWith<$Res>
    implements $AppFailureCopyWith<$Res> {
  factory _$$AppFailureImplCopyWith(
          _$AppFailureImpl value, $Res Function(_$AppFailureImpl) then) =
      __$$AppFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, bool unauthorized, int? statusCode});
}

/// @nodoc
class __$$AppFailureImplCopyWithImpl<$Res>
    extends _$AppFailureCopyWithImpl<$Res, _$AppFailureImpl>
    implements _$$AppFailureImplCopyWith<$Res> {
  __$$AppFailureImplCopyWithImpl(
      _$AppFailureImpl _value, $Res Function(_$AppFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? unauthorized = null,
    Object? statusCode = freezed,
  }) {
    return _then(_$AppFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      unauthorized: null == unauthorized
          ? _value.unauthorized
          : unauthorized // ignore: cast_nullable_to_non_nullable
              as bool,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$AppFailureImpl extends _AppFailure {
  const _$AppFailureImpl(
      {required this.message, this.unauthorized = false, this.statusCode})
      : super._();

  @override
  final String message;
  @override
  @JsonKey()
  final bool unauthorized;

  /// HTTP status when the failure came from a server response.
  @override
  final int? statusCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.unauthorized, unauthorized) ||
                other.unauthorized == unauthorized) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, unauthorized, statusCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppFailureImplCopyWith<_$AppFailureImpl> get copyWith =>
      __$$AppFailureImplCopyWithImpl<_$AppFailureImpl>(this, _$identity);
}

abstract class _AppFailure extends AppFailure {
  const factory _AppFailure(
      {required final String message,
      final bool unauthorized,
      final int? statusCode}) = _$AppFailureImpl;
  const _AppFailure._() : super._();

  @override
  String get message;
  @override
  bool get unauthorized;
  @override

  /// HTTP status when the failure came from a server response.
  int? get statusCode;
  @override
  @JsonKey(ignore: true)
  _$$AppFailureImplCopyWith<_$AppFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
