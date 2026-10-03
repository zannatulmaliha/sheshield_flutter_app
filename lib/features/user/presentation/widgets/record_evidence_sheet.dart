import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';

enum EvidenceKind { photo, video }

/// Lets the person capture a photo or video and saves it into the app's own
/// documents directory (see `EvidenceService`). Nothing is uploaded: it
/// stays on the device.
Future<void> showRecordEvidenceSheet(BuildContext context) async {
  final evidenceService =
      ProviderScope.containerOf(context).read(evidenceServiceProvider);

  final kind = await showModalBottomSheet<EvidenceKind>(
    context: context,
    builder: (_) => const EvidenceKindSheet(),
  );
  if (kind == null) return;

  final savedPath = switch (kind) {
    EvidenceKind.photo => await evidenceService.capturePhoto(),
    EvidenceKind.video => await evidenceService.captureVideo(),
  };

  if (!context.mounted) return;
  context.showMessage(
    savedPath != null ? 'Evidence saved securely on this device.' : 'Capture cancelled.',
  );
}

class EvidenceKindSheet extends ConsumerWidget {
  const EvidenceKindSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);

    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.photo_camera_rounded, color: palette.primary),
            title: const Text('Take a photo'),
            onTap: () => Navigator.of(context).pop(EvidenceKind.photo),
          ),
          ListTile(
            leading: Icon(Icons.videocam_rounded, color: palette.primary),
            title: const Text('Record a video'),
            onTap: () => Navigator.of(context).pop(EvidenceKind.video),
          ),
        ],
      ),
    );
  }
}
