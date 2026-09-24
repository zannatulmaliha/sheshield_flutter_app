// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'helper_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HelperStatus _$HelperStatusFromJson(Map<String, dynamic> json) {
  return _HelperStatus.fromJson(json);
}

/// @nodoc
mixin _$HelperStatus {
  bool get isActive => throw _privateConstructorUsedError;
  double get radiusKm => throw _privateConstructorUsedError;
  bool get mutualConnectionOptIn => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HelperStatusCopyWith<HelperStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelperStatusCopyWith<$Res> {
  factory $HelperStatusCopyWith(
          HelperStatus value, $Res Function(HelperStatus) then) =
      _$HelperStatusCopyWithImpl<$Res, HelperStatus>;
  @useResult
  $Res call({bool isActive, double radiusKm, bool mutualConnectionOptIn});
}

/// @nodoc
class _$HelperStatusCopyWithImpl<$Res, $Val extends HelperStatus>
    implements $HelperStatusCopyWith<$Res> {
  _$HelperStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActive = null,
    Object? radiusKm = null,
    Object? mutualConnectionOptIn = null,
  }) {
    return _then(_value.copyWith(
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      radiusKm: null == radiusKm
          ? _value.radiusKm
          : radiusKm // ignore: cast_nullable_to_non_nullable
              as double,
      mutualConnectionOptIn: null == mutualConnectionOptIn
          ? _value.mutualConnectionOptIn
          : mutualConnectionOptIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HelperStatusImplCopyWith<$Res>
    implements $HelperStatusCopyWith<$Res> {
  factory _$$HelperStatusImplCopyWith(
          _$HelperStatusImpl value, $Res Function(_$HelperStatusImpl) then) =
      __$$HelperStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isActive, double radiusKm, bool mutualConnectionOptIn});
}

/// @nodoc
class __$$HelperStatusImplCopyWithImpl<$Res>
    extends _$HelperStatusCopyWithImpl<$Res, _$HelperStatusImpl>
    implements _$$HelperStatusImplCopyWith<$Res> {
  __$$HelperStatusImplCopyWithImpl(
      _$HelperStatusImpl _value, $Res Function(_$HelperStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActive = null,
    Object? radiusKm = null,
    Object? mutualConnectionOptIn = null,
  }) {
    return _then(_$HelperStatusImpl(
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      radiusKm: null == radiusKm
          ? _value.radiusKm
          : radiusKm // ignore: cast_nullable_to_non_nullable
              as double,
      mutualConnectionOptIn: null == mutualConnectionOptIn
          ? _value.mutualConnectionOptIn
          : mutualConnectionOptIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HelperStatusImpl implements _HelperStatus {
  const _$HelperStatusImpl(
      {this.isActive = false,
      this.radiusKm = 3.0,
      this.mutualConnectionOptIn = false});

  factory _$HelperStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$HelperStatusImplFromJson(json);

  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final double radiusKm;
  @override
  @JsonKey()
  final bool mutualConnectionOptIn;

  @override
  String toString() {
    return 'HelperStatus(isActive: $isActive, radiusKm: $radiusKm, mutualConnectionOptIn: $mutualConnectionOptIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HelperStatusImpl &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.radiusKm, radiusKm) ||
                other.radiusKm == radiusKm) &&
            (identical(other.mutualConnectionOptIn, mutualConnectionOptIn) ||
                other.mutualConnectionOptIn == mutualConnectionOptIn));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isActive, radiusKm, mutualConnectionOptIn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HelperStatusImplCopyWith<_$HelperStatusImpl> get copyWith =>
      __$$HelperStatusImplCopyWithImpl<_$HelperStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HelperStatusImplToJson(
      this,
    );
  }
}

abstract class _HelperStatus implements HelperStatus {
  const factory _HelperStatus(
      {final bool isActive,
      final double radiusKm,
      final bool mutualConnectionOptIn}) = _$HelperStatusImpl;

  factory _HelperStatus.fromJson(Map<String, dynamic> json) =
      _$HelperStatusImpl.fromJson;

  @override
  bool get isActive;
  @override
  double get radiusKm;
  @override
  bool get mutualConnectionOptIn;
  @override
  @JsonKey(ignore: true)
  _$$HelperStatusImplCopyWith<_$HelperStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
