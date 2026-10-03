import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/services/voice_distress_service.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';
import 'package:sheshield/features/user/domain/entities/ai_mode_settings.dart';
import 'package:sheshield/features/user/domain/usecases/get_ai_mode_settings_usecase.dart';
import 'package:sheshield/features/user/domain/usecases/save_ai_mode_settings_usecase.dart';
import 'package:sheshield/features/user/presentation/providers/ai_mode_state.dart';
import 'package:sheshield/features/user/presentation/providers/user_use_case_providers.dart';

part 'ai_mode_provider.g.dart';

const _autoCheckInInterval = Duration(minutes: 30);
const _autoCheckInAnswerSeconds = 60;

/// Owns the AI Guardian toggles and the behaviour behind them: the voice
/// distress listener and the periodic "Are you safe?" prompt. Both run only
/// while the app process is alive (foreground-only), exactly as before.
@riverpod
class AiModeController extends _$AiModeController {
  late final GetAiModeSettingsUseCase _getSettings =
      ref.read(getAiModeSettingsUseCaseProvider);
  late final SaveAiModeSettingsUseCase _saveSettings =
      ref.read(saveAiModeSettingsUseCaseProvider);
  late final VoiceDistressService _voiceService =
      ref.read(voiceDistressServiceProvider);

  Timer? _checkInTimer;
  Timer? _promptTicker;
  bool _isDisposed = false;

  @override
  AiModeState build() {
    _isDisposed = false;
    ref.onDispose(() {
      _isDisposed = true;
      _checkInTimer?.cancel();
      _promptTicker?.cancel();
    });
    Future.microtask(_loadSettings);
    return const AiModeState();
  }

  Future<void> _loadSettings() async {
    final settings = await _getSettings();
    if (_isDisposed) return;
    state = state.copyWith(settings: settings, isLoaded: true);

    if (settings.voiceEnabled) {
      final didStart = await _voiceService.start(_sendVoiceTriggeredSos);
      if (!didStart && !_isDisposed) {
        await _persist(settings.copyWith(voiceEnabled: false));
      }
    }
    if (settings.autoCheckInEnabled) _startAutoCheckIn();
  }

  Future<void> _sendVoiceTriggeredSos() =>
      ref.read(sosControllerProvider.notifier).send();

  Future<void> _persist(AiModeSettings settings) async {
    state = state.copyWith(settings: settings);
    await _saveSettings(settings);
  }

  /// Returns a message to show when it can't be turned on, else null.
  Future<String?> setVoiceEnabled(bool isEnabled) async {
    if (isEnabled) {
      final didStart = await _voiceService.start(_sendVoiceTriggeredSos);
      if (!didStart) {
        return 'Microphone permission is needed for Voice Distress Detection.';
      }
    } else {
      await _voiceService.stop();
    }
    await _persist(state.settings.copyWith(voiceEnabled: isEnabled));
    return null;
  }

  Future<void> setFakeCallEnabled(bool isEnabled) =>
      _persist(state.settings.copyWith(fakeCallEnabled: isEnabled));

  Future<void> setRouteRiskEnabled(bool isEnabled) =>
      _persist(state.settings.copyWith(routeRiskEnabled: isEnabled));

  Future<void> setAutoCheckInEnabled(bool isEnabled) async {
    await _persist(state.settings.copyWith(autoCheckInEnabled: isEnabled));
    if (isEnabled) {
      _startAutoCheckIn();
    } else {
      _stopAutoCheckIn();
    }
  }

  void _startAutoCheckIn() {
    _checkInTimer?.cancel();
    _checkInTimer = Timer.periodic(_autoCheckInInterval, (_) => _promptAutoCheckIn());
  }

  void _stopAutoCheckIn() {
    _checkInTimer?.cancel();
    _promptTicker?.cancel();
    state = state.copyWith(autoCheckInSecondsLeft: null);
  }

  void _promptAutoCheckIn() {
    if (state.autoCheckInSecondsLeft != null) return;
    state = state.copyWith(autoCheckInSecondsLeft: _autoCheckInAnswerSeconds);
    _promptTicker = Timer.periodic(const Duration(seconds: 1), (ticker) {
      final secondsLeft = (state.autoCheckInSecondsLeft ?? 1) - 1;
      if (secondsLeft > 0) {
        state = state.copyWith(autoCheckInSecondsLeft: secondsLeft);
        return;
      }
      ticker.cancel();
      state = state.copyWith(autoCheckInSecondsLeft: null);
      // No answer: send the SOS on the person's behalf.
      ref.read(sosControllerProvider.notifier).send();
    });
  }

  /// "Yes, I'm safe": dismisses the prompt without sending anything.
  void confirmSafe() {
    _promptTicker?.cancel();
    state = state.copyWith(autoCheckInSecondsLeft: null);
  }
}
