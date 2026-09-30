// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_queue_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminQueueControllerHash() =>
    r'b95ccc185cae4013677fc6742d673b26d2c70fe4';

/// The pending moderation queue -- one shared list regardless of
/// reporter_role (user report, helper report, or an automated rate-limit
/// flag), per the spec's symmetric-review principle. Backed by
/// AdminRepositoryImpl's short-TTL cache, so build() is cheap to re-invoke.
///
/// Copied from [AdminQueueController].
@ProviderFor(AdminQueueController)
final adminQueueControllerProvider = AutoDisposeAsyncNotifierProvider<
    AdminQueueController, List<AdminReport>>.internal(
  AdminQueueController.new,
  name: r'adminQueueControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$adminQueueControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AdminQueueController = AutoDisposeAsyncNotifier<List<AdminReport>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
