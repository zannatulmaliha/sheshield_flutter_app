// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localeControllerHash() => r'790860d8d0befd8187e15c8dd5e6519b8138ed1e';

/// Drives `MaterialApp.router`'s `locale:`. A `null` state means "no saved
/// preference": Flutter then resolves the best match from the device's
/// locales against `supportedLocales` itself, so that fallback logic is
/// never duplicated here.
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
