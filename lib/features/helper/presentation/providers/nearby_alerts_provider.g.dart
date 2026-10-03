// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_alerts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nearbyAlertsControllerHash() =>
    r'c9a7944b3385e7aba737a170c1aeff2bfced35f0';

/// The nearby-alerts list. Watching `helperStatusControllerProvider.future`
/// inside [build] re-fetches whenever active status flips on and returns an
/// empty list the moment it flips off, with no manual wiring.
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
