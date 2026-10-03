// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shareLocationControllerHash() =>
    r'90000585146792a9d5d51d8453776c6a57917aa1';

/// One-shot "send my current location now": a lighter sibling of
/// `SosController.send` that skips the backend alert / live tracking and
/// just texts a maps pin to every trusted contact.
///
/// Copied from [ShareLocationController].
@ProviderFor(ShareLocationController)
final shareLocationControllerProvider =
    AutoDisposeAsyncNotifierProvider<ShareLocationController, void>.internal(
  ShareLocationController.new,
  name: r'shareLocationControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$shareLocationControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShareLocationController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
