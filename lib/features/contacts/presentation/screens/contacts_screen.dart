import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/presentation/screens/add_contact_sheet.dart';
import 'package:sheshield/shared/widgets/staggered_fade_in.dart';
import '../../domain/entities/trusted_contact.dart';
import '../providers/contacts_provider.dart';
import '../widgets/accept_invite_dialog.dart';
import '../widgets/contact_tile.dart';
import '../widgets/invite_contact_dialog.dart';

/// Real trusted-contacts screen, backed by [contactsControllerProvider]
/// (GET/POST/DELETE /api/v1/contacts). Replaces the old static
/// `demoContacts` screen in features/user/.
class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  Future<void> _remove(BuildContext context, WidgetRef ref, String id) async {
    final error =
        await ref.read(contactsControllerProvider.notifier).remove(id);
    if (error != null && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }
  }

  void _invite(BuildContext context, TrustedContact contact) {
    showInviteContactDialog(context, contact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final contactsAsync = ref.watch(contactsControllerProvider);

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => ref.refresh(contactsControllerProvider.future),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
              children: [
                StaggeredFadeIn(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trusted Contacts',
                          style: Theme.of(context).textTheme.headlineSmall),
                      TextButton(
                        onPressed: () => showAcceptInviteDialog(context),
                        child: const Text('Have a code?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'These people will be notified when you send an SOS alert.',
                    style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.chipBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline_rounded,
                            color: colors.primary, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Add at least 3 contacts for reliable emergency coverage.',
                            style: TextStyle(
                                color: colors.primaryDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  contactsAsync.when(
                    loading: () => const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (err, _) => Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          err is Exception
                              ? err.toString()
                              : 'Could not load contacts.',
                          style: TextStyle(color: colors.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    data: (contacts) => contacts.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Text(
                                'No trusted contacts yet.\nTap "Add Contact" to add your first one.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: colors.textSecondary,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Column(
                            children: contacts
                                .map((c) => ContactTile(
                                      contact: c,
                                      onDelete: () =>
                                          _remove(context, ref, c.id),
                                      onInvite: () => _invite(context, c),
                                    ))
                                .toList(),
                          ),
                  ),
                ]),
              ],
            ),
          ),
          Positioned(
            right: 4,
            bottom: 140,
            child: FloatingActionButton.extended(
              onPressed: () => showAddContactSheet(context, ref),
              backgroundColor: colors.primary,
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('Add Contact',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
