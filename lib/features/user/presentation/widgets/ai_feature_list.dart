import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/user/presentation/providers/ai_mode_provider.dart';
import 'package:sheshield/features/user/presentation/widgets/ai_feature_card.dart';
import 'package:sheshield/features/user/presentation/widgets/fake_call_sheet.dart';
import 'package:sheshield/features/user/presentation/widgets/route_risk_badge.dart';

/// The four AI Guardian feature cards, wired to [AiModeController].
class AiFeatureList extends ConsumerWidget {
  const AiFeatureList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final settings = ref.watch(aiModeControllerProvider.select((state) => state.settings));
    final controller = ref.read(aiModeControllerProvider.notifier);

    Future<void> toggleVoice(bool isEnabled) async {
      final problem = await controller.setVoiceEnabled(isEnabled);
      if (problem != null && context.mounted) context.showMessage(problem);
    }

    void openFakeCall() {
      if (!settings.fakeCallEnabled) {
        context.showMessage('Turn on Fake Call Generator to use this.');
        return;
      }
      showFakeCallSheet(context);
    }

    return Column(
      children: [
        AiFeatureCard(
          palette: palette,
          icon: Icons.record_voice_over_rounded,
          title: 'Voice Distress Detection',
          description:
              'Listens for spoken distress phrases like "help me" or "call the police" and '
              'auto-triggers SOS -- keeps listening with the screen off via a persistent '
              "notification (Android requires this for any background mic use, it can't be "
              'hidden). Phrase-based only -- this cannot detect a scream, since the speech '
              'recognizer never exposes raw audio, only recognized words. Works best if you '
              'allow SheShield to ignore battery optimization when asked.',
          isEnabled: settings.voiceEnabled,
          onChanged: toggleVoice,
        ),
        AiFeatureCard(
          palette: palette,
          icon: Icons.phone_in_talk_rounded,
          title: 'Fake Call Generator',
          description: 'Simulates an incoming call to help you exit uncomfortable '
              'situations. Tap this card to schedule one.',
          isEnabled: settings.fakeCallEnabled,
          onChanged: controller.setFakeCallEnabled,
          onTap: openFakeCall,
        ),
        AiFeatureCard(
          palette: palette,
          icon: Icons.alt_route_rounded,
          title: 'Route Risk Analysis',
          description: 'A simple heuristic based only on the current time of day -- '
              'late-night hours are flagged higher risk. No location or route data is used.',
          isEnabled: settings.routeRiskEnabled,
          onChanged: controller.setRouteRiskEnabled,
          footer: settings.routeRiskEnabled ? RouteRiskBadge(palette: palette) : null,
        ),
        AiFeatureCard(
          palette: palette,
          icon: Icons.timer_rounded,
          title: 'Auto Check-In',
          description: "Prompts you to confirm you're safe every 30 minutes while the app "
              "is open, and sends an SOS automatically if you don't respond. "
              'Foreground-only -- it stops if the app is closed or killed.',
          isEnabled: settings.autoCheckInEnabled,
          onChanged: controller.setAutoCheckInEnabled,
        ),
      ],
    );
  }
}
