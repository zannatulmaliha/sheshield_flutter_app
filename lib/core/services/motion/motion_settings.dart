import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'motion_config.dart';

enum MotionSensitivity {
  low,
  normal,
  high;

  MotionConfig get config => switch (this) {
        low => MotionConfig.low,
        normal => MotionConfig.normal,
        high => MotionConfig.high,
      };

  String get label => switch (this) {
        low => 'Low',
        normal => 'Normal',
        high => 'High',
      };
}

/// Everything here is OPT-IN and reversible (spec core principle): movement
/// detection is off until the person turns it on.
class MotionSettings {
  const MotionSettings({
    this.enabled = false,
    this.sensitivity = MotionSensitivity.normal,
    this.fallAutoSos = true,
    this.struggleAutoSos = true,
    this.sprintAutoSos = false,
  });

  final bool enabled;
  final MotionSensitivity sensitivity;

  /// If the person doesn't answer "Are you OK?" in time, send the SOS.
  final bool fallAutoSos;
  final bool struggleAutoSos;

  /// A sprint on its own is ambiguous (runner vs. being chased), so a missed
  /// prompt does NOT send an SOS unless the person opts in.
  final bool sprintAutoSos;

  MotionSettings copyWith({
    bool? enabled,
    MotionSensitivity? sensitivity,
    bool? fallAutoSos,
    bool? struggleAutoSos,
    bool? sprintAutoSos,
  }) =>
      MotionSettings(
        enabled: enabled ?? this.enabled,
        sensitivity: sensitivity ?? this.sensitivity,
        fallAutoSos: fallAutoSos ?? this.fallAutoSos,
        struggleAutoSos: struggleAutoSos ?? this.struggleAutoSos,
        sprintAutoSos: sprintAutoSos ?? this.sprintAutoSos,
      );
}

class MotionSettingsStore {
  MotionSettingsStore(this._storage);
  final FlutterSecureStorage _storage;

  static const _k = 'motion_guard.';

  Future<MotionSettings> loadMotionSettings() async {
    Future<bool> b(String key, bool def) async {
      final v = await _storage.read(key: '$_k$key');
      return v == null ? def : v == '1';
    }

    final s = await _storage.read(key: '${_k}sensitivity');
    return MotionSettings(
      enabled: await b('enabled', false),
      sensitivity: MotionSensitivity.values.firstWhere((e) => e.name == s, orElse: () => MotionSensitivity.normal),
      fallAutoSos: await b('fallAutoSos', true),
      struggleAutoSos: await b('struggleAutoSos', true),
      sprintAutoSos: await b('sprintAutoSos', false),
    );
  }

  Future<void> saveMotionSettings(MotionSettings s) async {
    await _storage.write(key: '${_k}enabled', value: s.enabled ? '1' : '0');
    await _storage.write(key: '${_k}sensitivity', value: s.sensitivity.name);
    await _storage.write(key: '${_k}fallAutoSos', value: s.fallAutoSos ? '1' : '0');
    await _storage.write(key: '${_k}struggleAutoSos', value: s.struggleAutoSos ? '1' : '0');
    await _storage.write(key: '${_k}sprintAutoSos', value: s.sprintAutoSos ? '1' : '0');
  }
}
