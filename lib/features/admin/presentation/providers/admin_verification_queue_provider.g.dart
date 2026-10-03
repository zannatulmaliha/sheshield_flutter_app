// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_verification_queue_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminVerificationQueueControllerHash() =>
    r'fa10b98f2ce90c49d55e8952a0c679048c500f4b';

/// Helper identity-verification submissions, newest data on every open.
///
/// Copied from [AdminVerificationQueueController].
@ProviderFor(AdminVerificationQueueController)
final adminVerificationQueueControllerProvider =
    AutoDisposeAsyncNotifierProvider<AdminVerificationQueueController,
        List<AdminVerification>>.internal(
  AdminVerificationQueueController.new,
  name: r'adminVerificationQueueControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$adminVerificationQueueControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AdminVerificationQueueController
    = AutoDisposeAsyncNotifier<List<AdminVerification>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
