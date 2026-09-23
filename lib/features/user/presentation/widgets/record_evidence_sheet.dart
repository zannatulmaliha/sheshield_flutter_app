import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/evidence_service.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// Lets the person capture a photo or video from the camera and saves it
/// into the app's own documents directory (see [EvidenceService]) --
/// nothing is uploaded anywhere, it just stays on the device.
Future<void> showRecordEvidenceSheet(BuildContext context) async {
  final messenger = ScaffoldMessenger.of(context);

  // true = video, false = photo, null = dismissed without choosing.
  final choice = await showModalBottomSheet<bool>(
    context: context,
    builder: (sheetContext) => Consumer(
      builder: (context, ref, _) {
        final colors = resolvePalette(context, ref);
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera_rounded, color: colors.primary),
                title: const Text('Take a photo'),
                onTap: () => Navigator.of(sheetContext).pop(false),
              ),
              ListTile(
                leading: Icon(Icons.videocam_rounded, color: colors.primary),
                title: const Text('Record a video'),
                onTap: () => Navigator.of(sheetContext).pop(true),
              ),
            ],
          ),
        );
      },
    ),
  );
  if (choice == null) return;

  final service = getIt<EvidenceService>();
  final path = choice ? await service.captureVideo() : await service.capturePhoto();

  messenger.showSnackBar(
    SnackBar(
      content: Text(
        path != null ? 'Evidence saved securely on this device.' : 'Capture cancelled.',
      ),
    ),
  );
}
