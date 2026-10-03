// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_mode_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AiModeSettingsModel _$AiModeSettingsModelFromJson(Map<String, dynamic> json) {
  return _AiModeSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$AiModeSettingsModel {
  bool get voiceEnabled => throw _privateConstructorUsedError;
  bool get fakeCallEnabled => throw _privateConstructorUsedError;
  bool get routeRiskEnabled => throw _privateConstructorUsedError;
  bool get autoCheckInEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AiModeSettingsModelCopyWith<AiModeSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiModeSettingsModelCopyWith<$Res> {
  factory $AiModeSettingsModelCopyWith(
          AiModeSettingsModel value, $Res Function(AiModeSettingsModel) then) =
      _$AiModeSettingsModelCopyWithImpl<$Res, AiModeSettingsModel>;
  @useResult
  $Res call(
      {bool voiceEnabled,
      bool fakeCallEnabled,
      bool routeRiskEnabled,
      bool autoCheckInEnabled});
}

/// @nodoc
class _$AiModeSettingsModelCopyWithImpl<$Res, $Val extends AiModeSettingsModel>
    implements $AiModeSettingsModelCopyWith<$Res> {
  _$AiModeSettingsModelCopyWithImpl(this._value, this._then);

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
abstract class _$$AiModeSettingsModelImplCopyWith<$Res>
    implements $AiModeSettingsModelCopyWith<$Res> {
  factory _$$AiModeSettingsModelImplCopyWith(_$AiModeSettingsModelImpl value,
          $Res Function(_$AiModeSettingsModelImpl) then) =
      __$$AiModeSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool voiceEnabled,
      bool fakeCallEnabled,
      bool routeRiskEnabled,
      bool autoCheckInEnabled});
}

/// @nodoc
class __$$AiModeSettingsModelImplCopyWithImpl<$Res>
    extends _$AiModeSettingsModelCopyWithImpl<$Res, _$AiModeSettingsModelImpl>
    implements _$$AiModeSettingsModelImplCopyWith<$Res> {
  __$$AiModeSettingsModelImplCopyWithImpl(_$AiModeSettingsModelImpl _value,
      $Res Function(_$AiModeSettingsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voiceEnabled = null,
    Object? fakeCallEnabled = null,
    Object? routeRiskEnabled = null,
    Object? autoCheckInEnabled = null,
  }) {
    return _then(_$AiModeSettingsModelImpl(
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
@JsonSerializable()
class _$AiModeSettingsModelImpl extends _AiModeSettingsModel {
  const _$AiModeSettingsModelImpl(
      {this.voiceEnabled = true,
      this.fakeCallEnabled = true,
      this.routeRiskEnabled = false,
      this.autoCheckInEnabled = true})
      : super._();

  factory _$AiModeSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiModeSettingsModelImplFromJson(json);

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
    return 'AiModeSettingsModel(voiceEnabled: $voiceEnabled, fakeCallEnabled: $fakeCallEnabled, routeRiskEnabled: $routeRiskEnabled, autoCheckInEnabled: $autoCheckInEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiModeSettingsModelImpl &&
            (identical(other.voiceEnabled, voiceEnabled) ||
                other.voiceEnabled == voiceEnabled) &&
            (identical(other.fakeCallEnabled, fakeCallEnabled) ||
                other.fakeCallEnabled == fakeCallEnabled) &&
            (identical(other.routeRiskEnabled, routeRiskEnabled) ||
                other.routeRiskEnabled == routeRiskEnabled) &&
            (identical(other.autoCheckInEnabled, autoCheckInEnabled) ||
                other.autoCheckInEnabled == autoCheckInEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, voiceEnabled, fakeCallEnabled,
      routeRiskEnabled, autoCheckInEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AiModeSettingsModelImplCopyWith<_$AiModeSettingsModelImpl> get copyWith =>
      __$$AiModeSettingsModelImplCopyWithImpl<_$AiModeSettingsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiModeSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _AiModeSettingsModel extends AiModeSettingsModel {
  const factory _AiModeSettingsModel(
      {final bool voiceEnabled,
      final bool fakeCallEnabled,
      final bool routeRiskEnabled,
      final bool autoCheckInEnabled}) = _$AiModeSettingsModelImpl;
  const _AiModeSettingsModel._() : super._();

  factory _AiModeSettingsModel.fromJson(Map<String, dynamic> json) =
      _$AiModeSettingsModelImpl.fromJson;

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
  _$$AiModeSettingsModelImplCopyWith<_$AiModeSettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
