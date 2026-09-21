import 'package:flutter/material.dart';
import '../models/saved_contact.dart';
import '../services/auth_controller.dart';
import '../services/contact_service.dart';
import '../theme/app_theme.dart';
import '../widgets/auth/auth_text_field.dart';

/// Same look as ContactsScreen, but the contacts live on the backend and
/// belong to the signed-in account. Kept as a separate file so your original
/// contacts_screen.dart isn't modified.
class AuthContactsScreen extends StatefulWidget {
  const AuthContactsScreen({super.key, required this.controller});

  final AuthController controller;

  @override
  State<AuthContactsScreen> createState() => _AuthContactsScreenState();
}

class _AuthContactsScreenState extends State<AuthContactsScreen> {
  final _service = ContactService();

  List<SavedContact> _contacts = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// [showSpinner] is false for pull-to-refresh, which has its own indicator.
  Future<void> _load({bool showSpinner = true}) async {
    if (showSpinner) setState(() => _loading = true);
    _error = null;
    try {
      final contacts = await _service.list();
      if (!mounted) return;
      setState(() {
        _contacts = contacts;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      if (_handledExpiredSession(e)) return;
      setState(() {
        _error = _messageFor(e);
        _loading = false;
      });
    }
  }

  /// If the token was rejected, send the user back to login instead of
  /// showing an error they can't fix.
  bool _handledExpiredSession(Object e) {
    if (e is ContactException && e.unauthorized) {
      widget.controller.logout();
      return true;
    }
    return false;
  }

  String _messageFor(Object e) =>
      e is ContactException ? e.message : 'Something went wrong. Please try again.';

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openAddSheet() async {
    final added = await showModalBottomSheet<SavedContact>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => _AddContactSheet(
        service: _service,
        onUnauthorized: widget.controller.logout,
      ),
    );
    if (added != null && mounted) {
      setState(() => _contacts = [..._contacts, added]);
      _snack('${added.name} added');
    }
  }

  Future<void> _confirmDelete(SavedContact contact) async {
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
      await _service.delete(contact.id);
      if (!mounted) return;
      setState(() => _contacts = _contacts.where((c) => c.id != contact.id).toList());
    } catch (e) {
      if (!mounted) return;
      if (_handledExpiredSession(e)) return;
      _snack(_messageFor(e));
    }
  }

  Widget _body() {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.only(top: 80),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return _MessageBox(
        icon: Icons.cloud_off_rounded,
        message: _error!,
        actionLabel: 'Try again',
        onAction: _load,
      );
    }
    if (_contacts.isEmpty) {
      return const _MessageBox(
        icon: Icons.group_add_rounded,
        message: 'No trusted contacts yet.\nTap "Add Contact" to choose who should be notified in an emergency.',
      );
    }
    return Column(
      children: [
        for (final c in _contacts) _ContactTile(contact: c, onDelete: () => _confirmDelete(c)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final showHint = !_loading && _error == null && _contacts.length < 3;

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => _load(showSpinner: false),
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
                _body(),
              ],
            ),
          ),
          Positioned(
            right: 4,
            bottom: 140,
            child: FloatingActionButton.extended(
              heroTag: null,
              onPressed: _openAddSheet,
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
  const _AddContactSheet({required this.service, required this.onUnauthorized});

  final ContactService service;
  final VoidCallback onUnauthorized;

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
      final contact = await widget.service.add(
        name: _name.text.trim(),
        relation: _relation.text.trim(),
        phone: _phone.text.trim(),
        countryCode: _countryCode.text.trim(),
      );
      if (mounted) Navigator.of(context).pop(contact);
    } on ContactException catch (e) {
      if (!mounted) return;
      if (e.unauthorized) {
        Navigator.of(context).pop();
        widget.onUnauthorized();
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
