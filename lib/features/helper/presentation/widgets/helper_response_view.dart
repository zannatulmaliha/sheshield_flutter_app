import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sheshield/core/hooks/use_async_action.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_response_provider.dart';
import 'package:sheshield/features/helper/presentation/widgets/response_action_row.dart';
import 'package:sheshield/features/helper/presentation/widgets/response_banner.dart';
import 'package:sheshield/features/helper/presentation/widgets/response_confirmations.dart';
import 'package:sheshield/features/helper/presentation/widgets/response_header_card.dart';
import 'package:sheshield/features/helper/presentation/widgets/response_map_card.dart';
import 'package:sheshield/features/helper/presentation/widgets/response_stage_panel.dart';
import 'package:sheshield/features/helper/presentation/widgets/safety_reminders_card.dart';
import 'package:sheshield/features/report/presentation/widgets/report_user_sheet.dart';

/// Everything a helper needs once they hold an alert: live map, safety
/// banners, stage tracking, navigation, 999, in-app chat, "mark resolved",
/// back out and report. All state lives in [helperResponseControllerProvider];
/// this widget only lays it out and forwards taps.
class HelperResponseView extends HookConsumerWidget {
  const HelperResponseView({
    super.key,
    required this.alert,
    this.initialStage = ResponseStage.none,
    required this.onEnded,
  });

  final AcceptedAlert alert;
  final ResponseStage initialStage;

  /// Called once when the response is over (resolved / released / revoked).
  final VoidCallback onEnded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final controllerProvider = helperResponseControllerProvider(alert.id, initialStage);
    final response = ref.watch(controllerProvider);
    final controller = ref.read(controllerProvider.notifier);
    final action = useAsyncAction();

    ref.listen(controllerProvider.select((state) => state.ended), (_, ended) {
      if (ended == null) return;
      final message = ended.userMessage;
      if (message != null) context.showMessage(message);
      onEnded();
    });

    Future<void> runAction(Future<void> Function() task) =>
        action.run(task, onFailure: context.showMessage);

    Future<void> resolve() async {
      if (await confirmResolveAlert(context)) await runAction(controller.resolve);
    }

    Future<void> backOut() async {
      if (await confirmBackOutOfAlert(context)) await runAction(controller.backOut);
    }

    final live = response.live;
    final point = LatLng(
      live?.latitude ?? alert.latitude,
      live?.longitude ?? alert.longitude,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
      children: [
        if (live?.duressActive ?? false)
          const ResponseBanner(
            icon: Icons.warning_amber_rounded,
            text: 'A duress signal was triggered on this SOS. Treat this as an active '
                "emergency and call 999 if you can't reach them.",
            color: AppTheme.accentRed,
          ),
        if (live?.connectivityLost ?? false)
          ResponseBanner(
            icon: Icons.signal_cellular_connected_no_internet_0_bar_rounded,
            text: "This person's location hasn't updated in a while. "
                'Their connection may be lost.',
            color: Colors.orange.shade800,
          ),
        ResponseHeaderCard(alert: alert, stage: response.stage, palette: palette),
        const SizedBox(height: 12),
        ResponseMapCard(point: point, liveState: live, palette: palette),
        const SizedBox(height: 12),
        ResponseActionRow(alertId: alert.id, point: point, palette: palette),
        const SizedBox(height: 12),
        SafetyRemindersCard(palette: palette),
        const SizedBox(height: 12),
        ResponseStagePanel(
          currentStage: response.stage,
          isBusy: action.isRunning,
          palette: palette,
          onStageSelected: (stage) => runAction(() => controller.setStage(stage)),
          onResolve: resolve,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: action.isRunning ? null : backOut,
              icon: const Icon(Icons.undo_rounded, size: 18),
              label: const Text("Can't help - back out"),
              style: TextButton.styleFrom(foregroundColor: AppTheme.accentRed),
            ),
            TextButton.icon(
              onPressed: () => showReportUserSheet(
                context,
                reportedId: alert.requesterUid,
                reporterRole: 'helper',
                sosId: alert.id,
              ),
              icon: const Icon(Icons.flag_outlined, size: 18),
              label: const Text('Report'),
              style: TextButton.styleFrom(foregroundColor: palette.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}
