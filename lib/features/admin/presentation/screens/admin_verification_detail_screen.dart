import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';
import 'package:sheshield/features/admin/domain/entities/verification_image_kind.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_verification_detail_provider.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_async_body.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_scaffold.dart';
import 'package:sheshield/features/admin/presentation/widgets/verification_decision_buttons.dart';
import 'package:sheshield/features/admin/presentation/widgets/verification_image_tile.dart';
import 'package:sheshield/features/admin/presentation/widgets/verification_info_card.dart';

class AdminVerificationDetailScreen extends ConsumerWidget {
  const AdminVerificationDetailScreen({super.key, required this.verificationId});

  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdminScaffold(
      title: 'Verification Review',
      body: AdminAsyncBody<AdminVerification>(
        value: ref.watch(adminVerificationDetailControllerProvider(verificationId)),
        builder: (verification) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
          children: [
            VerificationInfoCard(verification: verification),
            const SizedBox(height: 16),
            for (final kind in VerificationImageKind.values)
              VerificationImageTile(verificationId: verification.id, kind: kind),
            if (verification.note.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text('Review note: ${verification.note}'),
              ),
            if (verification.isPending)
              VerificationDecisionButtons(verificationId: verification.id),
          ],
        ),
      ),
    );
  }
}
