import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

enum _CallStage { ringing, ongoing }

/// A fake incoming call, pushed full-screen on the root navigator (see
/// [showFakeCallSheet]) so it looks and behaves like a real call
/// overlay -- useful for getting out of an uncomfortable situation
/// without anyone nearby realising it's staged.
class FakeCallScreen extends StatefulWidget {
  const FakeCallScreen({super.key, required this.callerName});

  final String callerName;

  @override
  State<FakeCallScreen> createState() => _FakeCallScreenState();
}

class _FakeCallScreenState extends State<FakeCallScreen> {
  _CallStage _stage = _CallStage.ringing;
  final _player = AudioPlayer();
  Timer? _vibrateTimer;
  Timer? _durationTimer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startRinging();
  }

  Future<void> _startRinging() async {
    try {
      await _player.setAsset('assets/sounds/sos_alarm.wav');
      await _player.setLoopMode(LoopMode.all);
      await _player.play();
    } catch (_) {
      // Best-effort -- a silent fake call still shows a convincing UI.
    }
    _vibrateTimer = Timer.periodic(const Duration(milliseconds: 900), (_) {
      HapticFeedback.heavyImpact();
    });
  }

  void _accept() {
    _player.stop();
    _vibrateTimer?.cancel();
    setState(() => _stage = _CallStage.ongoing);
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _elapsed += const Duration(seconds: 1));
    });
  }

  void _end() => Navigator.of(context).maybePop();

  @override
  void dispose() {
    _vibrateTimer?.cancel();
    _durationTimer?.cancel();
    _player.dispose();
    super.dispose();
  }

  String get _elapsedLabel {
    final m = _elapsed.inMinutes.toString().padLeft(2, '0');
    final s = (_elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final ringing = _stage == _CallStage.ringing;

    return Scaffold(
      backgroundColor: const Color(0xFF14162B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                ringing ? 'Incoming call' : _elapsedLabel,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 64,
                backgroundColor: Colors.white24,
                child: Text(
                  widget.callerName.isNotEmpty
                      ? widget.callerName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.callerName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              if (ringing)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CallActionButton(
                      icon: Icons.call_end_rounded,
                      color: const Color(0xFFC2185B),
                      label: 'Decline',
                      onTap: _end,
                    ),
                    _CallActionButton(
                      icon: Icons.call_rounded,
                      color: const Color(0xFF2FC28E),
                      label: 'Accept',
                      onTap: _accept,
                    ),
                  ],
                )
              else
                _CallActionButton(
                  icon: Icons.call_end_rounded,
                  color: const Color(0xFFC2185B),
                  label: 'End',
                  onTap: _end,
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _CallActionButton extends StatelessWidget {
  const _CallActionButton({
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
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
