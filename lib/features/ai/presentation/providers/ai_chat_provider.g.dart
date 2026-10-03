// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiChatControllerHash() => r'60e412ae9f79357689eb1ca61f7ce5347ae0ee84';

/// Owns the Ask AI Guardian conversation for the app session (in memory
/// only; a fresh launch starts a new chat).
///
/// Copied from [AiChatController].
@ProviderFor(AiChatController)
final aiChatControllerProvider =
    AutoDisposeNotifierProvider<AiChatController, AiChatState>.internal(
  AiChatController.new,
  name: r'aiChatControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiChatControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AiChatController = AutoDisposeNotifier<AiChatState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
