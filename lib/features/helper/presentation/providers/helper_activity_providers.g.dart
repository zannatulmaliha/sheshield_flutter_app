// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_activity_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helperStatsHash() => r'e997e9e8b85aa45d45f5c41c2c98bb19a56bfc72';

/// Real dashboard numbers (responses / success / avg time). A failed read
/// shows zeros rather than an error card on the dashboard.
///
/// Copied from [helperStats].
@ProviderFor(helperStats)
final helperStatsProvider = AutoDisposeFutureProvider<HelperStats>.internal(
  helperStats,
  name: r'helperStatsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$helperStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HelperStatsRef = AutoDisposeFutureProviderRef<HelperStats>;
String _$helperHistoryHash() => r'cc27c897ba84c8cd72d2ef83403ddcfa033f0631';

/// Past responses for the History tab.
///
/// Copied from [helperHistory].
@ProviderFor(helperHistory)
final helperHistoryProvider =
    AutoDisposeFutureProvider<List<HelperHistoryItem>>.internal(
  helperHistory,
  name: r'helperHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$helperHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HelperHistoryRef
    = AutoDisposeFutureProviderRef<List<HelperHistoryItem>>;
String _$myResponseHash() => r'f2c7a35802cc1abb010787c7c77283462c0ab4e3';

/// The alert this helper currently holds, if any ("My Response" tab).
/// Invalidate after accepting / backing out / resolving.
///
/// Copied from [myResponse].
@ProviderFor(myResponse)
final myResponseProvider = AutoDisposeFutureProvider<MyResponse?>.internal(
  myResponse,
  name: r'myResponseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$myResponseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MyResponseRef = AutoDisposeFutureProviderRef<MyResponse?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
