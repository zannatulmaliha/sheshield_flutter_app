import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Phrase-based distress listener -- NOT scream/audio-amplitude detection.
/// speech_to_text only ever exposes recognized *words*, never raw
/// microphone amplitude, so true "detects screaming" is out of scope;
/// this watches for a small fixed list of spoken trigger phrases instead
/// (see AiModeScreen's description of this feature for the honest
/// framing shown to the user).
///
/// The underlying platform recognizer only supports finite listening
/// windows -- it always stops itself after [_kListenWindow] or
/// [_kPauseWindow] of silence -- so "continuous" listening is emulated
/// with a listen -> onStatus("done") -> relisten loop rather than one
/// long call.
///
/// Surviving a locked/off screen needs the Android process itself kept
/// alive -- Android freezes a normal app within seconds of the screen
/// turning off. [_foregroundService] starts a native foreground service
/// (VoiceDistressForegroundService.kt: persistent notification + wake
/// lock, both mandatory for a background mic listener by OS design) that
/// does nothing but hold this same process open so the listen loop below
/// keeps running -- there's no separate background isolate.
///
/// Deliberately riverpod/DI-agnostic, like every other core/ service: the
/// caller passes the actual SOS action in as [start]'s callback instead
/// of this class reaching into a provider itself.
class VoiceDistressService {
  final SpeechToText _speech = SpeechToText();
  static const _foregroundService =
      MethodChannel('com.example.sheshield/voice_distress_service');

  static const _kListenWindow = Duration(seconds: 30);
  static const _kPauseWindow = Duration(seconds: 6);

  /// Minimum gap between two automatic triggers, so one sustained
  /// "help me, help me" doesn't fire a second SOS while the first is
  /// still being handled.
  static const _kCooldown = Duration(seconds: 60);

  static const _triggerPhrases = [
    'help me',
    'call the police',
    'i need help',
  ];

  bool _listening = false;
  Future<void> Function()? _onTriggered;
  DateTime? _lastTriggeredAt;

  bool get isListening => _listening;

  /// Requests mic permission, initializes the recognizer if needed, starts
  /// the native foreground service that keeps this process alive with the
  /// screen off, and starts the listen loop. Returns false (doing nothing
  /// further) if permission is denied or no speech recognizer is available
  /// on this device.
  ///
  /// Also asks to be exempted from battery optimization -- without it,
  /// stock Android (and especially OEM battery managers like MIUI/OneUI)
  /// can still freeze this process despite the foreground service, since
  /// that exemption is what actually stops Doze/App Standby from throttling
  /// a background app's CPU and network. Best-effort: declining it doesn't
  /// block the feature, it just makes background survival less reliable,
  /// which is the most Android allows without it.
  Future<bool> start(Future<void> Function() onTriggered) async {
    if (_listening) return true;

    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) return false;

    final available = await _speech.initialize(onStatus: _handleStatus);
    if (!available) return false;

    if (!await Permission.ignoreBatteryOptimizations.isGranted) {
      await Permission.ignoreBatteryOptimizations.request();
    }
    await _foregroundService.invokeMethod('start');

    _onTriggered = onTriggered;
    _listening = true;
    _listenOnce();
    return true;
  }

  Future<void> stop() async {
    _listening = false;
    _onTriggered = null;
    await _speech.stop();
    await _foregroundService.invokeMethod('stop');
  }

  void _listenOnce() {
    if (!_listening) return;
    _speech.listen(
      onResult: _handleResult,
      listenOptions: SpeechListenOptions(
        partialResults: true,
        listenMode: ListenMode.dictation,
        listenFor: _kListenWindow,
        pauseFor: _kPauseWindow,
      ),
    );
  }

  void _handleStatus(String status) {
    // "done"/"notListening" fire whenever a window ends -- silence,
    // the listenFor timeout, or a delivered final result -- so relisten
    // immediately to cover the next window too.
    if (!_listening) return;
    if (status == 'done' || status == 'notListening') {
      _listenOnce();
    }
  }

  void _handleResult(SpeechRecognitionResult result) {
    final words = result.recognizedWords.toLowerCase();
    final matched = _triggerPhrases.any(words.contains);
    if (!matched) return;

    final now = DateTime.now();
    if (_lastTriggeredAt != null &&
        now.difference(_lastTriggeredAt!) < _kCooldown) {
      return;
    }
    _lastTriggeredAt = now;
    _onTriggered?.call();
  }
}
