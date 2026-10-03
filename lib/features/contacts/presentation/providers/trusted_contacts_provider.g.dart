// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trusted_contacts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trustedContactsControllerHash() =>
    r'f21958c5cc3c91731d5cb5061c5dac63c931c2ab';

/// Owns the trusted-contacts list for Home and the Contacts tab alike, so
/// adding or removing on one screen updates the other with no manual
/// refresh. Methods throw [AppFailure]; the calling widget shows it.
///
/// Copied from [TrustedContactsController].
@ProviderFor(TrustedContactsController)
final trustedContactsControllerProvider = AutoDisposeAsyncNotifierProvider<
    TrustedContactsController, List<TrustedContact>>.internal(
  TrustedContactsController.new,
  name: r'trustedContactsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$trustedContactsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TrustedContactsController
    = AutoDisposeAsyncNotifier<List<TrustedContact>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
