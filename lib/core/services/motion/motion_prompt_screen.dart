import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'motion_guard.dart';

/// Full-screen "Are you OK?" confirmation. The countdown itself lives in
/// [MotionGuardController] (so it keeps running if the app is backgrounded);
/// this screen only renders it and closes itself when the prompt ends.
class MotionPromptScreen extends ConsumerWidget {
  const MotionPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<MotionGuardState>(motionGuardProvider, (prev, next) {
      if (prev?.prompt != null && next.prompt == null && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });

    final prompt = ref.watch(motionGuardProvider).prompt;
    if (prompt == null) return const Scaffold(backgroundColor: Colors.black);
    final ctrl = ref.read(motionGuardProvider.notifier);
    final progress = prompt.remaining / prompt.totalSeconds;
    final urgent = prompt.remaining <= 10;

    return PopScope(
      canPop: false, // can't be swiped away by accident; answer or let it run out
      child: Scaffold(
        backgroundColor: urgent ? const Color(0xFF7F1D1D) : const Color(0xFF1F2937),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                Icon(Icons.health_and_safety_rounded, size: 72, color: Colors.white.withValues(alpha: 0.95)),
                const SizedBox(height: 16),
                Text(prompt.event.type.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800),),
                const SizedBox(height: 8),
                const Text('Are you OK?', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
                const SizedBox(height: 28),
                SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 10,
                          color: Colors.white,
                          backgroundColor: Colors.white24,
                        ),
                      ),
                      Text('${prompt.remaining}', style: const TextStyle(color: Colors.white, fontSize: 52, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  prompt.willSendSos
                      ? 'If you don\'t answer, SheShield will send an SOS to your contacts and nearby helpers.'
                      : 'Nothing will be sent unless you tap "I need help".',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton.icon(
                    onPressed: ctrl.answerHelp,
                    icon: const Icon(Icons.sos_rounded, size: 28),
                    label: const Text('I need help', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC2626),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton.icon(
                    onPressed: ctrl.answerOk,
                    icon: const Icon(Icons.check_circle_rounded, size: 28),
                    label: const Text("I'm OK", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
