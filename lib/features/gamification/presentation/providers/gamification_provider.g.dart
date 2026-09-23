// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gamificationControllerHash() =>
    r'0e60195c1d8f6937a31d212f4023e3ad54834000';

/// Local, in-session "Guardian Level" progress earned by using the
/// app's real safety features (adding contacts, sending an SOS,
/// responding as a helper...). Ported from the UI_Screens prototype's
/// `GameState`/`GameScope`, rebuilt on Riverpod to match this app's
/// state management instead of an `InheritedNotifier`. Not persisted
/// or backed by the server -- resets when the app restarts, same as
/// on the branch this was ported from.
///
/// Copied from [GamificationController].
@ProviderFor(GamificationController)
final gamificationControllerProvider =
    NotifierProvider<GamificationController, GamificationState>.internal(
  GamificationController.new,
  name: r'gamificationControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gamificationControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GamificationController = Notifier<GamificationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
