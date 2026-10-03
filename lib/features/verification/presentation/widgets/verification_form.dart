import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/hooks/use_async_action.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/verification/domain/entities/verification_status.dart';
import 'package:sheshield/features/verification/presentation/hooks/use_verification_photos.dart';
import 'package:sheshield/features/verification/presentation/providers/verification_provider.dart';
import 'package:sheshield/features/verification/presentation/widgets/photo_picker_tile.dart';
import 'package:sheshield/features/verification/presentation/widgets/verification_photo_slot.dart';
import 'package:sheshield/features/verification/presentation/widgets/verification_rejection_banner.dart';

/// The upload form, shown while status is none or rejected. Submit stays
/// disabled until all three photos are picked.
class VerificationForm extends HookConsumerWidget {
  const VerificationForm({super.key, required this.status});

  final VerificationStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final photos = useVerificationPhotos();
    final submitAction = useAsyncAction();
    final errorMessage = photos.errorMessage ?? submitAction.errorMessage;
    final canSubmit = photos.isComplete && !submitAction.isRunning;

    Future<void> submitPhotos() async {
      final wasSubmitted = await submitAction.run(
        () => ref.read(verificationControllerProvider.notifier).submit(
              nidFront: photos[VerificationPhotoSlot.idFront]!,
              nidBack: photos[VerificationPhotoSlot.idBack]!,
              selfie: photos[VerificationPhotoSlot.selfie]!,
            ),
      );
      if (wasSubmitted) photos.clear();
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        if (status.status == VerificationState.rejected && status.note.isNotEmpty)
          VerificationRejectionBanner(palette: palette, reviewerNote: status.note),
        Text(
          'Verify your identity',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: palette.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Add a photo of the front and back of your national ID, and a selfie '
          'so we can compare your face to it.',
          style: TextStyle(color: palette.textSecondary, fontSize: 13.5, height: 1.45),
        ),
        const SizedBox(height: 20),
        for (final slot in VerificationPhotoSlot.values)
          PhotoPickerTile(
            colors: palette,
            label: slot.label,
            hint: slot.hint,
            icon: slot.icon,
            bytes: photos[slot],
            onTap: submitAction.isRunning ? null : () => photos.pick(slot),
          ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 10),
            child: Text(
              errorMessage,
              style: TextStyle(
                color: palette.sosEnd,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: palette.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: canSubmit ? submitPhotos : null,
          child: submitAction.isRunning
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                )
              : const Text(
                  'Submit for review',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
        ),
      ],
    );
  }
}
