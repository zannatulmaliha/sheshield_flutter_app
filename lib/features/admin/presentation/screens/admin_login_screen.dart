import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/hooks/use_async_action.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_session_provider.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_scaffold.dart';

/// Entry to the moderation dashboard, reached only by long-pressing the
/// login logo. The key is the real gate (RequireAdminKey on the backend);
/// this screen collects it and shows the server's rejection clearly.
class AdminLoginScreen extends HookConsumerWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);
    final keyController = useTextEditingController();
    final signInAction = useAsyncAction();

    Future<void> submitKey() async {
      final key = keyController.text.trim();
      if (key.isEmpty) return;
      final wasAccepted = await signInAction.run(
        () => ref.read(adminSessionControllerProvider.notifier).signIn(key),
      );
      if (wasAccepted && context.mounted) const AdminQueueRoute().go(context);
    }

    return AdminScaffold(
      title: l10n.adminDashboardTitle,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.admin_panel_settings_rounded,
                size: 48, color: palette.textSecondary,),
            const SizedBox(height: 16),
            Text(
              l10n.adminKeyPrompt,
              style: TextStyle(fontSize: 14, color: palette.textSecondary),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: keyController,
              obscureText: true,
              autofocus: true,
              onSubmitted: (_) => submitKey(),
              decoration: InputDecoration(
                labelText: l10n.adminKeyFieldLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            if (signInAction.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                signInAction.errorMessage!,
                style: const TextStyle(
                  color: AppTheme.accentRed,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signInAction.isRunning ? null : submitKey,
              child: signInAction.isRunning
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(l10n.adminSignInButton),
            ),
          ],
        ),
      ),
    );
  }
}
