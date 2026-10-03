import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/sos/presentation/providers/danger_zone_provider.dart';
import 'package:sheshield/features/sos/presentation/widgets/danger_zone_legend.dart';
import 'package:sheshield/features/sos/presentation/widgets/danger_zone_map.dart';

/// The home screen's "Danger Zone" quick action: a heat map of past-alert
/// density around the signed-in person's current position.
class DangerZoneScreen extends ConsumerWidget {
  const DangerZoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        title: Text(l10n.dangerZone),
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(dangerZoneControllerProvider.notifier).refresh(),
        child: ref.watch(dangerZoneControllerProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ListView(
                padding: const EdgeInsets.only(top: 80),
                children: [Center(child: Text(describeErrorForUser(error)))],
              ),
              data: (data) {
                final (center, zones) = data;
                return Column(
                  children: [
                    Expanded(
                      child: DangerZoneMap(center: center, zones: zones, palette: palette),
                    ),
                    DangerZoneLegend(palette: palette, l10n: l10n),
                  ],
                );
              },
            ),
      ),
    );
  }
}
