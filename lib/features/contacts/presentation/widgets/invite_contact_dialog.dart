import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/contacts/domain/entities/contact_invite.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/domain/repositories/i_contacts_repository.dart';
import 'package:sheshield/features/contacts/domain/usecases/invite_contact_usecase.dart';

/// Lets a contact who hasn't installed SheShield yet link their own
/// account, so they get an instant alarm push (not just SMS) on the
/// next SOS. Fetches a fresh code from the server, then offers to text
/// it straight to that contact using the same direct-SIM send the SOS
/// flow itself uses -- no separate share sheet needed.
Future<void> showInviteContactDialog(BuildContext context, TrustedContact contact) {
  return showDialog<void>(
    context: context,
    builder: (_) => _InviteContactDialog(contact: contact),
  );
}

class _InviteContactDialog extends ConsumerStatefulWidget {
  const _InviteContactDialog({required this.contact});
  final TrustedContact contact;

  @override
  ConsumerState<_InviteContactDialog> createState() => _InviteContactDialogState();
}

class _InviteContactDialogState extends ConsumerState<_InviteContactDialog> {
  ContactInvite? _invite;
  String? _error;
  bool _sent = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final invite = await getIt<InviteContactUseCase>().call(widget.contact.id);
      if (mounted) setState(() => _invite = invite);
    } on ContactsFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    }
  }

  Future<void> _sendViaSms() async {
    final invite = _invite;
    if (invite == null) return;
    final number = '${widget.contact.countryCode}${widget.contact.phone}';
    final message = 'I added you as my emergency contact on SheShield. '
        'Install the app and enter this code to link your account: ${invite.code} '
        '-- then I can alert you instantly (not just by text) if I\'m ever in danger.';
    await getIt<DeviceSmsService>().sendToMany({widget.contact.id: number}, message);
    if (mounted) setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    return AlertDialog(
      title: Text('Invite ${widget.contact.name}'),
      content: _buildContent(colors),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        if (_invite != null)
          TextButton(
            onPressed: () => Clipboard.setData(ClipboardData(text: _invite!.code)),
            child: const Text('Copy code'),
          ),
        if (_invite != null && !_sent)
          FilledButton(onPressed: _sendViaSms, child: const Text('Send via SMS')),
      ],
    );
  }

  Widget _buildContent(AppPalette colors) {
    if (_error != null) {
      return Text(_error!, style: TextStyle(color: colors.sosEnd));
    }
    final invite = _invite;
    if (invite == null) {
      return const SizedBox(height: 60, child: Center(child: CircularProgressIndicator()));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ask them to install SheShield, sign up, then enter this code:',
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            invite.code,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 4),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Expires ${invite.expiresAt.toLocal().toString().split('.').first}',
          style: TextStyle(color: colors.textSecondary, fontSize: 12),
        ),
        if (_sent) ...[
          const SizedBox(height: 12),
          Text('Sent via SMS.', style: TextStyle(color: colors.success, fontWeight: FontWeight.w700)),
        ],
      ],
    );
  }
}
