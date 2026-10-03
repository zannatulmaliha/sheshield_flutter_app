// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_mode_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AiModeState {
  AiModeSettings get settings => throw _privateConstructorUsedError;

  /// False until the saved toggles have been read, so the screen doesn't
  /// flash the defaults first.
  bool get isLoaded => throw _privateConstructorUsedError;

  /// Seconds left to answer the "Are you safe?" prompt, or null when no
  /// prompt is showing.
  int? get autoCheckInSecondsLeft => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AiModeStateCopyWith<AiModeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiModeStateCopyWith<$Res> {
  factory $AiModeStateCopyWith(
          AiModeState value, $Res Function(AiModeState) then) =
      _$AiModeStateCopyWithImpl<$Res, AiModeState>;
  @useResult
  $Res call(
      {AiModeSettings settings, bool isLoaded, int? autoCheckInSecondsLeft});

  $AiModeSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$AiModeStateCopyWithImpl<$Res, $Val extends AiModeState>
    implements $AiModeStateCopyWith<$Res> {
  _$AiModeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
    Object? isLoaded = null,
    Object? autoCheckInSecondsLeft = freezed,
  }) {
    return _then(_value.copyWith(
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AiModeSettings,
      isLoaded: null == isLoaded
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      autoCheckInSecondsLeft: freezed == autoCheckInSecondsLeft
          ? _value.autoCheckInSecondsLeft
          : autoCheckInSecondsLeft // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AiModeSettingsCopyWith<$Res> get settings {
    return $AiModeSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AiModeStateImplCopyWith<$Res>
    implements $AiModeStateCopyWith<$Res> {
  factory _$$AiModeStateImplCopyWith(
          _$AiModeStateImpl value, $Res Function(_$AiModeStateImpl) then) =
      __$$AiModeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AiModeSettings settings, bool isLoaded, int? autoCheckInSecondsLeft});

  @override
  $AiModeSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$AiModeStateImplCopyWithImpl<$Res>
    extends _$AiModeStateCopyWithImpl<$Res, _$AiModeStateImpl>
    implements _$$AiModeStateImplCopyWith<$Res> {
  __$$AiModeStateImplCopyWithImpl(
      _$AiModeStateImpl _value, $Res Function(_$AiModeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
    Object? isLoaded = null,
    Object? autoCheckInSecondsLeft = freezed,
  }) {
    return _then(_$AiModeStateImpl(
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AiModeSettings,
      isLoaded: null == isLoaded
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
      autoCheckInSecondsLeft: freezed == autoCheckInSecondsLeft
          ? _value.autoCheckInSecondsLeft
          : autoCheckInSecondsLeft // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$AiModeStateImpl implements _AiModeState {
  const _$AiModeStateImpl(
      {this.settings = const AiModeSettings(),
      this.isLoaded = false,
      this.autoCheckInSecondsLeft});

  @override
  @JsonKey()
  final AiModeSettings settings;

  /// False until the saved toggles have been read, so the screen doesn't
  /// flash the defaults first.
  @override
  @JsonKey()
  final bool isLoaded;

  /// Seconds left to answer the "Are you safe?" prompt, or null when no
  /// prompt is showing.
  @override
  final int? autoCheckInSecondsLeft;

  @override
  String toString() {
    return 'AiModeState(settings: $settings, isLoaded: $isLoaded, autoCheckInSecondsLeft: $autoCheckInSecondsLeft)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiModeStateImpl &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.isLoaded, isLoaded) ||
                other.isLoaded == isLoaded) &&
            (identical(other.autoCheckInSecondsLeft, autoCheckInSecondsLeft) ||
                other.autoCheckInSecondsLeft == autoCheckInSecondsLeft));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, settings, isLoaded, autoCheckInSecondsLeft);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AiModeStateImplCopyWith<_$AiModeStateImpl> get copyWith =>
      __$$AiModeStateImplCopyWithImpl<_$AiModeStateImpl>(this, _$identity);
}

abstract class _AiModeState implements AiModeState {
  const factory _AiModeState(
      {final AiModeSettings settings,
      final bool isLoaded,
      final int? autoCheckInSecondsLeft}) = _$AiModeStateImpl;

  @override
  AiModeSettings get settings;
  @override

  /// False until the saved toggles have been read, so the screen doesn't
  /// flash the defaults first.
  bool get isLoaded;
  @override

  /// Seconds left to answer the "Are you safe?" prompt, or null when no
  /// prompt is showing.
  int? get autoCheckInSecondsLeft;
  @override
  @JsonKey(ignore: true)
  _$$AiModeStateImplCopyWith<_$AiModeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
