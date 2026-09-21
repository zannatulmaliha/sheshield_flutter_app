import 'package:flutter/material.dart';
import '../models/saved_contact.dart';
import '../services/contact_service.dart';
import '../services/contacts_store.dart';
import '../theme/app_theme.dart';
import '../widgets/auth/auth_text_field.dart';

/// Same look as ContactsScreen, but the contacts live on the backend and
/// belong to the signed-in account. Kept as a separate file so your original
/// contacts_screen.dart isn't modified.
class AuthContactsScreen extends StatelessWidget {
  const AuthContactsScreen({super.key, required this.store});

  final ContactsStore store;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) => _ContactsView(store: store),
    );
  }
}

class _ContactsView extends StatelessWidget {
  const _ContactsView({required this.store});

  final ContactsStore store;

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openAddSheet(BuildContext context) async {
    final added = await showModalBottomSheet<SavedContact>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => _AddContactSheet(store: store),
    );
    if (added != null && context.mounted) {
      _snack(context, '${added.name} added');
    }
  }

  Future<void> _confirmDelete(BuildContext context, SavedContact contact) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove contact?'),
        content: Text('${contact.name} will no longer be notified when you send an SOS alert.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remove', style: TextStyle(color: AppColors.sosEnd)),
          ),
        ],
      ),
    );
    if (ok != true) return;

    try {
      await store.remove(contact.id);
    } on ContactException catch (e) {
      // An expired login is already handled by the store (back to login).
      if (!e.unauthorized && context.mounted) _snack(context, e.message);
    } catch (_) {
      if (context.mounted) _snack(context, 'Something went wrong. Please try again.');
    }
  }

  Widget _body(BuildContext context) {
    if (store.loading) {
      return const Padding(
        padding: EdgeInsets.only(top: 80),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (store.error != null && store.contacts.isEmpty) {
      return _MessageBox(
        icon: Icons.cloud_off_rounded,
        message: store.error!,
        actionLabel: 'Try again',
        onAction: () => store.refresh(showSpinner: true),
      );
    }
    if (store.contacts.isEmpty) {
      return const _MessageBox(
        icon: Icons.group_add_rounded,
        message: 'No trusted contacts yet.\nTap "Add Contact" to choose who should be notified in an emergency.',
      );
    }
    return Column(
      children: [
        for (final c in store.contacts)
          _ContactTile(contact: c, onDelete: () => _confirmDelete(context, c)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final showHint = !store.loading && store.error == null && store.contacts.length < 3;

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => store.refresh(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
              children: [
                Text('Trusted Contacts', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 4),
                const Text(
                  'These people will be notified when you send an SOS alert.',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                if (showHint) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.chipBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Add at least 3 contacts for reliable emergency coverage.',
                            style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w600, fontSize: 12.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                _body(context),
              ],
            ),
          ),
          Positioned(
            right: 4,
            bottom: 140,
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () => _openAddSheet(context),
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('Add Contact', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.contact, required this.onDelete});
  final SavedContact contact;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(14, 14, 6, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: contact.color,
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
                  contact.subtitle,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Remove',
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline_rounded, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _MessageBox extends StatelessWidget {
  const _MessageBox({required this.icon, required this.message, this.actionLabel, this.onAction});
  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        children: [
          Icon(icon, size: 44, color: AppColors.textSecondary),
          const SizedBox(height: 14),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 13.5, height: 1.4),
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: 14),
            OutlinedButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    );
  }
}

class _AddContactSheet extends StatefulWidget {
  const _AddContactSheet({required this.store});

  final ContactsStore store;

  @override
  State<_AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<_AddContactSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _relation = TextEditingController();
  final _countryCode = TextEditingController(text: '+880');
  final _phone = TextEditingController();

  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _relation.dispose();
    _countryCode.dispose();
    _phone.dispose();
    super.dispose();
  }

  // These mirror the server's rules so most mistakes are caught instantly;
  // the server still has the final say.
  String? _validateName(String? v) => (v == null || v.trim().isEmpty) ? 'Enter a name' : null;

  String? _validateCode(String? v) =>
      RegExp(r'^\+[0-9]{1,4}$').hasMatch((v ?? '').trim()) ? null : 'e.g. +880';

  String? _validatePhone(String? v) {
    final digits = (v ?? '').replaceAll(RegExp(r'[\s\-()]'), '');
    return RegExp(r'^[0-9]{6,15}$').hasMatch(digits) ? null : 'Enter a valid number';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final contact = await widget.store.add(
        name: _name.text.trim(),
        relation: _relation.text.trim(),
        phone: _phone.text.trim(),
        countryCode: _countryCode.text.trim(),
      );
      if (mounted) Navigator.of(context).pop(contact);
    } on ContactException catch (e) {
      if (!mounted) return;
      if (e.unauthorized) {
        // The store already sent the user back to login.
        Navigator.of(context).pop();
        return;
      }
      setState(() {
        _saving = false;
        _error = e.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = 'Something went wrong. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Lifts the sheet above the keyboard.
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add trusted contact', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              const Text(
                "They'll be notified when you send an SOS alert.",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 18),
              AuthTextField(controller: _name, label: 'Full name', validator: _validateName),
              AuthTextField(controller: _relation, label: 'Relation (optional, e.g. Mother)'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90,
                    child: AuthTextField(
                      controller: _countryCode,
                      label: 'Code',
                      keyboardType: TextInputType.phone,
                      validator: _validateCode,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AuthTextField(
                      controller: _phone,
                      label: 'Phone number',
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                    ),
                  ),
                ],
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: AppColors.sosEnd, fontWeight: FontWeight.w700, fontSize: 12.5),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: _saving ? null : _submit,
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                        )
                      : const Text('Save Contact', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
