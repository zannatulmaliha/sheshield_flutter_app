import 'package:flutter/material.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/contacts/domain/repositories/i_contacts_repository.dart';
import 'package:sheshield/features/contacts/domain/usecases/accept_contact_invite_usecase.dart';

/// The invitee's side of [showInviteContactDialog]: redeems a code someone
/// else's invite produced, linking THIS account as their trusted contact
/// so their next SOS alarms this device instead of only texting it.
Future<void> showAcceptInviteDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (_) => const _AcceptInviteDialog(),
  );
}

class _AcceptInviteDialog extends StatefulWidget {
  const _AcceptInviteDialog();

  @override
  State<_AcceptInviteDialog> createState() => _AcceptInviteDialogState();
}

class _AcceptInviteDialogState extends State<_AcceptInviteDialog> {
  final _controller = TextEditingController();
  String? _error;
  bool _loading = false;
  bool _accepted = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await getIt<AcceptContactInviteUseCase>().call(code);
      if (mounted) setState(() => _accepted = true);
    } on ContactsFailure catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_accepted) {
      return AlertDialog(
        title: const Text('Linked!'),
        content: const Text("You'll now get an instant alarm on your phone if they ever send an SOS."),
        actions: [
          FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Done')),
        ],
      );
    }
    return AlertDialog(
      title: const Text('Enter invite code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter the code someone shared with you to link your account as their trusted contact.'),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: 'e.g. AB12CD34',
              errorText: _error,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: _loading ? null : _submit,
          child: _loading
              ? const SizedBox(
                  width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Link account'),
        ),
      ],
    );
  }
}
