import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

/// Asks for a destination, then opens Google Maps walking directions from
/// the device's current location: the same "hand off to the external Maps
/// app" pattern used by helper mode and the SOS alarm screen.
Future<void> showSafeRouteSheet(BuildContext context) async {
  final locationService =
      ProviderScope.containerOf(context).read(deviceLocationServiceProvider);

  final destination = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (_) => const SafeRouteSheet(),
  );
  if (destination == null || destination.trim().isEmpty) return;

  final position = await locationService.getCurrentPosition();
  final origin = position == null
      ? ''
      : '&origin=${position.latitude},${position.longitude}';
  final directionsUri = Uri.parse(
    'https://www.google.com/maps/dir/?api=1$origin'
    '&destination=${Uri.encodeComponent(destination)}&travelmode=walking',
  );

  final didOpen = await launchUrl(directionsUri, mode: LaunchMode.externalApplication);
  if (!didOpen && context.mounted) context.showMessage("Couldn't open Maps.");
}

class SafeRouteSheet extends HookConsumerWidget {
  const SafeRouteSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final destinationController = useTextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Plan a safe route',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              "We'll open walking directions from your current location.",
              style: TextStyle(color: palette.textSecondary, fontSize: 12.5),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: destinationController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Destination',
                hintText: 'Home, a police station, an address...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) => Navigator.of(context).pop(value),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(destinationController.text),
                child: const Text('Get directions'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
