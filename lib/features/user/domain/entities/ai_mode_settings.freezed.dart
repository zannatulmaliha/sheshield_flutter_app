// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_mode_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AiModeSettings {
  bool get voiceEnabled => throw _privateConstructorUsedError;
  bool get fakeCallEnabled => throw _privateConstructorUsedError;
  bool get routeRiskEnabled => throw _privateConstructorUsedError;
  bool get autoCheckInEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AiModeSettingsCopyWith<AiModeSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiModeSettingsCopyWith<$Res> {
  factory $AiModeSettingsCopyWith(
          AiModeSettings value, $Res Function(AiModeSettings) then) =
      _$AiModeSettingsCopyWithImpl<$Res, AiModeSettings>;
  @useResult
  $Res call(
      {bool voiceEnabled,
      bool fakeCallEnabled,
      bool routeRiskEnabled,
      bool autoCheckInEnabled});
}

/// @nodoc
class _$AiModeSettingsCopyWithImpl<$Res, $Val extends AiModeSettings>
    implements $AiModeSettingsCopyWith<$Res> {
  _$AiModeSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voiceEnabled = null,
    Object? fakeCallEnabled = null,
    Object? routeRiskEnabled = null,
    Object? autoCheckInEnabled = null,
  }) {
    return _then(_value.copyWith(
      voiceEnabled: null == voiceEnabled
          ? _value.voiceEnabled
          : voiceEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      fakeCallEnabled: null == fakeCallEnabled
          ? _value.fakeCallEnabled
          : fakeCallEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      routeRiskEnabled: null == routeRiskEnabled
          ? _value.routeRiskEnabled
          : routeRiskEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoCheckInEnabled: null == autoCheckInEnabled
          ? _value.autoCheckInEnabled
          : autoCheckInEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiModeSettingsImplCopyWith<$Res>
    implements $AiModeSettingsCopyWith<$Res> {
  factory _$$AiModeSettingsImplCopyWith(_$AiModeSettingsImpl value,
          $Res Function(_$AiModeSettingsImpl) then) =
      __$$AiModeSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool voiceEnabled,
      bool fakeCallEnabled,
      bool routeRiskEnabled,
      bool autoCheckInEnabled});
}

/// @nodoc
class __$$AiModeSettingsImplCopyWithImpl<$Res>
    extends _$AiModeSettingsCopyWithImpl<$Res, _$AiModeSettingsImpl>
    implements _$$AiModeSettingsImplCopyWith<$Res> {
  __$$AiModeSettingsImplCopyWithImpl(
      _$AiModeSettingsImpl _value, $Res Function(_$AiModeSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voiceEnabled = null,
    Object? fakeCallEnabled = null,
    Object? routeRiskEnabled = null,
    Object? autoCheckInEnabled = null,
  }) {
    return _then(_$AiModeSettingsImpl(
      voiceEnabled: null == voiceEnabled
          ? _value.voiceEnabled
          : voiceEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      fakeCallEnabled: null == fakeCallEnabled
          ? _value.fakeCallEnabled
          : fakeCallEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      routeRiskEnabled: null == routeRiskEnabled
          ? _value.routeRiskEnabled
          : routeRiskEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoCheckInEnabled: null == autoCheckInEnabled
          ? _value.autoCheckInEnabled
          : autoCheckInEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AiModeSettingsImpl extends _AiModeSettings {
  const _$AiModeSettingsImpl(
      {this.voiceEnabled = true,
      this.fakeCallEnabled = true,
      this.routeRiskEnabled = false,
      this.autoCheckInEnabled = true})
      : super._();

  @override
  @JsonKey()
  final bool voiceEnabled;
  @override
  @JsonKey()
  final bool fakeCallEnabled;
  @override
  @JsonKey()
  final bool routeRiskEnabled;
  @override
  @JsonKey()
  final bool autoCheckInEnabled;

  @override
  String toString() {
    return 'AiModeSettings(voiceEnabled: $voiceEnabled, fakeCallEnabled: $fakeCallEnabled, routeRiskEnabled: $routeRiskEnabled, autoCheckInEnabled: $autoCheckInEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiModeSettingsImpl &&
            (identical(other.voiceEnabled, voiceEnabled) ||
                other.voiceEnabled == voiceEnabled) &&
            (identical(other.fakeCallEnabled, fakeCallEnabled) ||
                other.fakeCallEnabled == fakeCallEnabled) &&
            (identical(other.routeRiskEnabled, routeRiskEnabled) ||
                other.routeRiskEnabled == routeRiskEnabled) &&
            (identical(other.autoCheckInEnabled, autoCheckInEnabled) ||
                other.autoCheckInEnabled == autoCheckInEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, voiceEnabled, fakeCallEnabled,
      routeRiskEnabled, autoCheckInEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AiModeSettingsImplCopyWith<_$AiModeSettingsImpl> get copyWith =>
      __$$AiModeSettingsImplCopyWithImpl<_$AiModeSettingsImpl>(
          this, _$identity);
}

abstract class _AiModeSettings extends AiModeSettings {
  const factory _AiModeSettings(
      {final bool voiceEnabled,
      final bool fakeCallEnabled,
      final bool routeRiskEnabled,
      final bool autoCheckInEnabled}) = _$AiModeSettingsImpl;
  const _AiModeSettings._() : super._();

  @override
  bool get voiceEnabled;
  @override
  bool get fakeCallEnabled;
  @override
  bool get routeRiskEnabled;
  @override
  bool get autoCheckInEnabled;
  @override
  @JsonKey(ignore: true)
  _$$AiModeSettingsImplCopyWith<_$AiModeSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
