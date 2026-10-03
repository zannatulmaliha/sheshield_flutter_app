import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/contacts/presentation/providers/contacts_use_case_providers.dart';
import 'package:sheshield/features/user/domain/entities/safety_score.dart';
import 'package:sheshield/features/user/presentation/providers/ai_mode_provider.dart';
import 'package:sheshield/features/verification/domain/entities/verification_state.dart';
import 'package:sheshield/features/verification/presentation/providers/verification_use_case_providers.dart';

part 'safety_score_provider.g.dart';

/// The AI Safety Score from real signals only. Recomputed whenever the
/// number of enabled features changes. A failed contacts or verification
/// read counts as "none" rather than failing the whole card.
@riverpod
Future<SafetyScore> safetyScore(SafetyScoreRef ref) async {
  final enabledFeatures = ref.watch(
    aiModeControllerProvider.select((state) => state.settings.enabledFeatureCount),
  );
  final getTrustedContacts = ref.read(getTrustedContactsUseCaseProvider);
  final getVerificationStatus = ref.read(getVerificationStatusUseCaseProvider);

  var contactsCount = 0;
  try {
    contactsCount = (await getTrustedContacts()).length;
  } catch (_) {
    // counts as none
  }

  var isVerified = false;
  try {
    isVerified = (await getVerificationStatus()).status == VerificationState.approved;
  } catch (_) {
    // counts as not verified
  }

  return SafetyScore.calculate(
    contactsCount: contactsCount,
    enabledFeatures: enabledFeatures,
    isVerified: isVerified,
  );
}
