// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_mode_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiModeSettingsModelImpl _$$AiModeSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AiModeSettingsModelImpl(
      voiceEnabled: json['voiceEnabled'] as bool? ?? true,
      fakeCallEnabled: json['fakeCallEnabled'] as bool? ?? true,
      routeRiskEnabled: json['routeRiskEnabled'] as bool? ?? false,
      autoCheckInEnabled: json['autoCheckInEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$AiModeSettingsModelImplToJson(
        _$AiModeSettingsModelImpl instance) =>
    <String, dynamic>{
      'voiceEnabled': instance.voiceEnabled,
      'fakeCallEnabled': instance.fakeCallEnabled,
      'routeRiskEnabled': instance.routeRiskEnabled,
      'autoCheckInEnabled': instance.autoCheckInEnabled,
    };
