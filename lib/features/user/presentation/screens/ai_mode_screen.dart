import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/voice_distress_service.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/ai/presentation/screens/ai_chat_screen.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';
import 'package:sheshield/features/user/presentation/screens/fake_call_screen.dart';
import 'package:sheshield/features/verification/domain/entities/verification_status.dart';
import 'package:sheshield/features/verification/domain/usecases/get_verification_status_usecase.dart';
import 'package:sheshield/shared/widgets/staggered_fade_in.dart';

const _kVoiceEnabledKey = 'sheshield_ai_voice_distress_enabled';
const _kFakeCallEnabledKey = 'sheshield_ai_fake_call_enabled';
const _kRouteRiskEnabledKey = 'sheshield_ai_route_risk_enabled';
const _kAutoCheckInEnabledKey = 'sheshield_ai_auto_checkin_enabled';

const _kAutoCheckInInterval = Duration(minutes: 30);
const _kAutoCheckInCountdown = 60;

class AiModeScreen extends ConsumerStatefulWidget {
  const AiModeScreen({super.key});

  @override
  ConsumerState<AiModeScreen> createState() => _AiModeScreenState();
}

class _AiModeScreenState extends ConsumerState<AiModeScreen> {
  bool _voiceEnabled = true;
  bool _fakeCallEnabled = true;
  bool _routeRiskEnabled = false;
  bool _autoCheckInEnabled = true;

  Timer? _autoCheckInTimer;
  Timer? _autoCheckInDialogTicker;
  Timer? _fakeCallScheduleTimer;

  Future<_SafetyScoreData>? _scoreFuture;

  int get _enabledFeatureCount => [
        _voiceEnabled,
        _fakeCallEnabled,
        _routeRiskEnabled,
        _autoCheckInEnabled
      ].where((e) => e).length;

  @override
  void initState() {
    super.initState();
    _loadToggles();
  }

  @override
  void dispose() {
    _autoCheckInTimer?.cancel();
    _autoCheckInDialogTicker?.cancel();
    _fakeCallScheduleTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadToggles() async {
    final storage = getIt<FlutterSecureStorage>();
    final voice = await _readBool(storage, _kVoiceEnabledKey, true);
    final fakeCall = await _readBool(storage, _kFakeCallEnabledKey, true);
    final routeRisk = await _readBool(storage, _kRouteRiskEnabledKey, false);
    final autoCheckIn = await _readBool(storage, _kAutoCheckInEnabledKey, true);
    if (!mounted) return;

    setState(() {
      _voiceEnabled = voice;
      _fakeCallEnabled = fakeCall;
      _routeRiskEnabled = routeRisk;
      _autoCheckInEnabled = autoCheckIn;
    });

    // Re-arm whatever was on before the app was last closed -- this is
    // the only place that wires the toggle to the actual listener/timer,
    // so a persisted "on" needs to be replayed here on load.
    if (voice) {
      final started =
          await getIt<VoiceDistressService>().start(_sendVoiceTriggeredSos);
      if (!started && mounted) {
        setState(() => _voiceEnabled = false);
        await storage.write(key: _kVoiceEnabledKey, value: 'false');
      }
    }
    if (autoCheckIn) {
      _startAutoCheckIn();
    }
    _refreshScore();
  }

  Future<bool> _readBool(
      FlutterSecureStorage storage, String key, bool fallback) async {
    final raw = await storage.read(key: key);
    if (raw == null) return fallback;
    return raw == 'true';
  }

  Future<void> _sendVoiceTriggeredSos() =>
      ref.read(sosControllerProvider.notifier).send();

  void _refreshScore() {
    setState(() => _scoreFuture = _computeSafetyScore(_enabledFeatureCount));
  }

  Future<void> _onVoiceToggle(bool value) async {
    final storage = getIt<FlutterSecureStorage>();
    if (value) {
      final started =
          await getIt<VoiceDistressService>().start(_sendVoiceTriggeredSos);
      if (!started) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Microphone permission is needed for Voice Distress Detection.')),
          );
        }
        return;
      }
    } else {
      await getIt<VoiceDistressService>().stop();
    }
    if (!mounted) return;
    setState(() => _voiceEnabled = value);
    await storage.write(key: _kVoiceEnabledKey, value: value.toString());
    _refreshScore();
  }

  Future<void> _onFakeCallToggle(bool value) async {
    setState(() => _fakeCallEnabled = value);
    await getIt<FlutterSecureStorage>()
        .write(key: _kFakeCallEnabledKey, value: value.toString());
    _refreshScore();
  }

  Future<void> _onRouteRiskToggle(bool value) async {
    setState(() => _routeRiskEnabled = value);
    await getIt<FlutterSecureStorage>()
        .write(key: _kRouteRiskEnabledKey, value: value.toString());
    _refreshScore();
  }

  Future<void> _onAutoCheckInToggle(bool value) async {
    setState(() => _autoCheckInEnabled = value);
    await getIt<FlutterSecureStorage>()
        .write(key: _kAutoCheckInEnabledKey, value: value.toString());
    if (value) {
      _startAutoCheckIn();
    } else {
      _stopAutoCheckIn();
    }
    _refreshScore();
  }

  void _startAutoCheckIn() {
    _autoCheckInTimer?.cancel();
    _autoCheckInTimer =
        Timer.periodic(_kAutoCheckInInterval, (_) => _promptAutoCheckIn());
  }

  void _stopAutoCheckIn() {
    _autoCheckInTimer?.cancel();
    _autoCheckInTimer = null;
    _autoCheckInDialogTicker?.cancel();
  }

  /// Foreground-only, on purpose: a plain [Timer] like this (and the one
  /// backing [CheckInController]) only ever fires while the app process
  /// is alive, so a killed or fully backgrounded app will not prompt or
  /// auto-SOS. There is no WorkManager/AlarmManager-backed background
  /// service behind it yet.
  Future<void> _promptAutoCheckIn() async {
    if (!mounted) return;
    var remaining = _kAutoCheckInCountdown;
    var confirmedSafe = false;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            _autoCheckInDialogTicker ??=
                Timer.periodic(const Duration(seconds: 1), (t) {
              remaining--;
              if (remaining <= 0) {
                t.cancel();
                Navigator.of(dialogContext).pop();
              } else {
                setDialogState(() {});
              }
            });
            return AlertDialog(
              title: const Text('Are you safe?'),
              content: Text(
                "Auto Check-In: tap \"Yes, I'm safe\" within $remaining seconds, "
                'or an SOS alert will be sent automatically.',
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    confirmedSafe = true;
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text("Yes, I'm safe"),
                ),
              ],
            );
          },
        );
      },
    );

    _autoCheckInDialogTicker?.cancel();
    _autoCheckInDialogTicker = null;
    if (!confirmedSafe) {
      await ref.read(sosControllerProvider.notifier).send();
    }
  }

  void _onFakeCallCardTap() {
    if (!_fakeCallEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Turn on Fake Call Generator to use this.')),
      );
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _FakeCallDelaySheet(
        colors: resolvePalette(context, ref),
        onPicked: _scheduleFakeCall,
      ),
    );
  }

  void _scheduleFakeCall(Duration delay) {
    _fakeCallScheduleTimer?.cancel();
    if (delay == Duration.zero) {
      _pushFakeCall();
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Fake call incoming in ${delay.inSeconds}s...')),
    );
    _fakeCallScheduleTimer = Timer(delay, _pushFakeCall);
  }

  void _pushFakeCall() {
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => const FakeCallScreen(), fullscreenDialog: true),
    );
  }

  void _openAiChat() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const AiChatScreen()));
  }

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
              Text('AI Guardian',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Smart protection that watches out for you, quietly.',
                style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              _SafetyScoreCard(colors: colors, future: _scoreFuture),
              const SizedBox(height: 26),
              Text('Active Features',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 14),
              _FeatureCard(
                colors: colors,
                icon: Icons.record_voice_over_rounded,
                title: 'Voice Distress Detection',
                description:
                    "Listens for spoken distress phrases like \"help me\" or \"call the police\" and "
                    'auto-triggers SOS -- keeps listening with the screen off via a persistent '
                    "notification (Android requires this for any background mic use, it can't be "
                    'hidden). Phrase-based only -- this cannot detect a scream, since the speech '
                    "recognizer never exposes raw audio, only recognized words. Works best if you "
                    "allow SheShield to ignore battery optimization when asked.",
                enabled: _voiceEnabled,
                onChanged: _onVoiceToggle,
              ),
              _FeatureCard(
                colors: colors,
                icon: Icons.phone_in_talk_rounded,
                title: 'Fake Call Generator',
                description:
                    'Simulates an incoming call to help you exit uncomfortable situations. '
                    'Tap this card to schedule one.',
                enabled: _fakeCallEnabled,
                onChanged: _onFakeCallToggle,
                onTap: _onFakeCallCardTap,
              ),
              _FeatureCard(
                colors: colors,
                icon: Icons.alt_route_rounded,
                title: 'Route Risk Analysis',
                description:
                    'A simple heuristic based only on the current time of day -- late-night '
                    'hours are flagged higher risk. No location or route data is used.',
                enabled: _routeRiskEnabled,
                onChanged: _onRouteRiskToggle,
                trailing:
                    _routeRiskEnabled ? _RouteRiskBadge(colors: colors) : null,
              ),
              _FeatureCard(
                colors: colors,
                icon: Icons.timer_rounded,
                title: 'Auto Check-In',
                description:
                    "Prompts you to confirm you're safe every 30 minutes while the app is open, "
                    "and sends an SOS automatically if you don't respond. Foreground-only -- it "
                    "stops if the app is closed or killed.",
                enabled: _autoCheckInEnabled,
                onChanged: _onAutoCheckInToggle,
              ),
              const SizedBox(height: 8),
              _AskAiBar(colors: colors, onTap: _openAiChat),
            ],
          ),
        ],
      ),
    );
  }
}

enum _RiskLevel { low, medium, high }

_RiskLevel _timeOfDayRisk(DateTime now) {
  final hour = now.hour;
  if (hour >= 22 || hour < 5) return _RiskLevel.high;
  if (hour >= 19 || hour < 7) return _RiskLevel.medium;
  return _RiskLevel.low;
}

class _RouteRiskBadge extends StatelessWidget {
  const _RouteRiskBadge({required this.colors});
  final AppPalette colors;

  @override
  Widget build(BuildContext context) {
    final risk = _timeOfDayRisk(DateTime.now());
    final (label, color) = switch (risk) {
      _RiskLevel.low => ('Low', colors.success),
      _RiskLevel.medium => ('Medium', colors.warning),
      _RiskLevel.high => ('High', colors.sosEnd),
    };
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(
            'Current risk: $label (time of day)',
            style: TextStyle(
                color: color, fontSize: 10.5, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _FakeCallDelaySheet extends StatelessWidget {
  const _FakeCallDelaySheet({required this.colors, required this.onPicked});
  final AppPalette colors;
  final ValueChanged<Duration> onPicked;

  @override
  Widget build(BuildContext context) {
    const options = <String, Duration>{
      'Now': Duration.zero,
      'In 5s': Duration(seconds: 5),
      'In 15s': Duration(seconds: 15),
      'In 30s': Duration(seconds: 30),
    };
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Trigger a fake call',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: colors.textPrimary),
            ),
            const SizedBox(height: 20),
            for (final entry in options.entries) ...[
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onPicked(entry.value);
                },
                child: Text(entry.key),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _SafetyScoreData {
  const _SafetyScoreData({
    required this.score,
    required this.contactsCount,
    required this.enabledFeatures,
    required this.verified,
  });

  final int score;
  final int contactsCount;
  final int enabledFeatures;
  final bool verified;
}

/// Composite 0-100 score from real signals only -- no fabricated
/// baseline. Contacts and enabled AI features each contribute up to 40
/// points, verification (when it can be fetched) contributes up to 20.
Future<_SafetyScoreData> _computeSafetyScore(int enabledFeatureCount) async {
  List<TrustedContact> contacts = const [];
  try {
    contacts = await getIt<GetContactsUseCase>().call();
  } catch (_) {
    // Best-effort -- a failed fetch just means 0 contributes here.
  }

  var verified = false;
  try {
    final status = await getIt<GetVerificationStatusUseCase>().call();
    verified = status.status == VerificationState.approved;
  } catch (_) {
    // Best-effort -- verification simply doesn't contribute if it can't
    // be fetched.
  }

  final contactsScore = (contacts.length.clamp(0, 3) / 3 * 40).round();
  final featuresScore = (enabledFeatureCount.clamp(0, 4) / 4 * 40).round();
  final verifiedScore = verified ? 20 : 0;

  return _SafetyScoreData(
    score: (contactsScore + featuresScore + verifiedScore).clamp(0, 100),
    contactsCount: contacts.length,
    enabledFeatures: enabledFeatureCount,
    verified: verified,
  );
}

class _SafetyScoreCard extends StatelessWidget {
  const _SafetyScoreCard({required this.colors, required this.future});
  final AppPalette colors;
  final Future<_SafetyScoreData>? future;

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
      child: FutureBuilder<_SafetyScoreData>(
        future: future,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const SizedBox(
              height: 74,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.white)),
            );
          }
          return Row(
            children: [
              SizedBox(
                width: 74,
                height: 74,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 74,
                      height: 74,
                      child: CircularProgressIndicator(
                        value: data.score / 100,
                        strokeWidth: 6,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                    Text(
                      '${data.score}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Safety Score',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _description(data),
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _description(_SafetyScoreData data) {
    if (data.contactsCount == 0) {
      return 'Add trusted contacts to raise your score -- you have none yet. '
          '${data.enabledFeatures}/4 AI features are enabled.';
    }
    final contactWord = data.contactsCount == 1 ? 'contact' : 'contacts';
    final base =
        '${data.contactsCount} trusted $contactWord and ${data.enabledFeatures}/4 AI '
        'features enabled.';
    return data.verified ? '$base Identity verified.' : base;
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.colors,
    required this.icon,
    required this.title,
    required this.description,
    required this.enabled,
    required this.onChanged,
    this.onTap,
    this.trailing,
  });

  final AppPalette colors;
  final IconData icon;
  final String title;
  final String description;
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (enabled ? colors.primary : colors.textSecondary)
                  .withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color: enabled ? colors.primary : colors.textSecondary,
                size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: colors.textPrimary),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 11.5,
                      height: 1.35,
                      fontWeight: FontWeight.w500),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: enabled,
            activeThumbColor: Colors.white,
            activeTrackColor: colors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );

    if (onTap == null) return content;
    return InkWell(
        borderRadius: BorderRadius.circular(22), onTap: onTap, child: content);
  }
}

class _AskAiBar extends StatelessWidget {
  const _AskAiBar({required this.colors, required this.onTap});
  final AppPalette colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
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
                style: TextStyle(
                    color: colors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ),
            IconButton(
              onPressed: onTap,
              icon: Icon(Icons.mic_rounded, color: colors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
