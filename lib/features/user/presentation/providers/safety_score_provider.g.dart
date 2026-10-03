// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safety_score_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$safetyScoreHash() => r'620d4556e4f01375fd87860bb70c54bd958046d5';

/// The AI Safety Score from real signals only. Recomputed whenever the
/// number of enabled features changes. A failed contacts or verification
/// read counts as "none" rather than failing the whole card.
///
/// Copied from [safetyScore].
@ProviderFor(safetyScore)
final safetyScoreProvider = AutoDisposeFutureProvider<SafetyScore>.internal(
  safetyScore,
  name: r'safetyScoreProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$safetyScoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SafetyScoreRef = AutoDisposeFutureProviderRef<SafetyScore>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
