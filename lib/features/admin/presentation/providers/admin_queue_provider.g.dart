// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_queue_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminQueueControllerHash() =>
    r'93413d9ff7913cd034f45b7f518e7dbc6fa9da07';

/// The pending moderation queue -- one shared list whoever filed the
/// report (user, helper, or an automated rate-limit flag), per the spec's
/// symmetric-review principle. The repository's short-TTL cache keeps
/// `build()` cheap to re-run.
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
