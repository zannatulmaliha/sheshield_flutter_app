import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/user/domain/entities/ai_mode_settings.dart';

part 'ai_mode_state.freezed.dart';

@freezed
class AiModeState with _$AiModeState {
  const factory AiModeState({
    @Default(AiModeSettings()) AiModeSettings settings,

    /// False until the saved toggles have been read, so the screen doesn't
    /// flash the defaults first.
    @Default(false) bool isLoaded,

    /// Seconds left to answer the "Are you safe?" prompt, or null when no
    /// prompt is showing.
    int? autoCheckInSecondsLeft,
  }) = _AiModeState;
}
