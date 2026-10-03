// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helperStatusControllerHash() =>
    r'7e3a109062bd83d7a756ec4fa2928a71915fec9c';

/// Owns "am I active, and at what radius". [toggleActive], [setRadius] and
/// [setMutualConnectionOptIn] are the only ways anything else in the app
/// changes this state.
///
/// Copied from [HelperStatusController].
@ProviderFor(HelperStatusController)
final helperStatusControllerProvider = AutoDisposeAsyncNotifierProvider<
    HelperStatusController, HelperStatus>.internal(
  HelperStatusController.new,
  name: r'helperStatusControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$helperStatusControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HelperStatusController = AutoDisposeAsyncNotifier<HelperStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
