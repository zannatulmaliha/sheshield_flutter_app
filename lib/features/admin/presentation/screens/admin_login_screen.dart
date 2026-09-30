import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import '../providers/admin_session_provider.dart';

/// Entry point for the moderation dashboard. Reached only via a long-press
/// on the main login screen's logo (see login_screen.dart) -- deliberately
/// not a visible, discoverable link. The key itself is the real gate
/// (RequireAdminKey on the backend); this screen just collects it and
/// shows a clear error if the server rejects it, rather than silently
/// storing a key that doesn't work.
class AdminLoginScreen extends ConsumerStatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {
  final _controller = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final key = _controller.text.trim();
    if (key.isEmpty) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    final error =
        await ref.read(adminSessionControllerProvider.notifier).signIn(key);
    if (!mounted) return;
    setState(() => _submitting = false);
    if (error == null) {
      const AdminQueueRoute().go(context);
    } else {
      setState(() => _error = error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.adminDashboardTitle),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.admin_panel_settings_rounded,
                size: 48, color: colors.textSecondary),
            const SizedBox(height: 16),
            Text(
              l10n.adminKeyPrompt,
              style: TextStyle(fontSize: 14, color: colors.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              obscureText: true,
              autofocus: true,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: l10n.adminKeyFieldLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!,
                  style: const TextStyle(
                      color: AppTheme.accentRed, fontWeight: FontWeight.w600)),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(l10n.adminSignInButton),
            ),
          ],
        ),
      ),
    );
  }
}
