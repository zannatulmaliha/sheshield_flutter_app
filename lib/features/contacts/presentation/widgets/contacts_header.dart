import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/contacts/presentation/widgets/accept_invite_dialog.dart';

class ContactsHeader extends StatelessWidget {
  const ContactsHeader({super.key, required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trusted Contacts',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
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
            color: palette.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
