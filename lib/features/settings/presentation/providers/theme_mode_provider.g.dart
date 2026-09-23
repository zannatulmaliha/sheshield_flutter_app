// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeModeControllerHash() =>
    r'011185b54f321c892d5d1e8199da9a03a5ebbb38';

/// Drives [resolvePalette] (core/theme/app_palette.dart) and, through it,
/// every User-mode screen's colors.
///
/// Copied from [ThemeModeController].
@ProviderFor(ThemeModeController)
final themeModeControllerProvider =
    AsyncNotifierProvider<ThemeModeController, AppThemeMode>.internal(
  ThemeModeController.new,
  name: r'themeModeControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeModeControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeModeController = AsyncNotifier<AppThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
