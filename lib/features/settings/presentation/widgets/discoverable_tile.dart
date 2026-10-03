import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/hooks/use_async_action.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';

/// Requester side of the §10 mutual-connection double opt-in. Off by
/// default; the switch shows a spinner while the server confirms.
class DiscoverableTile extends HookConsumerWidget {
  const DiscoverableTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final isDiscoverable =
        ref.watch(authStateProvider).valueOrNull?.discoverableViaMutualConnections ??
            false;
    final changeAction = useAsyncAction();
    final accent = isDiscoverable ? palette.success : palette.textSecondary;

    Future<void> change(bool value) async {
      final failureMessage = await ref
          .read(authControllerProvider.notifier)
          .setDiscoverable(value);
      if (failureMessage != null && context.mounted) context.showMessage(failureMessage);
    }

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.people_alt_rounded, size: 19, color: accent),
        ),
        title: Text(
          'Discoverable via mutual connections',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13.5,
            color: palette.textPrimary,
          ),
        ),
        trailing: changeAction.isRunning
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Switch(
                value: isDiscoverable,
                onChanged: (value) => changeAction.run(() => change(value)),
              ),
      ),
    );
  }
}
