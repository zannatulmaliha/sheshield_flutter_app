// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helperStatusControllerHash() =>
    r'd96ef9ec136edb415d10cbb5009f2e61c6527962';

/// Owns "am I active, and at what radius". [toggleActive] and
/// [setRadius] are the only way anything else in the app changes this
/// state -- both go through the domain use cases, never straight to
/// the repository.
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
