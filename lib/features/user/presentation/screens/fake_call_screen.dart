import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/hooks/use_periodic_callback.dart';
import 'package:sheshield/features/user/presentation/widgets/fake_call_button.dart';

/// Full-screen fake incoming-call UI, pushed after the delay chosen in the
/// "Fake Call Generator" sheet. Rings on the *ringer* audio stream via
/// `RingtoneService`, a different stream than the real-SOS alarm uses, so
/// it reads as an ordinary incoming call to anyone nearby, not a siren.
class FakeCallScreen extends HookConsumerWidget {
  const FakeCallScreen({super.key, this.callerName = 'Mom'});

  static const _vibrationInterval = Duration(milliseconds: 1200);

  final String callerName;

  String get _initial {
    final firstWord = callerName.trim().split(RegExp(r'\s+')).first;
    return firstWord.isEmpty ? '?' : firstWord.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ringtoneService = ref.read(ringtoneServiceProvider);

    useEffect(() {
      ringtoneService.start();
      return ringtoneService.stop;
    }, const [],);
    usePeriodicCallback(_vibrationInterval, HapticFeedback.vibrate);

    void endCall() => Navigator.of(context).pop();

    return PopScope(
      // A real incoming call can't be dismissed with the back gesture: only
      // Accept / Decline should end it.
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF121214),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Incoming call',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 28),
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white24,
                  child: Text(
                    _initial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  callerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                const Text('mobile', style: TextStyle(color: Colors.white54)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FakeCallButton(
                      icon: Icons.call_end_rounded,
                      color: Colors.redAccent,
                      label: 'Decline',
                      onTap: endCall,
                    ),
                    FakeCallButton(
                      icon: Icons.call_rounded,
                      color: Colors.green,
                      label: 'Accept',
                      onTap: endCall,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
