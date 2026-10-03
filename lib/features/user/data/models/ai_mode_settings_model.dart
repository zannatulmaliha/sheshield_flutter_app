import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/user/domain/entities/ai_mode_settings.dart';

part 'ai_mode_settings_model.freezed.dart';
part 'ai_mode_settings_model.g.dart';

/// Local-storage shape of [AiModeSettings]. There is no server
/// representation -- this only exists so the toggles are persisted as one
/// JSON blob (via [AiModeSettingsRepositoryImpl]) instead of one flag per
/// field.
@freezed
class AiModeSettingsModel with _$AiModeSettingsModel {
  const AiModeSettingsModel._();

  const factory AiModeSettingsModel({
    @Default(true) bool voiceEnabled,
    @Default(true) bool fakeCallEnabled,
    @Default(false) bool routeRiskEnabled,
    @Default(true) bool autoCheckInEnabled,
  }) = _AiModeSettingsModel;

  factory AiModeSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$AiModeSettingsModelFromJson(json);

  factory AiModeSettingsModel.fromEntity(AiModeSettings settings) =>
      AiModeSettingsModel(
        voiceEnabled: settings.voiceEnabled,
        fakeCallEnabled: settings.fakeCallEnabled,
        routeRiskEnabled: settings.routeRiskEnabled,
        autoCheckInEnabled: settings.autoCheckInEnabled,
      );

  AiModeSettings toEntity() => AiModeSettings(
        voiceEnabled: voiceEnabled,
        fakeCallEnabled: fakeCallEnabled,
        routeRiskEnabled: routeRiskEnabled,
        autoCheckInEnabled: autoCheckInEnabled,
      );
}
