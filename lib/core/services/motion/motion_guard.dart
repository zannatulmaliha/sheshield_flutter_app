import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';

import 'motion_api.dart';
import 'motion_event.dart';
import 'motion_service.dart';
import 'motion_settings.dart';
import 'motion_prompt_screen.dart';

/// A pending "Are you OK?" confirmation.
class MotionPrompt {
  const MotionPrompt({required this.event, required this.totalSeconds, required this.remaining, required this.willSendSos});
  final MotionEvent event;
  final int totalSeconds;
  final int remaining;

  /// Whether running out the clock sends an SOS (per the person's settings).
  final bool willSendSos;

  MotionPrompt tick() => MotionPrompt(event: event, totalSeconds: totalSeconds, remaining: remaining - 1, willSendSos: willSendSos);
}

class MotionGuardState {
  const MotionGuardState({this.settings = const MotionSettings(), this.loaded = false, this.prompt});
  final MotionSettings settings;
  final bool loaded;
  final MotionPrompt? prompt;

  MotionGuardState copyWith({MotionSettings? settings, bool? loaded, MotionPrompt? prompt, bool clearPrompt = false}) =>
      MotionGuardState(
        settings: settings ?? this.settings,
        loaded: loaded ?? this.loaded,
        prompt: clearPrompt ? null : (prompt ?? this.prompt),
      );
}

final motionGuardProvider = NotifierProvider<MotionGuardController, MotionGuardState>(MotionGuardController.new);

/// Orchestrates the whole movement-protection flow:
///
///   sensor -> MotionDetector -> event -> "Are you OK?" countdown
///        -> [I'm OK]      : logged as a false positive, nothing is sent
///        -> [I need help] : SOS sent immediately
///        -> [no answer]   : SOS sent if the person enabled that for this
///                           event type (sprints default to NOT sending)
///
/// Safety/fairness rules baked in:
///  * Opt-in, off by default, reversible, and always shows a persistent
///    notification while running.
///  * A detection alone never notifies anyone -- only the person's answer
///    (or their pre-chosen silence rule) does.
///  * Prompts are rate-limited and suppressed while an SOS is already active,
///    and inactivity after an "I'm OK" is ignored.
///  * Motion events are logged for the person's own transparency; nothing
///    counts them to restrict SOS access (spec core principle).
class MotionGuardController extends Notifier<MotionGuardState> {
  final MotionService _service = MotionService();
  Timer? _countdown;
  DateTime _lastPromptAt = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _okUntil = DateTime.fromMillisecondsSinceEpoch(0);

  static const _promptCooldown = Duration(seconds: 45);
  static const _okQuietPeriod = Duration(minutes: 2);

  @override
  MotionGuardState build() {
    ref.onDispose(() {
      _countdown?.cancel();
      _service.stop();
    });
    return const MotionGuardState();
  }

  /// Load saved settings and start sensing if the person had it enabled.
  /// Call once after login (idempotent).
  bool _initStarted = false;
  Future<void> init() async {
    if (_initStarted) return;
    _initStarted = true;
    final s = await ref.read(motionSettingsStoreProvider).loadMotionSettings();
    state = state.copyWith(settings: s, loaded: true);
    if (s.enabled) await _startSensing();
  }

  Future<void> update(MotionSettings next) async {
    final wasEnabled = state.settings.enabled;
    final sensChanged = next.sensitivity != state.settings.sensitivity;
    state = state.copyWith(settings: next);
    await ref.read(motionSettingsStoreProvider).saveMotionSettings(next);
    if (next.enabled && (!wasEnabled || sensChanged)) {
      await _startSensing();
    } else if (!next.enabled && wasEnabled) {
      await _service.stop();
      _dismissPrompt();
    }
  }

  Future<void> _startSensing() => _service.start(_onEvent, config: state.settings.sensitivity.config);

  void _onEvent(MotionEvent ev) {
    final now = DateTime.now();
    final active = state.prompt;

    // The post-fall inactivity signal escalates a fall prompt that's already
    // on screen: someone who fell and isn't moving shouldn't wait the full
    // countdown. Ignored if they already told us they're fine.
    if (ev.type == MotionEventType.inactivity) {
      if (now.isBefore(_okUntil)) return;
      if (active != null && active.event.type == MotionEventType.fall) {
        _finish(MotionUserResponse.timeout, forceSend: true);
        return;
      }
    }

    if (active != null) return;
    if (now.difference(_lastPromptAt) < _promptCooldown && ev.type != MotionEventType.inactivity) return;
    if (ref.read(sosControllerProvider).valueOrNull != null) return; // SOS already live
    if (ev.type == MotionEventType.inactivity && now.isBefore(_okUntil)) return;

    _lastPromptAt = now;
    final s = state.settings;
    final seconds = ev.type == MotionEventType.sprint ? 20 : 30;
    final willSend = switch (ev.type) {
      MotionEventType.fall || MotionEventType.inactivity => s.fallAutoSos,
      MotionEventType.struggle => s.struggleAutoSos,
      MotionEventType.sprint => s.sprintAutoSos,
    };
    state = state.copyWith(prompt: MotionPrompt(event: ev, totalSeconds: seconds, remaining: seconds, willSendSos: willSend));

    _countdown?.cancel();
    _countdown = Timer.periodic(const Duration(seconds: 1), (_) {
      final p = state.prompt;
      if (p == null) return;
      HapticFeedback.heavyImpact();
      if (p.remaining <= 1) {
        _finish(MotionUserResponse.timeout);
      } else {
        state = state.copyWith(prompt: p.tick());
      }
    });

    // Show the full-screen prompt if the app is in the foreground. If it's
    // not, the countdown above still runs and the same rules apply.
    final nav = rootNavigatorKey.currentState;
    nav?.push(MaterialPageRoute<void>(fullscreenDialog: true, builder: (_) => const MotionPromptScreen()));
  }

  /// Called by the prompt screen.
  void answerOk() => _finish(MotionUserResponse.ok);
  void answerHelp() => _finish(MotionUserResponse.help);

  void _dismissPrompt() {
    _countdown?.cancel();
    _countdown = null;
    state = state.copyWith(clearPrompt: true);
  }

  Future<void> _finish(MotionUserResponse response, {bool forceSend = false}) async {
    final p = state.prompt;
    if (p == null) return;
    _dismissPrompt();

    final send = response == MotionUserResponse.help || forceSend || (response == MotionUserResponse.timeout && p.willSendSos);
    if (response == MotionUserResponse.ok) _okUntil = DateTime.now().add(_okQuietPeriod);

    String? sosId;
    if (send) {
      final err = await ref.read(sosControllerProvider.notifier).send(trigger: p.event.type.sosTrigger);
      sosId = ref.read(sosControllerProvider).valueOrNull?.id;
      if (err != null) {
        final ctx = rootNavigatorKey.currentContext;
        if (ctx != null && ctx.mounted) {
          ScaffoldMessenger.maybeOf(ctx)?.showSnackBar(SnackBar(content: Text(err)));
        }
      }
    }

    // Log for the person's own history (best effort, never blocks the SOS).
    final pos = await ref
        .read(deviceLocationServiceProvider)
        .getCurrentPosition()
        .timeout(const Duration(seconds: 3), onTimeout: () => null);
    unawaited(ref.read(motionApiProvider).report(
      p.event,
      response: response,
      sosId: sosId,
      latitude: pos?.latitude,
      longitude: pos?.longitude,
    ),);
  }
}
