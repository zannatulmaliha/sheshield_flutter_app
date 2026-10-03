import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/features/admin/domain/entities/verification_image_kind.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_verification_image_provider.dart';

/// A labelled photo of a verification submission, loaded on demand.
class VerificationImageTile extends ConsumerWidget {
  const VerificationImageTile({
    super.key,
    required this.verificationId,
    required this.kind,
  });

  final String verificationId;
  final VerificationImageKind kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageState = ref.watch(
      adminVerificationImageControllerProvider(verificationId, kind),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(kind.label, style: const TextStyle(fontWeight: FontWeight.w800)),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: imageState.when(
            loading: () => const SizedBox(
              height: 180,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const _ImageUnavailable(),
            data: (bytes) => bytes.isEmpty
                ? const _ImageUnavailable()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.memory(bytes, fit: BoxFit.contain),
                  ),
          ),
        ),
      ],
    );
  }
}

class _ImageUnavailable extends StatelessWidget {
  const _ImageUnavailable();

  @override
  Widget build(BuildContext context) => const SizedBox(
        height: 80,
        child: Center(child: Text('Image unavailable')),
      );
}
