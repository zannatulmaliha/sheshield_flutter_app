/// Tunable thresholds for [MotionDetector]. Values are in g (multiples of
/// 9.80665 m/s^2) unless noted. Defaults were tuned against synthetic
/// walk/jog/sprint/fall/struggle traces (see test/motion) and are a
/// STARTING POINT: real-device data collection is still needed (README).
class MotionConfig {
  const MotionConfig({
    this.impactG = 2.6,
    this.freeFallG = 0.6,
    this.minFallScore = 0.6,
    this.sprintRms = 6.0,
    this.sprintCadenceHz = 3.0,
    this.struggleGyroRms = 3.5,
    this.struggleAccRms = 5.0,
    this.inactivityMs = 25000,
    this.shakePeak = 22.0,
    this.shakeCount = 6,
  });

  /// Acceleration magnitude that counts as an impact.
  final double impactG;

  /// Magnitude below which the phone is considered in free fall.
  final double freeFallG;

  /// Minimum fall score (0..1) that is reported.
  final double minFallScore;

  /// Vertical dynamic-acceleration RMS (m/s^2) needed for "sprint".
  final double sprintRms;

  /// Step cadence (steps/s) needed for "sprint".
  final double sprintCadenceHz;

  /// Gyro RMS (rad/s) and dynamic-accel RMS (m/s^2) for "struggle".
  final double struggleGyroRms;
  final double struggleAccRms;

  /// Violent-shake detector: |a| - g (m/s^2) a peak must exceed, and how many
  /// such peaks within 2s count as a shake/struggle.
  final double shakePeak;
  final int shakeCount;

  /// Stillness after a fall before "inactivity" is reported.
  final int inactivityMs;

  /// Sensitivity presets exposed in the UI. Higher sensitivity = lower
  /// thresholds = more prompts (every detection is confirmed with the
  /// person first, so a false positive costs a tap, not a false SOS).
  static const MotionConfig low = MotionConfig(
    impactG: 3.2,
    minFallScore: 0.75,
    sprintRms: 7.5,
    struggleGyroRms: 4.5,
    struggleAccRms: 6.5,
    shakePeak: 30.0,
    shakeCount: 8,
  );
  static const MotionConfig normal = MotionConfig();
  static const MotionConfig high = MotionConfig(
    impactG: 2.2,
    minFallScore: 0.5,
    sprintRms: 5.0,
    sprintCadenceHz: 2.8,
    struggleGyroRms: 3.0,
    struggleAccRms: 4.0,
    shakePeak: 16.0,
    shakeCount: 5,
  );
}