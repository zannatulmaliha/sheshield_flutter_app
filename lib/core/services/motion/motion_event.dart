/// What the on-device detectors can report. Only these derived events ever
/// leave the phone -- never raw accelerometer/gyroscope samples.
enum MotionEventType {
  /// Free-fall/impact followed by stillness (and usually a change in how the
  /// phone is oriented).
  fall,

  /// Abrupt change from resting/walking to a sustained sprint.
  sprint,

  /// Violent, irregular, high-energy motion (not a rhythmic gait).
  struggle,

  /// No movement at all for a while after a detected fall.
  inactivity;

  /// Wire value understood by POST /motion/events.
  String get wire => name;

  String get title => switch (this) {
        fall => 'Possible fall detected',
        sprint => 'Sudden sprint detected',
        struggle => 'Struggle detected',
        inactivity => 'No movement after a fall',
      };

  /// The `trigger` value sent with POST /alerts if this event ends up
  /// starting an SOS (see backend internal/trigger).
  String get sosTrigger => switch (this) {
        fall => 'motion_fall',
        sprint => 'motion_sprint',
        struggle => 'motion_struggle',
        inactivity => 'motion_inactive',
      };
}

class MotionEvent {
  const MotionEvent({
    required this.type,
    required this.confidence,
    required this.timestampMs,
  });

  final MotionEventType type;

  /// 0..1. Heuristic score, not a calibrated probability.
  final double confidence;

  /// Sensor clock (ms) of the sample that completed the detection.
  final int timestampMs;

  @override
  String toString() => 'MotionEvent($type, ${confidence.toStringAsFixed(2)}, ${timestampMs}ms)';
}
