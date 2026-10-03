import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';

/// Name, relation + phone, and the "instant alarm" badge for one contact.
class ContactDetails extends StatelessWidget {
  const ContactDetails({super.key, required this.contact, required this.palette});

  final TrustedContact contact;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    final relationLabel = contact.relation.isEmpty ? 'Contact' : contact.relation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contact.name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14.5,
            color: palette.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$relationLabel · ${contact.fullPhone}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: palette.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (contact.hasAppLinked) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.notifications_active_rounded, color: palette.success, size: 13),
              const SizedBox(width: 4),
              Text(
                'Gets an instant alarm on SOS',
                style: TextStyle(
                  color: palette.success,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
