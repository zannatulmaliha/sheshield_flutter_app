import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_mode_settings.freezed.dart';

/// Which AI Guardian features the person has switched on. Persisted on the
/// device as one JSON blob via `AiModeSettingsModel` -- there is no server
/// representation, but the JSON model keeps it consistent with every other
/// persisted entity.
@freezed
class AiModeSettings with _$AiModeSettings {
  const AiModeSettings._();

  const factory AiModeSettings({
    @Default(true) bool voiceEnabled,
    @Default(true) bool fakeCallEnabled,
    @Default(false) bool routeRiskEnabled,
    @Default(true) bool autoCheckInEnabled,
  }) = _AiModeSettings;

  static const featureCount = 4;

  int get enabledFeatureCount => [
        voiceEnabled,
        fakeCallEnabled,
        routeRiskEnabled,
        autoCheckInEnabled,
      ].where((isEnabled) => isEnabled).length;
}
