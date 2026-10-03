import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/hooks/use_async_action.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/contacts/domain/entities/contact_invite.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/presentation/providers/contact_invite_provider.dart';

/// Lets a contact who hasn't installed SheShield link their account so
/// they get an instant alarm push (not just SMS) on the next SOS. Fetches
/// a fresh code, then offers to text it using the same direct-SIM send the
/// SOS flow uses.
Future<void> showInviteContactDialog(BuildContext context, TrustedContact contact) {
  return showDialog<void>(
    context: context,
    builder: (_) => InviteContactDialog(contact: contact),
  );
}

String _buildInviteSmsText(String code) =>
    'I added you as my emergency contact on SheShield. '
    'Install the app and enter this code to link your account: $code '
    "-- then I can alert you instantly (not just by text) if I'm ever in danger.";

class InviteContactDialog extends HookConsumerWidget {
  const InviteContactDialog({super.key, required this.contact});

  final TrustedContact contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final inviteState = ref.watch(contactInviteControllerProvider(contact.id));
    final wasSentBySms = useState(false);
    final sendAction = useAsyncAction();
    final invite = inviteState.valueOrNull;

    Future<void> sendInviteBySms(ContactInvite invite) => sendAction.run(() async {
          await ref.read(deviceSmsServiceProvider).sendToMany(
            {contact.id: '${contact.countryCode}${contact.phone}'},
            _buildInviteSmsText(invite.code),
          );
          wasSentBySms.value = true;
        });

    return AlertDialog(
      title: Text('Invite ${contact.name}'),
      content: inviteState.when(
        loading: () => const SizedBox(
          height: 60,
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => Text(
          describeErrorForUser(error),
          style: TextStyle(color: palette.sosEnd),
        ),
        data: (invite) => _InviteCodeContent(
          invite: invite,
          palette: palette,
          wasSentBySms: wasSentBySms.value,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        if (invite != null)
          TextButton(
            onPressed: () => Clipboard.setData(ClipboardData(text: invite.code)),
            child: const Text('Copy code'),
          ),
        if (invite != null && !wasSentBySms.value)
          FilledButton(
            onPressed: sendAction.isRunning ? null : () => sendInviteBySms(invite),
            child: const Text('Send via SMS'),
          ),
      ],
    );
  }
}

class _InviteCodeContent extends StatelessWidget {
  const _InviteCodeContent({
    required this.invite,
    required this.palette,
    required this.wasSentBySms,
  });

  final ContactInvite invite;
  final AppPalette palette;
  final bool wasSentBySms;

  @override
  Widget build(BuildContext context) {
    final expiryText = invite.expiresAt.toLocal().toString().split('.').first;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ask them to install SheShield, sign up, then enter this code:'),
        const SizedBox(height: 16),
        Center(
          child: Text(
            invite.code,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Expires $expiryText',
          style: TextStyle(color: palette.textSecondary, fontSize: 12),
        ),
        if (wasSentBySms) ...[
          const SizedBox(height: 12),
          Text(
            'Sent via SMS.',
            style: TextStyle(color: palette.success, fontWeight: FontWeight.w700),
          ),
        ],
      ],
    );
  }
}
