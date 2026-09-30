import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/ringtone_service.dart';

/// Full-screen fake incoming-call UI, pushed after the delay chosen from
/// the "Fake Call Generator" sheet on [AiModeScreen]. Rings on the
/// *ringer* audio stream via [RingtoneService] -- a different stream
/// than [DeviceAlarmService] uses for a real SOS -- so it reads as an
/// ordinary incoming call to anyone nearby, not a siren.
class FakeCallScreen extends StatefulWidget {
  const FakeCallScreen({super.key, this.callerName = 'Mom'});
  final String callerName;

  @override
  State<FakeCallScreen> createState() => _FakeCallScreenState();
}

class _FakeCallScreenState extends State<FakeCallScreen> {
  Timer? _hapticTimer;

  @override
  void initState() {
    super.initState();
    getIt<RingtoneService>().start();
    _hapticTimer = Timer.periodic(
      const Duration(milliseconds: 1200),
      (_) => HapticFeedback.vibrate(),
    );
  }

  @override
  void dispose() {
    _hapticTimer?.cancel();
    getIt<RingtoneService>().stop();
    super.dispose();
  }

  void _end() => Navigator.of(context).pop();

  String get _initials {
    final parts = widget.callerName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    return parts.first.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // A real incoming call can't be dismissed with the back gesture --
      // only Accept/Decline should end it.
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
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 28),
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white24,
                  child: Text(
                    _initials,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.callerName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                const Text('mobile', style: TextStyle(color: Colors.white54)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CallButton(
                      icon: Icons.call_end_rounded,
                      color: Colors.redAccent,
                      label: 'Decline',
                      onTap: _end,
                    ),
                    _CallButton(
                      icon: Icons.call_rounded,
                      color: Colors.green,
                      label: 'Accept',
                      onTap: _end,
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

class _CallButton extends StatelessWidget {
  const _CallButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkResponse(
          onTap: onTap,
          radius: 46,
          child: Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 10),
        Text(label,
            style: const TextStyle(
                color: Colors.white70, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
