import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../services/auth_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/auth/auth_text_field.dart';

// Each function returns true if the change was saved. These mirror the
// server's rules so most mistakes are caught instantly; the server still has
// the final say (and its message is shown if it disagrees).

Future<bool> showEditNameSheet(BuildContext context, AuthController controller) =>
    _show(context, _EditNameSheet(controller: controller));

Future<bool> showEditPhoneSheet(BuildContext context, AuthController controller) =>
    _show(context, _EditPhoneSheet(controller: controller));

Future<bool> showEditAddressSheet(BuildContext context, AuthController controller) =>
    _show(context, _EditAddressSheet(controller: controller));

Future<bool> _show(BuildContext context, Widget sheet) async {
  final saved = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => sheet,
  );
  return saved == true;
}

String? _validateName(String? v) {
  final name = (v ?? '').trim();
  if (name.isEmpty) return 'Enter your name';
  if (name.runes.length > 60) return 'Name is too long (60 max)';
  return null;
}

String? _validateCode(String? v) =>
    RegExp(r'^\+[0-9]{1,4}$').hasMatch((v ?? '').trim()) ? null : 'e.g. +880';

String? _validatePhone(String? v) {
  final digits = (v ?? '').replaceAll(RegExp(r'[\s\-()]'), '');
  return RegExp(r'^[0-9]{6,15}$').hasMatch(digits) ? null : 'Enter a valid number';
}

String? _validateAddress(String? v) =>
    (v ?? '').trim().runes.length > 200 ? 'Address is too long (200 max)' : null;

/// Shared layout: title, fields, an inline error, and the Save button.
class _SheetFrame extends StatelessWidget {
  const _SheetFrame({
    required this.title,
    required this.subtitle,
    required this.formKey,
    required this.children,
    required this.error,
    required this.saving,
    required this.onSave,
  });

  final String title;
  final String subtitle;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final String? error;
  final bool saving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Lifts the sheet above the keyboard.
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 18),
              ...children,
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    error!,
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
                  onPressed: saving ? null : onSave,
                  child: saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                        )
                      : const Text('Save', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Runs a save and closes the sheet appropriately. Returns the error to show,
/// or null if the sheet was closed.
Future<String?> _saveAndClose(
  BuildContext context,
  AuthController controller,
  Future<String?> Function() save,
) async {
  final error = await save();
  if (!context.mounted) return null;

  // An expired login signs the user out. The sheet sits above the app's
  // home route, so it must be removed or it would linger over the login screen.
  if (controller.status != AuthStatus.signedIn) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return null;
  }
  if (error == null) {
    Navigator.of(context).pop(true);
    return null;
  }
  return error;
}

class _EditNameSheet extends StatefulWidget {
  const _EditNameSheet({required this.controller});
  final AuthController controller;

  @override
  State<_EditNameSheet> createState() => _EditNameSheetState();
}

class _EditNameSheetState extends State<_EditNameSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.controller.currentUser?.name ?? '');
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    final error = await _saveAndClose(
      context,
      widget.controller,
      () => widget.controller.updateProfile(name: _name.text.trim()),
    );
    if (!mounted || error == null) return;
    setState(() {
      _saving = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      title: 'Your name',
      subtitle: 'This is the name your contacts and helpers will see.',
      formKey: _formKey,
      error: _error,
      saving: _saving,
      onSave: _save,
      children: [
        AuthTextField(controller: _name, label: 'Full name', validator: _validateName),
      ],
    );
  }
}

class _EditPhoneSheet extends StatefulWidget {
  const _EditPhoneSheet({required this.controller});
  final AuthController controller;

  @override
  State<_EditPhoneSheet> createState() => _EditPhoneSheetState();
}

class _EditPhoneSheetState extends State<_EditPhoneSheet> {
  final _formKey = GlobalKey<FormState>();
  late final AppUser? _user = widget.controller.currentUser;
  late final _code = TextEditingController(
    text: (_user?.countryCode.isNotEmpty ?? false) ? _user!.countryCode : '+880',
  );
  late final _phone = TextEditingController(text: _user?.phone ?? '');
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    final error = await _saveAndClose(
      context,
      widget.controller,
      () => widget.controller.updateProfile(
        countryCode: _code.text.trim(),
        phone: _phone.text.trim(),
      ),
    );
    if (!mounted || error == null) return;
    setState(() {
      _saving = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      title: 'Phone number',
      subtitle: 'Used for your account. Contacts are saved separately.',
      formKey: _formKey,
      error: _error,
      saving: _saving,
      onSave: _save,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              child: AuthTextField(
                controller: _code,
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
      ],
    );
  }
}

class _EditAddressSheet extends StatefulWidget {
  const _EditAddressSheet({required this.controller});
  final AuthController controller;

  @override
  State<_EditAddressSheet> createState() => _EditAddressSheetState();
}

class _EditAddressSheetState extends State<_EditAddressSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _address = TextEditingController(text: widget.controller.currentUser?.address ?? '');
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    final error = await _saveAndClose(
      context,
      widget.controller,
      () => widget.controller.updateProfile(address: _address.text.trim()),
    );
    if (!mounted || error == null) return;
    setState(() {
      _saving = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      title: 'Home address',
      subtitle: 'Optional. Leave it empty to remove it.',
      formKey: _formKey,
      error: _error,
      saving: _saving,
      onSave: _save,
      children: [
        AuthTextField(
          controller: _address,
          label: 'Street, area, city',
          validator: _validateAddress,
          maxLines: 3,
          minLines: 2,
        ),
      ],
    );
  }
}
