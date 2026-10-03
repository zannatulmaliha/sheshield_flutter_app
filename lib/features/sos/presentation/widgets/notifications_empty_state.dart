import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';

class NotificationsEmptyState extends StatelessWidget {
  const NotificationsEmptyState({super.key, required this.palette, required this.l10n});

  final AppPalette palette;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 100),
      children: [
        Icon(
          Icons.notifications_none_rounded,
          size: 56,
          color: palette.textSecondary.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.noNotificationsYetTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: palette.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.noNotificationsYetBody,
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.textSecondary, fontSize: 13),
        ),
      ],
    );
  }
}
