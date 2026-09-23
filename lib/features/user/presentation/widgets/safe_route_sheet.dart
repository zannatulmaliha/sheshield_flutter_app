import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:url_launcher/url_launcher.dart';

/// Asks for a destination, then opens Google Maps walking directions
/// from the device's current location -- same "hand off to the external
/// Maps app" pattern already used for helper mode
/// (helper_alert_detail_screen.dart) and the SOS alarm screen.
Future<void> showSafeRouteSheet(BuildContext context) async {
  final messenger = ScaffoldMessenger.of(context);

  final destination = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (_) => const _SafeRouteSheetBody(),
  );
  if (destination == null || destination.trim().isEmpty) return;

  final position = await getIt<DeviceLocationService>().getCurrentPosition();
  final uri = position != null
      ? Uri.parse(
          'https://www.google.com/maps/dir/?api=1'
          '&origin=${position.latitude},${position.longitude}'
          '&destination=${Uri.encodeComponent(destination)}'
          '&travelmode=walking',
        )
      : Uri.parse(
          'https://www.google.com/maps/dir/?api=1'
          '&destination=${Uri.encodeComponent(destination)}'
          '&travelmode=walking',
        );

  final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!opened) {
    messenger.showSnackBar(const SnackBar(content: Text("Couldn't open Maps.")));
  }
}

class _SafeRouteSheetBody extends ConsumerStatefulWidget {
  const _SafeRouteSheetBody();

  @override
  ConsumerState<_SafeRouteSheetBody> createState() => _SafeRouteSheetBodyState();
}

class _SafeRouteSheetBodyState extends ConsumerState<_SafeRouteSheetBody> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
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
              style: TextStyle(color: colors.textSecondary, fontSize: 12.5),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Destination',
                hintText: 'Home, a police station, an address...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (v) => Navigator.of(context).pop(v),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(_controller.text),
                child: const Text('Get directions'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
