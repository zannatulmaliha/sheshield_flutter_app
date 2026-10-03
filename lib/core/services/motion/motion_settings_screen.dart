import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/theme/app_palette.dart';

import 'motion_api.dart';
import 'motion_guard.dart';
import 'motion_settings.dart';

/// Opt-in controls for movement protection. Plain-language on purpose: what
/// is watched, what stays on the phone, and exactly when an SOS can be sent.
class MotionSettingsScreen extends ConsumerWidget {
  const MotionSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final guard = ref.watch(motionGuardProvider);
    final s = guard.settings;
    final ctrl = ref.read(motionGuardProvider.notifier);

    Widget card(List<Widget> children) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
        );

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Movement protection'),
        backgroundColor: Colors.transparent,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          card([
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Detect falls, sprints and struggles',
                  style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w800),),
              subtitle: Text(
                'Uses your phone\'s motion sensors, analysed only on this phone. Raw sensor data is never uploaded. '
                'A notification stays visible while this is on.',
                style: TextStyle(color: colors.textSecondary, fontSize: 12.5),
              ),
              value: s.enabled,
              onChanged: guard.loaded ? (v) => ctrl.update(s.copyWith(enabled: v)) : null,
            ),
          ]),
          card([
            Text('Sensitivity', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text('Higher catches more, but asks "Are you OK?" more often. Every detection is confirmed with you first.',
                style: TextStyle(color: colors.textSecondary, fontSize: 12.5),),
            const SizedBox(height: 12),
            SegmentedButton<MotionSensitivity>(
              segments: [for (final v in MotionSensitivity.values) ButtonSegment(value: v, label: Text(v.label))],
              selected: {s.sensitivity},
              onSelectionChanged: s.enabled ? (v) => ctrl.update(s.copyWith(sensitivity: v.first)) : null,
            ),
          ]),
          card([
            Text('If you don\'t answer "Are you OK?"', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text('You always get a 20-30 second countdown first. Choose what happens when it runs out.',
                style: TextStyle(color: colors.textSecondary, fontSize: 12.5),),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('After a fall'),
              value: s.fallAutoSos,
              onChanged: s.enabled ? (v) => ctrl.update(s.copyWith(fallAutoSos: v)) : null,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('After a struggle'),
              value: s.struggleAutoSos,
              onChanged: s.enabled ? (v) => ctrl.update(s.copyWith(struggleAutoSos: v)) : null,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('After a sudden sprint'),
              subtitle: const Text('Off by default: a runner and someone being chased look the same to a sensor.'),
              value: s.sprintAutoSos,
              onChanged: s.enabled ? (v) => ctrl.update(s.copyWith(sprintAutoSos: v)) : null,
            ),
          ]),
          card([
            Text('Your data', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text('Only the type of event, how confident it was and your answer are stored (for your own history). '
                'They are deleted automatically after 30 days.',
                style: TextStyle(color: colors.textSecondary, fontSize: 12.5),),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () async {
                final ok = await getIt<MotionApi>().deleteAll();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(ok ? 'Motion history erased.' : 'Could not erase right now.')),
                  );
                }
              },
              icon: const Icon(Icons.delete_outline_rounded),
              label: const Text('Erase my motion history'),
            ),
          ]),
          Text(
            'Detection is a helper, not a guarantee: it can miss events or react to normal activity. '
            'In a real emergency, call your local emergency number.',
            style: TextStyle(color: colors.textSecondary, fontSize: 11.5, height: 1.4),
          ),
        ],
      ),
    );
  }
}
