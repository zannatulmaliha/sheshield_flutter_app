/// Mirrors the Go backend's duress.Type enum (internal/duress/duress.go).
/// [hardwarePattern] and [missedCheckin] and [manualPanic] are real,
/// callable triggers; [safewordVoice] is accepted by the backend but has no
/// on-device detection behind it yet -- a standalone ML feature, not wired
/// up here.
enum DuressType {
  hardwarePattern('hardware_pattern'),
  safewordVoice('safeword_voice'),
  missedCheckin('missed_checkin'),
  manualPanic('manual_panic');

  const DuressType(this.key);
  final String key;
}
