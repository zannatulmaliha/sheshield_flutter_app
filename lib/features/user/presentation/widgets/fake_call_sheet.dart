import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/presentation/screens/fake_call_screen.dart';

const _callerPresets = ['Mom', 'Dad', 'Boss', 'Unknown'];
const _delayPresets = [Duration.zero, Duration(seconds: 5), Duration(seconds: 15)];

/// Bottom sheet to pick a caller name and ring delay, then trigger
/// [FakeCallScreen] on the root navigator so it appears full-screen on
/// top of whatever's on screen -- same pattern PushService uses for the
/// incoming-SOS overlay.
Future<void> showFakeCallSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _FakeCallSheet(),
  );
}

class _FakeCallSheet extends ConsumerStatefulWidget {
  const _FakeCallSheet();

  @override
  ConsumerState<_FakeCallSheet> createState() => _FakeCallSheetState();
}

class _FakeCallSheetState extends ConsumerState<_FakeCallSheet> {
  String _caller = _callerPresets.first;
  Duration _delay = Duration.zero;

  void _push(String caller) {
    rootNavigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => FakeCallScreen(callerName: caller),
        fullscreenDialog: true,
      ),
    );
  }

  void _trigger() {
    final caller = _caller;
    final delay = _delay;
    Navigator.of(context).pop();

    if (delay == Duration.zero) {
      _push(caller);
      return;
    }
    final rootContext = rootNavigatorKey.currentContext;
    if (rootContext != null) {
      ScaffoldMessenger.maybeOf(rootContext)?.showSnackBar(
        SnackBar(content: Text('Fake call from $caller in ${delay.inSeconds}s')),
      );
    }
    Future.delayed(delay, () => _push(caller));
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        decoration: BoxDecoration(
          color: colors.surface,
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
            Text(
              'Caller',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _callerPresets
                  .map((c) => ChoiceChip(
                        label: Text(c),
                        selected: _caller == c,
                        onSelected: (_) => setState(() => _caller = c),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Ring after',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _delayPresets
                  .map((d) => ChoiceChip(
                        label: Text(d == Duration.zero ? 'Now' : '${d.inSeconds}s'),
                        selected: _delay == d,
                        onSelected: (_) => setState(() => _delay = d),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _trigger,
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
