// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiModeControllerHash() => r'f67056b292ad166281d69c7d15f1067172319c5c';

/// Owns the AI Guardian toggles and the behaviour behind them: the voice
/// distress listener and the periodic "Are you safe?" prompt. Both run only
/// while the app process is alive (foreground-only), exactly as before.
///
/// Copied from [AiModeController].
@ProviderFor(AiModeController)
final aiModeControllerProvider =
    AutoDisposeNotifierProvider<AiModeController, AiModeState>.internal(
  AiModeController.new,
  name: r'aiModeControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiModeControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AiModeController = AutoDisposeNotifier<AiModeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
