// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_invite_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$acceptInviteControllerHash() =>
    r'eb5e757acba3c57bf74ec8fa668be4760906d641';

/// State of redeeming an invite code: `false` until it succeeds, then
/// `true`; loading and error come from the [AsyncValue] itself.
///
/// Copied from [AcceptInviteController].
@ProviderFor(AcceptInviteController)
final acceptInviteControllerProvider =
    AutoDisposeAsyncNotifierProvider<AcceptInviteController, bool>.internal(
  AcceptInviteController.new,
  name: r'acceptInviteControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$acceptInviteControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AcceptInviteController = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
