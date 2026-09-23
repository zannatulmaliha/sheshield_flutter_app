// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authStateHash() => r'f9d9d1151443d5fbb8a5b209ad79c032b135351c';

/// Reactive stream of the current signed-in user (null when signed
/// out). The router's redirect and every screen that needs "who's
/// logged in" watch this -- nothing outside data/ ever touches the
/// auth transport directly.
///
/// Copied from [authState].
@ProviderFor(authState)
final authStateProvider = AutoDisposeStreamProvider<AppUser?>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateRef = AutoDisposeStreamProviderRef<AppUser?>;
String _$authControllerHash() => r'befdfbf67282a91103dcadb1355569541226df20';

/// Drives the login/signup/profile forms: loading + error state for
/// whichever *action* is in flight, kept separate from [authState] so
/// a failed action doesn't affect the app's broader auth state.
/// `build` returns nothing meaningful -- this is a "command" notifier,
/// its value only ever represents the last action's loading/error status.
///
/// Copied from [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AutoDisposeAsyncNotifierProvider<AuthController, void>.internal(
  AuthController.new,
  name: r'authControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
