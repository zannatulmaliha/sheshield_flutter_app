# SheShield frontend architecture

## Layers (per feature, under `lib/features/<feature>/`)

```
domain/        entities (freezed, no JSON) · repository interfaces · use cases
data/          models (freezed + json_serializable, `toEntity()`) · datasources · repository impls
presentation/  providers (Riverpod) · screens · widgets
```

Dependencies point inward: presentation -> domain <- data.

## Rules every file follows

| Rule | How it is applied |
|---|---|
| Max 150 lines per file | Screens compose small widgets; one class of concern per file |
| No entity without a model | Every `domain/entities/x.dart` has `data/models/x_model.dart` with `fromJson` + `toEntity()` |
| Codegen for data classes | `freezed` + `json_serializable` only. No hand-written `fromJson`/`copyWith`/`==` |
| No `setState` | `flutter_hooks` (`useState`, `useTextEditingController`, `useAsyncAction`) in `HookConsumerWidget`s |
| No `FutureBuilder` / futures in the UI | Data comes from `AsyncValue` providers; widgets only `ref.watch` / `ref.read(...notifier)` |
| Widgets never touch `getIt` | `*_use_case_providers.dart` is the single bridge from get_it to Riverpod |
| Use cases are held in a variable | Notifiers declare `late final _getX = ref.read(getXUseCaseProvider);` and call `_getX(...)` |
| Readable names | `fetchReportQueue`, `GetReportQueueUseCase`, `adminReportDetailControllerProvider`; no `j`, `res`, `e`, `fetchQueue` |
| One error type | Data layer throws `AppFailure` (via `guardApiCall`); the UI shows `failure.message` |
| SOLID | Repos/datasources split by responsibility (e.g. admin: key store, API client, report vs verification datasources); interfaces in domain; policy as pure functions (`resolveRedirect`) |

## Flavors

`dev` · `staging` · `production`, each with its own entry point and Android product flavor.

```bash
flutter run --flavor dev        -t lib/main_dev.dart
flutter run --flavor staging    -t lib/main_staging.dart
flutter build appbundle --flavor production -t lib/main_production.dart   # or scripts/build_release.sh
```

`AppConfig` (in `lib/core/config/`) holds the base URL, logging flag and title. Override the URL with
`--dart-define=API_BASE_URL=...`. Each flavor has a different application id, so each needs its own
`google-services.json` (see `android/app/src/<flavor>/README.md`).

## Codegen

```bash
scripts/codegen.sh   # flutter pub get && dart run build_runner build --delete-conflicting-outputs
```

Generated `*.g.dart` / `*.freezed.dart` files were deleted for migrated features; run codegen before building.

## Adding a feature, step by step

1. `domain/entities/foo.dart` (freezed) and `domain/repositories/foo_repository.dart` (interface).
2. `data/models/foo_model.dart` (freezed + json, `toEntity()`), datasource using `guardApiCall`, repository impl.
3. One `domain/usecases/<verb>_<noun>_usecase.dart` per action.
4. Register in `core/di/modules/foo_module.dart`; add the call in `core/di/injection.dart`.
5. `presentation/providers/foo_use_case_providers.dart` + one `@riverpod` controller per screen.
6. Screens as `HookConsumerWidget`; add typed routes in `core/router/routes/`.
