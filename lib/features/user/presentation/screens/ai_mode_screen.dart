import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/shared/widgets/staggered_fade_in.dart';

class AiModeScreen extends ConsumerStatefulWidget {
  const AiModeScreen({super.key});

  @override
  ConsumerState<AiModeScreen> createState() => _AiModeScreenState();
}

class _AiFeature {
  _AiFeature(this.icon, this.title, this.description, this.enabled);
  final IconData icon;
  final String title;
  final String description;
  bool enabled;
}

class _AiModeScreenState extends ConsumerState<AiModeScreen> {
  final List<_AiFeature> _features = [
    _AiFeature(
      Icons.record_voice_over_rounded,
      'Voice Distress Detection',
      'Listens for screams or distress phrases and auto-triggers SOS.',
      true,
    ),
    _AiFeature(
      Icons.phone_in_talk_rounded,
      'Fake Call Generator',
      'Simulates an incoming call to help you exit uncomfortable situations.',
      true,
    ),
    _AiFeature(
      Icons.alt_route_rounded,
      'Route Risk Analysis',
      'Analyzes your route in real time and warns about poorly-lit or risky areas.',
      false,
    ),
    _AiFeature(
      Icons.timer_rounded,
      'Auto Check-In',
      'Prompts you to confirm you\'re safe every 30 minutes during travel.',
      true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
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
                style: TextStyle(color: colors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              _SafetyScoreCard(colors: colors),
              const SizedBox(height: 26),
              Text('Active Features', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 14),
              ..._features.map(
                (f) => _FeatureCard(
                  colors: colors,
                  feature: f,
                  onChanged: (v) => setState(() => f.enabled = v),
                ),
              ),
              const SizedBox(height: 8),
              _AskAiBar(colors: colors),
            ],
          ),
        ],
      ),
    );
  }
}

class _SafetyScoreCard extends StatelessWidget {
  const _SafetyScoreCard({required this.colors});
  final AppPalette colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors.aiGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: softShadow(color: const Color(0xFF3F5EFB), opacity: 0.28),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 74,
            height: 74,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  width: 74,
                  height: 74,
                  child: CircularProgressIndicator(
                    value: 0.86,
                    strokeWidth: 6,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                const Text(
                  '86',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Safety Score',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                ),
                SizedBox(height: 6),
                Text(
                  'Great! Your safety habits and surroundings look secure right now.',
                  style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.colors, required this.feature, required this.onChanged});
  final AppPalette colors;
  final _AiFeature feature;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (feature.enabled ? colors.primary : colors.textSecondary).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              feature.icon,
              color: feature.enabled ? colors.primary : colors.textSecondary,
              size: 21,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: colors.textPrimary),
                ),
                const SizedBox(height: 3),
                Text(
                  feature.description,
                  style: TextStyle(color: colors.textSecondary, fontSize: 11.5, height: 1.35, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: feature.enabled,
            activeThumbColor: Colors.white,
            activeTrackColor: colors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _AskAiBar extends StatelessWidget {
  const _AskAiBar({required this.colors});
  final AppPalette colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_awesome_rounded, color: colors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Ask AI Guardian anything...',
              style: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Listening...')),
              );
            },
            icon: Icon(Icons.mic_rounded, color: colors.primary),
          ),
        ],
      ),
    );
  }
}
