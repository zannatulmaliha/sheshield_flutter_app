// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localeControllerHash() => r'fdda91eebe33240ae73adbc5cf71970c7627bcef';

/// Drives `MaterialApp.router`'s `locale:` parameter. `null` state
/// means "no saved preference" -- Flutter then resolves the best
/// match from the device's system locales against `supportedLocales`
/// on its own, so we never have to duplicate that fallback logic here.
///
/// Copied from [LocaleController].
@ProviderFor(LocaleController)
final localeControllerProvider =
    AsyncNotifierProvider<LocaleController, AppLanguage?>.internal(
  LocaleController.new,
  name: r'localeControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localeControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocaleController = AsyncNotifier<AppLanguage?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
