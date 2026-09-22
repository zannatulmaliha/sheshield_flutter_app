// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_alerts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nearbyAlertsControllerHash() =>
    r'6d8d73af88a25f12dd263f64d1b7088a185d7578';

/// The nearby-alerts list. Declaring `ref.watch(helperStatusControllerProvider.future)`
/// inside [build] means this provider automatically re-fetches whenever
/// active status flips on, and returns an empty list the moment it
/// flips off -- no manual wiring between the two controllers.
///
/// Copied from [NearbyAlertsController].
@ProviderFor(NearbyAlertsController)
final nearbyAlertsControllerProvider = AutoDisposeAsyncNotifierProvider<
    NearbyAlertsController, List<NearbyAlert>>.internal(
  NearbyAlertsController.new,
  name: r'nearbyAlertsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nearbyAlertsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NearbyAlertsController = AutoDisposeAsyncNotifier<List<NearbyAlert>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
