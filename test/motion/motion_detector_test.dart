import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/core/services/motion/motion_detector.dart';
import 'package:sheshield/core/services/motion/motion_event.dart';

// Synthetic 50 Hz traces. Mirrors docs/motion-prototype/sim.py in the backend
// repo, which is where the thresholds were tuned over 40 random seeds.
const double g = 9.80665;
const int hz = 50;
const double dtMs = 1000 / hz;

typedef Sample = (List<double> a, List<double> gyro);
typedef Gen = Sample Function(double t);

class Rng {
  Rng(int seed) : _r = math.Random(seed);
  final math.Random _r;
  double gauss(double sd) {
    final u1 = 1 - _r.nextDouble(), u2 = _r.nextDouble();
    return sd * math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2);
  }
}

List<MotionEvent> run(Gen gen, double seconds) {
  final d = MotionDetector();
  final out = <MotionEvent>[];
  for (var i = 0; i < (seconds * hz).round(); i++) {
    final t = (i * dtMs).round();
    final (a, w) = gen(t / 1000);
    out.addAll(d.process(t, a[0], a[1], a[2], w[0], w[1], w[2]));
  }
  return out;
}

List<MotionEventType> types(List<MotionEvent> e) => e.map((x) => x.type).toList();

void main() {
  for (final seed in [1, 2, 3, 4, 5]) {
    group('seed $seed', () {
      final r = Rng(seed);
      Sample still(double t) => ([r.gauss(.02 * g), r.gauss(.02 * g), g + r.gauss(.02 * g)], [r.gauss(.03), r.gauss(.03), r.gauss(.03)]);

      Gen gait(double f, double amp, {double jit = 0}) => (t) {
            final ph = t + jit * math.sin(2 * math.pi * .13 * t) / (2 * math.pi * .13);
            final v = amp * g * (1 + jit * 2 * math.sin(2 * math.pi * .31 * t)) *
                (math.sin(2 * math.pi * f * ph) + .35 * math.sin(4 * math.pi * f * ph + .6));
            return (
              [r.gauss(.02 * g) + .25 * v, r.gauss(.02 * g) + .15 * v, g + v + r.gauss(.02 * g)],
              [r.gauss(.4 * f / 2), r.gauss(.4 * f / 2), r.gauss(.4 * f / 2)]
            );
          };

      Gen seq(List<(double, Gen)> parts) => (t) {
            var acc = 0.0;
            for (final (d, f) in parts) {
              if (t < acc + d) return f(t - acc);
              acc += d;
            }
            return parts.last.$2(t - acc);
          };

      Sample struggle(double t) => (
            [r.gauss(.9 * g), r.gauss(.9 * g), g + r.gauss(.9 * g)],
            [r.gauss(3.5), r.gauss(3.5), r.gauss(3.5)]
          );

      Gen fall({bool freefall = true, double? getUp, double impact = 4.0}) => (t) {
            if (t < 2) return ([r.gauss(.02 * g), g + r.gauss(.02 * g), r.gauss(.02 * g)], [r.gauss(.03), r.gauss(.03), r.gauss(.03)]);
            final tt = t - 2;
            if (freefall && tt < .25) return ([r.gauss(.06 * g), .15 * g, r.gauss(.06 * g)], [r.gauss(1.2), r.gauss(1.2), r.gauss(1.2)]);
            final off = freefall ? .25 : 0.0;
            if (tt < off + .06) return ([impact * g * .6, impact * g * .7, impact * g * .3], [r.gauss(3), r.gauss(3), r.gauss(3)]);
            if (tt < off + .5) return ([r.gauss(.5 * g), r.gauss(.5 * g), g + r.gauss(.3 * g)], [r.gauss(1.5), r.gauss(1.5), r.gauss(1.5)]);
            if (getUp != null && tt > getUp) return gait(1.6, .2)(tt);
            return still(tt);
          };

      test('stillness, walking and jogging never fire', () {
        expect(run((t) => still(t), 30), isEmpty);
        expect(run(gait(1.9, .22), 60), isEmpty);
        expect(run(gait(2.7, .65), 60), isEmpty);
      });

      test('sprint app-start (already sprinting) does not fire', () {
        expect(run(gait(3.5, 1.25), 60), isEmpty);
      });

      test('walk -> sprint fires exactly one sprint', () {
        final e = run(seq([(20, gait(1.9, .22)), (15, gait(3.5, 1.25))]), 35);
        expect(types(e), [MotionEventType.sprint]);
      });

      test('jog -> sprint and a 2s burst do not fire', () {
        expect(run(seq([(40, gait(2.7, .65)), (15, gait(3.5, 1.25))]), 55), isEmpty);
        expect(run(seq([(20, gait(1.9, .22)), (2, gait(3.5, 1.25)), (20, gait(1.9, .22))]), 42), isEmpty);
      });

      test('fall and staying down fires fall then inactivity', () {
        expect(types(run(fall(), 42)), [MotionEventType.fall, MotionEventType.inactivity]);
      });

      test('fall then getting up quickly does not fire', () {
        expect(run(fall(getUp: 1.5), 15), isEmpty);
        expect(run(fall(getUp: .8, impact: 3.0), 15), isEmpty);
      });

      test('struggle fires once and is not also reported as a sprint', () {
        final e = run(seq([(10, still), (10, struggle)]), 20);
        expect(types(e), [MotionEventType.struggle]);
      });
    });
  }
}
