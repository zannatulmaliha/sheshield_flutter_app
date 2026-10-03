import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/presentation/providers/trusted_contacts_provider.dart';
import 'package:sheshield/features/contacts/presentation/widgets/contact_tile.dart';
import 'package:sheshield/features/contacts/presentation/widgets/invite_contact_dialog.dart';

/// Loading / error / empty / data states of the contacts list.
class TrustedContactsList extends ConsumerWidget {
  const TrustedContactsList({super.key, required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsState = ref.watch(trustedContactsControllerProvider);

    return contactsState.when(
      loading: () => const _CenteredPadding(child: CircularProgressIndicator()),
      error: (error, _) => _CenteredPadding(
        child: Text(
          describeErrorForUser(error),
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.textSecondary),
        ),
      ),
      data: (contacts) => contacts.isEmpty
          ? _CenteredPadding(
              child: Text(
                'No trusted contacts yet.\nTap "Add Contact" to add your first one.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: palette.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : Column(
              children: [
                for (final contact in contacts)
                  ContactTile(
                    contact: contact,
                    onDelete: () => _removeContact(context, ref, contact),
                    onInvite: () => showInviteContactDialog(context, contact),
                  ),
              ],
            ),
    );
  }

  Future<void> _removeContact(
    BuildContext context,
    WidgetRef ref,
    TrustedContact contact,
  ) async {
    try {
      await ref
          .read(trustedContactsControllerProvider.notifier)
          .removeContact(contact.id);
    } on AppFailure catch (failure) {
      if (context.mounted) context.showMessage(failure.message);
    }
  }
}

class _CenteredPadding extends StatelessWidget {
  const _CenteredPadding({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Padding(padding: const EdgeInsets.only(top: 40), child: Center(child: child));
}
