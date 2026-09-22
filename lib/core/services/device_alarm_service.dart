import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

/// Thin wrapper so nothing above core/ imports just_audio/audio_session
/// directly. Loops the bundled siren at full volume through the device's
/// *alarm* audio stream (not media/ringer) -- the same stream a clock
/// alarm uses, which is why it still sounds even if the phone is on
/// silent or in Do Not Disturb (both only mute the ringer/notification
/// streams, not alarms).
class DeviceAlarmService {
  final AudioPlayer _player = AudioPlayer();
  bool _configured = false;

  Future<void> _ensureConfigured() async {
    if (_configured) return;
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      androidAudioAttributes: AndroidAudioAttributes(
        usage: AndroidAudioUsage.alarm,
        contentType: AndroidAudioContentType.sonification,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
    ));
    await _player.setAsset('assets/sounds/sos_alarm.wav');
    await _player.setLoopMode(LoopMode.all);
    await _player.setVolume(1.0);
    _configured = true;
  }

  Future<void> start() async {
    await _ensureConfigured();
    await _player.seek(Duration.zero);
    await _player.play();
  }

  Future<void> stop() async {
    if (!_configured) return;
    await _player.stop();
  }

  Future<void> dispose() => _player.dispose();
}
