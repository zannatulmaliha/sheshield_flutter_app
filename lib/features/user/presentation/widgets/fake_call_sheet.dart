import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/presentation/screens/fake_call_screen.dart';

const _callerPresets = ['Mom', 'Dad', 'Boss', 'Unknown'];
const _delayPresets = [
  Duration.zero,
  Duration(seconds: 5),
  Duration(seconds: 15),
  Duration(seconds: 30),
];

/// Bottom sheet to pick a caller name and ring delay, then show
/// [FakeCallScreen] on the root navigator so it appears full-screen on top
/// of whatever is on screen: the same pattern PushService uses for the
/// incoming-SOS overlay.
Future<void> showFakeCallSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const FakeCallSheet(),
  );
}

void _showFakeCall(String callerName) {
  rootNavigatorKey.currentState?.push(
    MaterialPageRoute<void>(
      builder: (_) => FakeCallScreen(callerName: callerName),
      fullscreenDialog: true,
    ),
  );
}

void _scheduleFakeCall(String callerName, Duration delay) {
  if (delay == Duration.zero) {
    _showFakeCall(callerName);
    return;
  }
  final rootContext = rootNavigatorKey.currentContext;
  if (rootContext != null) {
    ScaffoldMessenger.maybeOf(rootContext)?.showSnackBar(
      SnackBar(content: Text('Fake call from $callerName in ${delay.inSeconds}s')),
    );
  }
  Future<void>.delayed(delay, () => _showFakeCall(callerName));
}

class FakeCallSheet extends HookConsumerWidget {
  const FakeCallSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final caller = useState(_callerPresets.first);
    final delay = useState(Duration.zero);
    final labelStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 13,
      color: palette.textSecondary,
    );

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Simulate a call',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text('Caller', style: labelStyle),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final preset in _callerPresets)
                  ChoiceChip(
                    label: Text(preset),
                    selected: caller.value == preset,
                    onSelected: (_) => caller.value = preset,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Ring after', style: labelStyle),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final preset in _delayPresets)
                  ChoiceChip(
                    label: Text(preset == Duration.zero ? 'Now' : '${preset.inSeconds}s'),
                    selected: delay.value == preset,
                    onSelected: (_) => delay.value = preset,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _scheduleFakeCall(caller.value, delay.value);
                },
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
