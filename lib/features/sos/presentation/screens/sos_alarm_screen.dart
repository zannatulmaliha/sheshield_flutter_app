import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shown full-screen the instant a push from a linked trusted contact's SOS
/// arrives (see PushService), in every app state. Pushed directly on the
/// root navigator rather than as a go_router route, so it appears on top of
/// whatever the person was doing without fighting the router's auth/role
/// redirect. The alarm sounds while this screen is mounted.
class SosAlarmScreen extends HookConsumerWidget {
  const SosAlarmScreen({
    super.key,
    required this.senderName,
    required this.latitude,
    required this.longitude,
  });

  static const _alarmColor = Color(0xFFC2185B);

  final String senderName;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmService = ref.read(deviceAlarmServiceProvider);

    useEffect(() {
      alarmService.start();
      return alarmService.stop;
    }, const [],);

    Future<void> openLocation() => launchUrl(
          Uri.parse('https://maps.google.com/?q=$latitude,$longitude'),
          mode: LaunchMode.externalApplication,
        );

    return Scaffold(
      backgroundColor: _alarmColor,
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
                '$senderName needs help right now.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: openLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _alarmColor,
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
