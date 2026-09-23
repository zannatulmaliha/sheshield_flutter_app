import 'package:flutter/material.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/device_alarm_service.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shown full-screen the instant a push from a linked trusted contact's
/// SOS arrives (see PushService), in every app state -- foreground,
/// backgrounded, or freshly launched from a killed state by tapping the
/// notification. Pushed directly on the root navigator rather than as a
/// go_router route, so it appears on top of whatever the person was doing
/// without fighting the router's auth/role redirect logic.
class SosAlarmScreen extends StatefulWidget {
  const SosAlarmScreen({
    super.key,
    required this.senderName,
    required this.latitude,
    required this.longitude,
  });

  final String senderName;
  final double latitude;
  final double longitude;

  @override
  State<SosAlarmScreen> createState() => _SosAlarmScreenState();
}

class _SosAlarmScreenState extends State<SosAlarmScreen> {
  @override
  void initState() {
    super.initState();
    getIt<DeviceAlarmService>().start();
  }

  @override
  void dispose() {
    getIt<DeviceAlarmService>().stop();
    super.dispose();
  }

  Future<void> _openLocation() async {
    final uri = Uri.parse('https://maps.google.com/?q=${widget.latitude},${widget.longitude}');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC2185B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 96),
              const SizedBox(height: 24),
              Text(
                'SOS ALERT',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                '${widget.senderName} needs help right now.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _openLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFC2185B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  icon: const Icon(Icons.map_rounded),
                  label: const Text('View live location'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("I'm aware", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
