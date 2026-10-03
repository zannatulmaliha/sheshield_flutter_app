import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/presentation/widgets/contact_action_button.dart';
import 'package:sheshield/features/contacts/presentation/widgets/contact_avatar.dart';
import 'package:sheshield/features/contacts/presentation/widgets/contact_details.dart';
import 'package:sheshield/features/contacts/presentation/widgets/remove_contact_confirmation.dart';
import 'package:url_launcher/url_launcher.dart';

/// One swipe-to-remove row in the trusted-contacts list.
class ContactTile extends ConsumerWidget {
  const ContactTile({
    super.key,
    required this.contact,
    required this.onDelete,
    required this.onInvite,
  });

  final TrustedContact contact;
  final VoidCallback onDelete;

  /// Only shown while the contact has no linked account (see
  /// [TrustedContact.hasAppLinked]).
  final VoidCallback onInvite;

  String get _dialNumber => '${contact.countryCode}${contact.phone}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);

    return Dismissible(
      key: ValueKey(contact.id),
      direction: DismissDirection.endToStart,
      background: _SwipeToRemoveBackground(palette: palette),
      confirmDismiss: (_) =>
          confirmContactRemoval(context, contact: contact, palette: palette),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(22),
          boxShadow: softShadow(opacity: 0.07),
        ),
        child: Row(
          children: [
            ContactAvatar(contact: contact, palette: palette),
            const SizedBox(width: 14),
            Expanded(child: ContactDetails(contact: contact, palette: palette)),
            if (!contact.hasAppLinked) ...[
              ContactActionButton(
                icon: Icons.person_add_alt_1_rounded,
                color: palette.warning,
                onTap: onInvite,
              ),
              const SizedBox(width: 8),
            ],
            ContactActionButton(
              icon: Icons.call_rounded,
              color: palette.success,
              onTap: () => launchUrl(Uri.parse('tel:$_dialNumber')),
            ),
            const SizedBox(width: 8),
            ContactActionButton(
              icon: Icons.message_rounded,
              color: palette.primary,
              onTap: () => launchUrl(Uri.parse('sms:$_dialNumber')),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwipeToRemoveBackground extends StatelessWidget {
  const _SwipeToRemoveBackground({required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: palette.sosEnd.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Icon(Icons.delete_outline_rounded, color: palette.sosEnd),
    );
  }
}
