// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$alertHistoryControllerHash() =>
    r'2f974e13b850cffb885e3bb6ead0ff8b1fbba8ac';

/// The signed-in user's own SOS history, for the notification-history
/// screen reached from the home bell icon.
///
/// Copied from [AlertHistoryController].
@ProviderFor(AlertHistoryController)
final alertHistoryControllerProvider = AutoDisposeAsyncNotifierProvider<
    AlertHistoryController, List<AlertSummary>>.internal(
  AlertHistoryController.new,
  name: r'alertHistoryControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$alertHistoryControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AlertHistoryController = AutoDisposeAsyncNotifier<List<AlertSummary>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
