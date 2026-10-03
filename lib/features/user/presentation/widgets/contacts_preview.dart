import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/presentation/providers/trusted_contacts_provider.dart';

/// Up to three overlapping contact avatars and an "N contacts will be
/// alerted" line; tapping opens the Contacts tab.
class ContactsPreview extends ConsumerWidget {
  const ContactsPreview({super.key, required this.onTap});

  static const _avatarColors = [Color(0xFFFF8FA3), Color(0xFF7B2FF7), Color(0xFF3F5EFB)];
  static const _maxAvatars = 3;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);
    final contacts =
        ref.watch(trustedContactsControllerProvider).valueOrNull ?? const <TrustedContact>[];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(22),
          boxShadow: softShadow(opacity: 0.08),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 84,
              height: 40,
              child: Stack(
                children: [
                  for (final (index, contact) in contacts.take(_maxAvatars).indexed)
                    Positioned(
                      left: index * 24.0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: _avatarColors[index % _avatarColors.length],
                          child: Text(
                            contact.initials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                contacts.isEmpty
                    ? l10n.addContactToEnableSos
                    : l10n.contactsWillBeAlerted(contacts.length),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  color: palette.textPrimary,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: palette.textSecondary),
          ],
        ),
      ),
    );
  }
}
