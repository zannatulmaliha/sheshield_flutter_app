import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

/// Thin wrapper so nothing above core/ imports just_audio/audio_session
/// directly, mirroring [DeviceAlarmService]. Plays through the *ringer*
/// audio stream instead of the *alarm* stream a real SOS uses -- so the
/// Fake Call Generator sounds like an ordinary incoming call (and
/// respects silent mode/Do Not Disturb the way a real call would)
/// instead of forcing itself through like an alarm. Reuses the same
/// bundled sound file as [DeviceAlarmService] since no separate ringtone
/// asset ships with the app; only the audio stream/usage differs.
class RingtoneService {
  final AudioPlayer _player = AudioPlayer();
  bool _configured = false;

  Future<void> _ensureConfigured() async {
    if (_configured) return;
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      androidAudioAttributes: AndroidAudioAttributes(
        usage: AndroidAudioUsage.notificationRingtone,
        contentType: AndroidAudioContentType.sonification,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    ),);
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
