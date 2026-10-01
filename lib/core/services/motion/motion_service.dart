import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'motion_config.dart';
import 'motion_detector.dart';
import 'motion_event.dart';

/// Glue between the platform sensors and the pure [MotionDetector].
///
///  * Samples at ~50 Hz (20 ms): enough for gait (<=5 Hz) and impacts, cheap
///    on battery. Higher rates need HIGH_SAMPLING_RATE_SENSORS and aren't
///    worth it here.
///  * Uses the RAW accelerometer (gravity included): fall detection needs the
///    gravity direction to see the orientation change.
///  * Gyro is sampled at the same rate; the latest gyro reading is paired
///    with each accelerometer sample (they are not hardware-synchronised).
///  * On Android a foreground service (MotionForegroundService.kt) keeps the
///    process alive when the screen is off.
///  * Nothing raw leaves this class: listeners get only [MotionEvent]s.
class MotionService {
  static const _channel = MethodChannel('com.example.sheshield/motion_service');
  static const _period = Duration(milliseconds: 20);

  MotionDetector _detector = MotionDetector();
  StreamSubscription<AccelerometerEvent>? _accSub;
  StreamSubscription<GyroscopeEvent>? _gyroSub;
  double _gx = 0, _gy = 0, _gz = 0;
  final Stopwatch _clock = Stopwatch();
  void Function(MotionEvent)? _onEvent;

  bool get isRunning => _accSub != null;

  Future<void> start(void Function(MotionEvent) onEvent, {MotionConfig config = const MotionConfig()}) async {
    await stop();
    _onEvent = onEvent;
    _detector = MotionDetector(config: config);
    _clock
      ..reset()
      ..start();

    try {
      await _channel.invokeMethod<void>('start');
    } on MissingPluginException {
      // iOS / tests: no native service, sensors still work in the foreground.
    } on PlatformException {
      // Best effort: detection still works while the app is in the foreground.
    }

    _gyroSub = gyroscopeEventStream(samplingPeriod: _period).listen(
      (e) {
        _gx = e.x;
        _gy = e.y;
        _gz = e.z;
      },
      onError: (_) {},
      cancelOnError: false,
    );
    _accSub = accelerometerEventStream(samplingPeriod: _period).listen(
      (e) {
        final events = _detector.process(_clock.elapsedMilliseconds, e.x, e.y, e.z, _gx, _gy, _gz);
        for (final ev in events) {
          _onEvent?.call(ev);
        }
      },
      onError: (_) {},
      cancelOnError: false,
    );
  }

  Future<void> stop() async {
    await _accSub?.cancel();
    await _gyroSub?.cancel();
    _accSub = null;
    _gyroSub = null;
    _clock.stop();
    _detector.reset();
    if (_onEvent != null) {
      _onEvent = null;
      try {
        await _channel.invokeMethod<void>('stop');
      } on MissingPluginException {
        // nothing to stop
      } on PlatformException {
        // nothing to stop
      }
    }
  }
}
