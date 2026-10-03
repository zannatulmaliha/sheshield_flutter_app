import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/routes/sos_routes.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/user/presentation/widgets/checkin_sheet.dart';
import 'package:sheshield/features/user/presentation/widgets/fake_call_sheet.dart';
import 'package:sheshield/features/user/presentation/widgets/quick_action.dart';
import 'package:sheshield/features/user/presentation/widgets/record_evidence_sheet.dart';
import 'package:sheshield/features/user/presentation/widgets/safe_route_sheet.dart';
import 'package:sheshield/features/user/presentation/widgets/share_location_flow.dart';

class QuickActionsGrid extends ConsumerWidget {
  const QuickActionsGrid({super.key});

  Future<void> _run(QuickAction action, BuildContext context, WidgetRef ref) =>
      switch (action) {
        QuickAction.fakeCall => showFakeCallSheet(context),
        QuickAction.shareLocation => runShareLocationFlow(context, ref),
        QuickAction.recordEvidence => showRecordEvidenceSheet(context),
        QuickAction.safeRoute => showSafeRouteSheet(context),
        QuickAction.checkInTimer => showCheckInSheet(context),
        QuickAction.dangerZone => const DangerZoneRoute().push(context),
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 2.5,
      children: [
        for (final action in QuickAction.values)
          _QuickActionTile(
            action: action,
            label: action.label(l10n),
            palette: palette,
            onTap: () => _run(action, context, ref),
          ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.action,
    required this.label,
    required this.palette,
    required this.onTap,
  });

  final QuickAction action;
  final String label;
  final AppPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: softShadow(opacity: 0.08),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: action.color.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(action.icon, color: action.color, size: 19),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  color: palette.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
