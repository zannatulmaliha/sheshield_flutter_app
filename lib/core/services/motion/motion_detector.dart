import 'dart:collection';
import 'dart:math' as math;

import 'motion_config.dart';
import 'motion_event.dart';

const double _g = 9.80665;

class _Sample {
  _Sample(this.t, this.magG, this.ax, this.ay, this.az, this.gyro);
  final int t;
  final double magG;
  final double ax, ay, az;
  final double gyro;
}

class _FallCandidate {
  _FallCandidate(this.t0, this.peak, this.hadFreeFall, this.pre);
  final int t0;
  double peak;
  final bool hadFreeFall;

  /// Gravity direction (unit-agnostic) averaged over the calm second before
  /// the fall; null if the phone wasn't calm long enough to know.
  final List<double>? pre;
}

/// Activity classes, smallest = calmest. [unknown] is erratic motion that
/// isn't a rhythmic gait; it counts as "walking-level" for sprint baselines.
enum _Activity { still, walking, running, sprinting, unknown }

int _rank(_Activity a) => switch (a) {
      _Activity.still => 0,
      _Activity.walking => 1,
      _Activity.running => 2,
      _Activity.sprinting => 3,
      _Activity.unknown => 1,
    };

/// Pure-Dart, sensor-agnostic movement detector. Feed it time-ordered
/// accelerometer (INCLUDING gravity, m/s^2) and gyroscope (rad/s) samples
/// via [process]; it returns the events completed by that sample.
///
/// Design notes (best practices this follows):
///  * Threshold + state-machine, not a black box: every decision is
///    explainable, which matters for a safety product.
///  * Falls use the classic phased model: free-fall -> impact -> post-impact
///    stillness -> orientation change, scored rather than hard-gated on any
///    one phase (phones in bags/pockets often miss the free-fall phase).
///  * Stillness is required for a fall, so sitting down hard, bumps, drops
///    that are picked back up, and cars going over potholes don't fire.
///  * Sprint = a CHANGE from a calm baseline to sustained, periodic, fast
///    gait (autocorrelation of the smoothed signal, step cadence and regular
///    step intervals). Someone already jogging for a long time is not
///    flagged; a sprinter and a chased person look identical to an
///    accelerometer, so this is only ever a prompt, never an automatic SOS.
///  * Struggle = high gyro + accel energy with NO rhythmic gait, sustained.
///  * Cooldowns after every event, and a veto so a struggle isn't
///    double-reported as a sprint.
///  * No I/O, no timers, no platform types -> deterministic and unit-testable.
class MotionDetector {
  MotionDetector({this.config = const MotionConfig()});

  final MotionConfig config;

  final Queue<_Sample> _buf = Queue<_Sample>();

  // ---- fall state ----
  int? _ffStart;
  int? _lastFfEnd;
  _FallCandidate? _cand;
  int _fallCooldownUntil = -1 << 40;
  int? _fallEmittedAt;
  bool _inactivityDone = true;
  int _lastMovingAt = -1 << 40;

  // ---- gait state ----
  int? _lastT;
  double? _sm;
  double? _smPrev1;
  double? _smPrev2;
  double _peakEma = 0;
  int _lastStepAt = -1 << 40;
  final List<List<double>> _steps = []; // [t, amplitude]
  final Queue<List<double>> _smWin = Queue<List<double>>(); // [t, value]
  final Queue<List<double>> _dynWin = Queue<List<double>>();
  final Queue<List<double>> _gyroWin = Queue<List<double>>();
  final Queue<List<double>> _jerkWin = Queue<List<double>>();
  double? _prevMag;
  int? _nextEval;

  _Activity _activity = _Activity.still;
  _Activity? _candLevel;
  int _candCount = 0;
  final List<List<num>> _hist = []; // [t, rank]

  int? _sprintStart;
  double _sprintRmsAtStart = 0;
  int _sprintCooldownUntil = -1 << 40;

  final List<int> _shakePeaks = [];
  int _lastShakePeakAt = -1 << 40;
  int _struggleHits = 0;
  int _struggleCooldownUntil = -1 << 40;
  int _struggleEmittedAt = -1 << 40;

  /// Forget everything (e.g. when the detector is re-enabled).
  void reset() {
    _buf.clear();
    _ffStart = null;
    _lastFfEnd = null;
    _cand = null;
    _fallCooldownUntil = -1 << 40;
    _fallEmittedAt = null;
    _inactivityDone = true;
    _lastMovingAt = -1 << 40;
    _lastT = null;
    _sm = _smPrev1 = _smPrev2 = null;
    _peakEma = 0;
    _lastStepAt = -1 << 40;
    _steps.clear();
    _smWin.clear();
    _dynWin.clear();
    _gyroWin.clear();
    _jerkWin.clear();
    _prevMag = null;
    _nextEval = null;
    _activity = _Activity.still;
    _candLevel = null;
    _candCount = 0;
    _hist.clear();
    _sprintStart = null;
    _sprintCooldownUntil = -1 << 40;
    _shakePeaks.clear();
    _lastShakePeakAt = -1 << 40;
    _struggleHits = 0;
    _struggleCooldownUntil = -1 << 40;
    _struggleEmittedAt = -1 << 40;
  }

  /// [tMs] must be monotonically increasing. [ax..az] in m/s^2 incl. gravity,
  /// [gx..gz] in rad/s.
  List<MotionEvent> process(
    int tMs,
    double ax,
    double ay,
    double az,
    double gx,
    double gy,
    double gz,
  ) {
    final mag = math.sqrt(ax * ax + ay * ay + az * az);
    final magG = mag / _g;
    final gyro = math.sqrt(gx * gx + gy * gy + gz * gz);

    _buf.addLast(_Sample(tMs, magG, ax, ay, az, gyro));
    while (_buf.isNotEmpty && tMs - _buf.first.t > 7000) {
      _buf.removeFirst();
    }

    final out = <MotionEvent>[];
    _fall(tMs, magG, gyro, out);
    _shake(tMs, mag, out);
    _gait(tMs, mag - _g, gyro, magG, out);
    if ((magG - 1).abs() > 0.25) _lastMovingAt = tMs;
    _inactivity(tMs, out);
    return out;
  }

  // ---------------------------------------------------------------- shake

  /// A hard shake is rhythmic and mostly translational (low gyro), so the
  /// struggle detector below (which needs irregular, high-gyro motion)
  /// never sees it. Count strong |a|-g peaks inside a 2s window instead.
  /// Reported as a struggle: it is confirmed with the person first.
  void _shake(int t, double mag, List<MotionEvent> out) {
    final dev = (mag - _g).abs();
    if (dev >= config.shakePeak && t - _lastShakePeakAt >= 70) {
      _lastShakePeakAt = t;
      _shakePeaks.add(t);
    }
    _shakePeaks.removeWhere((p) => t - p > 2000);
    if (_shakePeaks.length >= config.shakeCount && t >= _struggleCooldownUntil) {
      final over = (_shakePeaks.length - config.shakeCount) / 6;
      out.add(MotionEvent(
        type: MotionEventType.struggle,
        confidence: math.min(1.0, 0.7 + 0.3 * over.clamp(0.0, 1.0)),
        timestampMs: t,
      ),);
      _struggleCooldownUntil = t + 60000;
      _struggleEmittedAt = t;
      _shakePeaks.clear();
    }
  }

  // ---------------------------------------------------------------- falls

  void _fall(int t, double magG, double gyro, List<MotionEvent> out) {
    final c = config;
    final cand = _cand;

    if (cand == null) {
      if (magG < c.freeFallG) {
        _ffStart ??= t;
      } else if (_ffStart != null) {
        final d = t - _ffStart!;
        _ffStart = null;
        if (d >= 60) _lastFfEnd = t;
      }

      if (t >= _fallCooldownUntil && magG >= c.impactG) {
        final hasFf = _lastFfEnd != null && t - _lastFfEnd! <= 700;
        var gyroPeak = 0.0;
        for (final s in _buf) {
          if (t - s.t <= 500 && s.gyro > gyroPeak) gyroPeak = s.gyro;
        }
        // Without a free-fall phase (phone in a bag) demand a harder hit
        // AND a violent rotation, so a dropped-on-table phone doesn't fire.
        if (hasFf || (magG >= c.impactG + 0.8 && gyroPeak >= 2.0)) {
          _cand = _FallCandidate(t, magG, hasFf, _calmGravity(t));
        }
      }
      return;
    }

    if (t - cand.t0 <= 200 && magG > cand.peak) cand.peak = magG;
    if (t - cand.t0 < 3000) return;

    // Judge the 0.6s..3s window after impact.
    final vals = <double>[];
    for (final s in _buf) {
      if (s.t >= cand.t0 + 600 && s.t <= cand.t0 + 3000) vals.add(s.magG);
    }
    if (vals.isEmpty) {
      _cand = null;
      return;
    }
    final mean = vals.reduce((a, b) => a + b) / vals.length;
    var varSum = 0.0;
    for (final v in vals) {
      varSum += (v - mean) * (v - mean);
    }
    final std = math.sqrt(varSum / vals.length);
    final still = std <= 0.10 && (mean - 1).abs() <= 0.15;

    // Orientation change: gravity direction before vs after.
    final post = _meanAccel((s) => s.t >= cand.t0 + 1500 && s.t <= cand.t0 + 3000);
    var angle = 0.0;
    if (cand.pre != null && post != null) angle = _angleDeg(cand.pre!, post);

    var score = 0.30;
    if (cand.peak >= c.impactG + 1.0) score += 0.10;
    if (cand.hadFreeFall) score += 0.25;
    if (angle >= 45) {
      score += 0.20;
    } else if (angle >= 25) {
      score += 0.10;
    }
    if (still) score += 0.25;

    _fallCooldownUntil = t + 10000;
    if (still && score >= c.minFallScore) {
      out.add(MotionEvent(
        type: MotionEventType.fall,
        confidence: math.min(1.0, score),
        timestampMs: t,
      ),);
      _fallEmittedAt = t;
      _inactivityDone = false;
      _lastMovingAt = t;
    }
    _cand = null;
  }

  List<double>? _calmGravity(int t) {
    var n = 0;
    var sx = 0.0, sy = 0.0, sz = 0.0;
    for (final s in _buf) {
      if (s.t >= t - 2500 && s.t <= t - 700 && s.magG > 0.85 && s.magG < 1.15) {
        sx += s.ax;
        sy += s.ay;
        sz += s.az;
        n++;
      }
    }
    if (n < 10) return null;
    return [sx / n, sy / n, sz / n];
  }

  List<double>? _meanAccel(bool Function(_Sample) test) {
    var n = 0;
    var sx = 0.0, sy = 0.0, sz = 0.0;
    for (final s in _buf) {
      if (test(s)) {
        sx += s.ax;
        sy += s.ay;
        sz += s.az;
        n++;
      }
    }
    if (n == 0) return null;
    return [sx / n, sy / n, sz / n];
  }

  static double _angleDeg(List<double> a, List<double> b) {
    final na = math.sqrt(a[0] * a[0] + a[1] * a[1] + a[2] * a[2]);
    final nb = math.sqrt(b[0] * b[0] + b[1] * b[1] + b[2] * b[2]);
    if (na == 0 || nb == 0) return 0;
    final d = (a[0] * b[0] + a[1] * b[1] + a[2] * b[2]) / (na * nb);
    return math.acos(d.clamp(-1.0, 1.0)) * 180 / math.pi;
  }

  void _inactivity(int t, List<MotionEvent> out) {
    if (_inactivityDone || _fallEmittedAt == null) return;
    if (t - _lastMovingAt >= config.inactivityMs) {
      _inactivityDone = true;
      out.add(MotionEvent(type: MotionEventType.inactivity, confidence: 0.8, timestampMs: t));
    } else if (t - _fallEmittedAt! > 60000) {
      _inactivityDone = true;
    }
  }

  // ----------------------------------------------------------------- gait

  void _gait(int t, double dyn, double gyro, double magG, List<MotionEvent> out) {
    final dt = _lastT == null ? 20 : math.max(1, t - _lastT!);
    _lastT = t;

    // One-pole low-pass at ~6 Hz on the dynamic (gravity-removed) magnitude.
    const rc = 1 / (2 * math.pi * 6);
    final alpha = (dt / 1000) / ((dt / 1000) + rc);
    final prev = _sm;
    _sm = prev == null ? dyn : prev + alpha * (dyn - prev);
    final sm = _sm!;

    final p1 = _smPrev1;
    final p2 = _smPrev2;
    _smPrev2 = p1;
    _smPrev1 = sm;

    // Peak detection on the previous sample.
    if (p1 != null && p2 != null && p1 > p2 && p1 >= sm) {
      final thr = math.max(1.0, 0.5 * _peakEma);
      if (p1 > thr && t - _lastStepAt >= 220) {
        _steps.add([(t - dt).toDouble(), p1]);
        _lastStepAt = t;
        _peakEma = _peakEma == 0 ? p1 : _peakEma + 0.3 * (p1 - _peakEma);
      }
    }
    if (t - _lastStepAt > 2000) _peakEma = 0;
    _steps.removeWhere((s) => t - s[0] > 3000);

    _push(_smWin, t, sm);
    _push(_dynWin, t, dyn);
    _push(_gyroWin, t, gyro);
    _push(_jerkWin, t, (magG - (_prevMag ?? magG)).abs());
    _prevMag = magG;

    _nextEval ??= t + 500;
    if (t >= _nextEval!) {
      _nextEval = t + 500;
      _evaluate(t, out);
    }
  }

  static void _push(Queue<List<double>> q, int t, double v) {
    q.addLast([t.toDouble(), v]);
    while (q.isNotEmpty && t - q.first[0] > 3000) {
      q.removeFirst();
    }
  }

  void _evaluate(int t, List<MotionEvent> out) {
    final c = config;
    final n = _steps.length;

    var dynSq = 0.0;
    for (final d in _dynWin) {
      dynSq += d[1] * d[1];
    }
    final rms = math.sqrt(dynSq / math.max(1, _dynWin.length));

    var gSq = 0.0;
    for (final d in _gyroWin) {
      gSq += d[1] * d[1];
    }
    final gyroRms = math.sqrt(gSq / math.max(1, _gyroWin.length));

    var cadence = 0.0;
    var cv = 1.0;
    if (n >= 4) {
      final span = (_steps.last[0] - _steps.first[0]) / 1000;
      cadence = span > 0 ? (n - 1) / span : 0;
      final iv = <double>[];
      for (var i = 0; i < n - 1; i++) {
        iv.add(_steps[i + 1][0] - _steps[i][0]);
      }
      final m = iv.reduce((a, b) => a + b) / iv.length;
      var v = 0.0;
      for (final x in iv) {
        v += (x - m) * (x - m);
      }
      cv = m > 0 ? math.sqrt(v / iv.length) / m : 1.0;
    }

    final ac = _periodicity();
    final periodic = ac >= 0.5;

    _Activity level;
    if (rms < 0.5) {
      level = _Activity.still;
    } else if (ac >= 0.6 && n >= 4 && cv <= 0.35 && cadence >= c.sprintCadenceHz && rms >= c.sprintRms) {
      level = _Activity.sprinting;
    } else if (periodic && n >= 4 && cv <= 0.35 && cadence >= 2.3 && rms >= 3.0) {
      level = _Activity.running;
    } else if (periodic && n >= 3 && cv <= 0.5 && cadence >= 1.0) {
      level = _Activity.walking;
    } else {
      level = _Activity.unknown;
    }

    // Hysteresis: a level must hold for two consecutive evaluations.
    if (level == _candLevel) {
      _candCount++;
    } else {
      _candLevel = level;
      _candCount = 1;
    }
    final before = _activity;
    if (_candCount >= 2) _activity = level;
    _hist.add([t, _rank(_activity)]);
    _hist.removeWhere((h) => t - h[0] > 20000);

    // ---- sprint: calm baseline -> sustained sprint ----
    if (_activity == _Activity.sprinting && before != _Activity.sprinting && _sprintStart == null) {
      final haveHistory = _hist.isNotEmpty && _hist.first[0] <= t - 8000;
      var baselineMax = -1;
      for (final h in _hist) {
        if (h[0] >= t - 15000 && h[0] <= t - 2000) {
          baselineMax = math.max(baselineMax, h[1].toInt());
        }
      }
      if (haveHistory && baselineMax >= 0 && baselineMax <= 1 && t >= _sprintCooldownUntil && t - _struggleEmittedAt > 40000) {
        _sprintStart = t;
        _sprintRmsAtStart = rms;
      }
    }
    final ss = _sprintStart;
    if (ss != null) {
      if (t - ss >= 4000) {
        var total = 0, sprinting = 0;
        for (final h in _hist) {
          if (h[0] >= ss) {
            total++;
            if (h[1] == 3) sprinting++;
          }
        }
        final noRecentStruggle = _struggleHits == 0 && t - _struggleEmittedAt >= 20000;
        if (noRecentStruggle && total > 0 && sprinting >= 0.7 * total) {
          final conf = 0.75 + 0.25 * ((rms - c.sprintRms) / 6).clamp(0.0, 1.0);
          out.add(MotionEvent(type: MotionEventType.sprint, confidence: math.min(1.0, conf), timestampMs: t));
          _sprintCooldownUntil = t + 120000;
        }
        _sprintStart = null;
      } else if (_rank(_activity) < 2 && t - ss > 1500) {
        _sprintStart = null;
      }
    }
    // (kept for debugging/telemetry)
    // ignore: unused_local_variable
    final _ = _sprintRmsAtStart;

    // ---- struggle: violent, energetic, non-rhythmic ----
    final irregular = !periodic || n < 3 || cv > 0.45;
    final big = gyroRms >= c.struggleGyroRms && rms >= c.struggleAccRms && irregular;
    var jerks = 0;
    for (final j in _jerkWin) {
      if (j[1] > 1.0) jerks++;
    }
    if (big && jerks >= 3) {
      _struggleHits++;
    } else {
      _struggleHits = 0;
    }
    if (_struggleHits >= 3 && t >= _struggleCooldownUntil) {
      final conf = 0.5 +
          0.25 * ((gyroRms - c.struggleGyroRms) / 4).clamp(0.0, 1.0) +
          0.25 * ((rms - c.struggleAccRms) / 8).clamp(0.0, 1.0);
      out.add(MotionEvent(type: MotionEventType.struggle, confidence: math.min(1.0, conf), timestampMs: t));
      _struggleCooldownUntil = t + 60000;
      _struggleEmittedAt = t;
      _struggleHits = 0;
    }
  }

  /// Max normalised autocorrelation of the smoothed signal for lags of
  /// 0.2-0.7s (i.e. 1.4-5 Hz: the walking..sprinting stride band). ~1 for a
  /// clean rhythmic gait, ~0.1-0.3 for noise/struggling/stillness.
  double _periodicity() {
    final n = _smWin.length;
    if (n < 60) return 0;
    final w = _smWin.map((e) => e[1]).toList(growable: false);
    final mean = w.reduce((a, b) => a + b) / n;
    final x = List<double>.generate(n, (i) => w[i] - mean);
    var variance = 0.0;
    for (final v in x) {
      variance += v * v;
    }
    if (variance < 1e-6) return 0;

    final span = (_smWin.last[0] - _smWin.first[0]) / 1000;
    if (span <= 0) return 0;
    final dt = span / (n - 1);
    final lo = math.max(1, (0.2 / dt).floor());
    final hi = math.min(n ~/ 2, (0.7 / dt).floor());

    var best = 0.0;
    for (var lag = lo; lag <= hi; lag++) {
      var num = 0.0, a2 = 0.0, b2 = 0.0;
      for (var i = 0; i < n - lag; i++) {
        num += x[i] * x[i + lag];
        a2 += x[i] * x[i];
        b2 += x[i + lag] * x[i + lag];
      }
      final den = math.sqrt(a2 * b2);
      if (den > 0) best = math.max(best, num / den);
    }
    return best;
  }
}