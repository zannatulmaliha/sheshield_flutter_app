// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shareLocationControllerHash() =>
    r'a30df82c7b64dff1cd57e8bd7e954319b6d24d61';

/// One-shot "send my current location now" -- a lighter-weight sibling
/// of [SosController.send] that skips the backend alert/live-tracking
/// entirely and just texts a maps pin to every trusted contact.
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
