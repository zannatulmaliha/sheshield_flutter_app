import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import '../../domain/entities/trusted_contact.dart';

/// One row in the trusted-contacts list. The backend has no "color"
/// or "primary" field for a contact, so [_avatarColor] derives a
/// stable color from the contact's id instead of storing one.
class ContactTile extends StatelessWidget {
  const ContactTile({super.key, required this.contact, required this.onDelete, required this.onInvite});

  final TrustedContact contact;
  final VoidCallback onDelete;

  /// Only called when the contact hasn't linked their own account yet
  /// (see [TrustedContact.hasAppLinked]) -- shows the invite flow that
  /// lets them receive an alarm push, not just SMS, on the next SOS.
  final VoidCallback onInvite;

  Color get _avatarColor {
    const palette = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.success,
      AppColors.warning,
      AppColors.primaryDark,
    ];
    return palette[contact.id.hashCode.abs() % palette.length];
  }

  Future<void> _call() => launchUrl(Uri.parse('tel:${contact.countryCode}${contact.phone}'));

  Future<void> _message() => launchUrl(Uri.parse('sms:${contact.countryCode}${contact.phone}'));

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(contact.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 22),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: AppColors.sosEnd.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: AppColors.sosEnd),
      ),
      confirmDismiss: (_) => showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Remove contact?'),
          content: Text('${contact.name} will no longer receive your SOS alerts.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Remove', style: TextStyle(color: AppColors.sosEnd)),
            ),
          ],
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: softShadow(opacity: 0.07),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: _avatarColor,
              child: Text(
                contact.initials,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textPrimary),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${contact.relation.isEmpty ? "Contact" : contact.relation} · ${contact.fullPhone}',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (contact.hasAppLinked) ...[
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.notifications_active_rounded, color: AppColors.success, size: 13),
                        SizedBox(width: 4),
                        Text(
                          'Gets an instant alarm on SOS',
                          style: TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            if (!contact.hasAppLinked) ...[
              _CircleIconButton(icon: Icons.person_add_alt_1_rounded, color: AppColors.warning, onTap: onInvite),
              const SizedBox(width: 8),
            ],
            _CircleIconButton(icon: Icons.call_rounded, color: AppColors.success, onTap: _call),
            const SizedBox(width: 8),
            _CircleIconButton(icon: Icons.message_rounded, color: AppColors.primary, onTap: _message),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.color, required this.onTap});
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(19),
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}