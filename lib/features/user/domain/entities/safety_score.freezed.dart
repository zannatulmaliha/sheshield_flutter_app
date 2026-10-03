// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'safety_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SafetyScore {
  int get score => throw _privateConstructorUsedError;
  int get contactsCount => throw _privateConstructorUsedError;
  int get enabledFeatures => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SafetyScoreCopyWith<SafetyScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SafetyScoreCopyWith<$Res> {
  factory $SafetyScoreCopyWith(
          SafetyScore value, $Res Function(SafetyScore) then) =
      _$SafetyScoreCopyWithImpl<$Res, SafetyScore>;
  @useResult
  $Res call(
      {int score, int contactsCount, int enabledFeatures, bool isVerified});
}

/// @nodoc
class _$SafetyScoreCopyWithImpl<$Res, $Val extends SafetyScore>
    implements $SafetyScoreCopyWith<$Res> {
  _$SafetyScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? contactsCount = null,
    Object? enabledFeatures = null,
    Object? isVerified = null,
  }) {
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      contactsCount: null == contactsCount
          ? _value.contactsCount
          : contactsCount // ignore: cast_nullable_to_non_nullable
              as int,
      enabledFeatures: null == enabledFeatures
          ? _value.enabledFeatures
          : enabledFeatures // ignore: cast_nullable_to_non_nullable
              as int,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SafetyScoreImplCopyWith<$Res>
    implements $SafetyScoreCopyWith<$Res> {
  factory _$$SafetyScoreImplCopyWith(
          _$SafetyScoreImpl value, $Res Function(_$SafetyScoreImpl) then) =
      __$$SafetyScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int score, int contactsCount, int enabledFeatures, bool isVerified});
}

/// @nodoc
class __$$SafetyScoreImplCopyWithImpl<$Res>
    extends _$SafetyScoreCopyWithImpl<$Res, _$SafetyScoreImpl>
    implements _$$SafetyScoreImplCopyWith<$Res> {
  __$$SafetyScoreImplCopyWithImpl(
      _$SafetyScoreImpl _value, $Res Function(_$SafetyScoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? contactsCount = null,
    Object? enabledFeatures = null,
    Object? isVerified = null,
  }) {
    return _then(_$SafetyScoreImpl(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      contactsCount: null == contactsCount
          ? _value.contactsCount
          : contactsCount // ignore: cast_nullable_to_non_nullable
              as int,
      enabledFeatures: null == enabledFeatures
          ? _value.enabledFeatures
          : enabledFeatures // ignore: cast_nullable_to_non_nullable
              as int,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SafetyScoreImpl extends _SafetyScore {
  const _$SafetyScoreImpl(
      {required this.score,
      required this.contactsCount,
      required this.enabledFeatures,
      required this.isVerified})
      : super._();

  @override
  final int score;
  @override
  final int contactsCount;
  @override
  final int enabledFeatures;
  @override
  final bool isVerified;

  @override
  String toString() {
    return 'SafetyScore(score: $score, contactsCount: $contactsCount, enabledFeatures: $enabledFeatures, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SafetyScoreImpl &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.contactsCount, contactsCount) ||
                other.contactsCount == contactsCount) &&
            (identical(other.enabledFeatures, enabledFeatures) ||
                other.enabledFeatures == enabledFeatures) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, score, contactsCount, enabledFeatures, isVerified);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SafetyScoreImplCopyWith<_$SafetyScoreImpl> get copyWith =>
      __$$SafetyScoreImplCopyWithImpl<_$SafetyScoreImpl>(this, _$identity);
}

abstract class _SafetyScore extends SafetyScore {
  const factory _SafetyScore(
      {required final int score,
      required final int contactsCount,
      required final int enabledFeatures,
      required final bool isVerified}) = _$SafetyScoreImpl;
  const _SafetyScore._() : super._();

  @override
  int get score;
  @override
  int get contactsCount;
  @override
  int get enabledFeatures;
  @override
  bool get isVerified;
  @override
  @JsonKey(ignore: true)
  _$$SafetyScoreImplCopyWith<_$SafetyScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
