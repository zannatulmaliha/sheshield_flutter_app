import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/ai/presentation/screens/ai_chat_screen.dart';
import 'package:sheshield/features/user/presentation/providers/ai_mode_provider.dart';
import 'package:sheshield/features/user/presentation/widgets/ai_feature_list.dart';
import 'package:sheshield/features/user/presentation/widgets/ask_ai_bar.dart';
import 'package:sheshield/features/user/presentation/widgets/auto_check_in_dialog.dart';
import 'package:sheshield/features/user/presentation/widgets/safety_score_card.dart';
import 'package:sheshield/shared/widgets/staggered_fade_in.dart';

/// The AI Guardian tab: safety score, feature toggles, and the Ask AI bar.
/// All behaviour lives in [AiModeController]; this only lays it out and
/// shows the auto check-in prompt when the controller raises one.
class AiModeScreen extends ConsumerWidget {
  const AiModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);

    ref.listen(
      aiModeControllerProvider.select((state) => state.autoCheckInSecondsLeft),
      (previous, next) {
        if (previous == null && next != null) {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (_) => const AutoCheckInDialog(),
          );
        }
      },
    );

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
        children: [
          StaggeredFadeIn(
            children: [
              Text('AI Guardian', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Smart protection that watches out for you, quietly.',
                style: TextStyle(
                  color: palette.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const SafetyScoreCard(),
              const SizedBox(height: 26),
              Text('Active Features', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 14),
              const AiFeatureList(),
              const SizedBox(height: 8),
              AskAiBar(
                palette: palette,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const AiChatScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
