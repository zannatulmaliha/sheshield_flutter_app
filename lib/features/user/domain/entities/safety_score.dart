import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/user/domain/entities/ai_mode_settings.dart';

part 'safety_score.freezed.dart';

/// Composite 0-100 score from real signals only, with no fabricated
/// baseline. Trusted contacts and enabled AI features each contribute up to
/// 40 points; verification (when it can be fetched) contributes up to 20.
@freezed
class SafetyScore with _$SafetyScore {
  const SafetyScore._();

  const factory SafetyScore({
    required int score,
    required int contactsCount,
    required int enabledFeatures,
    required bool isVerified,
  }) = _SafetyScore;

  static const _maxContactsCounted = 3;

  factory SafetyScore.calculate({
    required int contactsCount,
    required int enabledFeatures,
    required bool isVerified,
  }) {
    final contactsPoints =
        (contactsCount.clamp(0, _maxContactsCounted) / _maxContactsCounted * 40).round();
    final featuresPoints =
        (enabledFeatures.clamp(0, AiModeSettings.featureCount) / AiModeSettings.featureCount * 40)
            .round();
    final verificationPoints = isVerified ? 20 : 0;

    return SafetyScore(
      score: (contactsPoints + featuresPoints + verificationPoints).clamp(0, 100),
      contactsCount: contactsCount,
      enabledFeatures: enabledFeatures,
      isVerified: isVerified,
    );
  }

  String get description {
    if (contactsCount == 0) {
      return 'Add trusted contacts to raise your score -- you have none yet. '
          '$enabledFeatures/${AiModeSettings.featureCount} AI features are enabled.';
    }
    final contactWord = contactsCount == 1 ? 'contact' : 'contacts';
    final base = '$contactsCount trusted $contactWord and '
        '$enabledFeatures/${AiModeSettings.featureCount} AI features enabled.';
    return isVerified ? '$base Identity verified.' : base;
  }
}
