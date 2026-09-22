// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sosControllerHash() => r'5f019ca727749d129716ecd5ce8f473819608ef5';

/// Owns the currently-active SOS alert, if any. Starts at `null` --
/// there is nothing to fetch on app launch, unlike helper status,
/// since an alert only exists once the user actually sends one in
/// this session.
///
/// Copied from [SosController].
@ProviderFor(SosController)
final sosControllerProvider =
    AutoDisposeNotifierProvider<SosController, AsyncValue<SosAlert?>>.internal(
  SosController.new,
  name: r'sosControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sosControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SosController = AutoDisposeNotifier<AsyncValue<SosAlert?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
