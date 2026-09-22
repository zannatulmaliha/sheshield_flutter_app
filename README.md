# SheShield — Flutter (Clean Architecture + Riverpod codegen)

This is a **standalone project scaffold**, not a drop-in for your real
`E:\flutter_sheshield` app (that one is `ChangeNotifier`-based — see
the note at the bottom). This is the from-scratch rebuild we've been
building in this chat, meant to be its own project or merged in
deliberately later.

## Requirement checklist — honest status

| Requirement | Status |
|---|---|
| Clean Architecture (domain/data/presentation, use cases) | ✅ done — `features/auth/`, `features/helper/` |
| Feature-first module organization | ✅ done |
| get_it dependency injection | ✅ done — `core/di/injection.dart` |
| Riverpod with **code generation** (`@riverpod`, no `ChangeNotifier`/`StateNotifierProvider`) | ✅ done — every provider in `features/*/presentation/providers/` |
| Dio | ✅ done — `core/network/dio_client.dart` |
| go_router with **code generation** (`@TypedGoRoute`, no string paths) | ✅ done — `core/router/app_router.dart` (`LoginRoute`/`SignupRoute`/`HomeRoute`) |
| Models via codegen, not hand-written fromJson/toJson | ✅ done — Freezed on every entity |
| Gender handling | ✅ done — `Gender` enum + gender-gated role selection at signup |
| Dynamic country/number | ✅ done — `core/constants/country_dial_codes.dart` + `CountryCodePicker`; phone validation checks the digit-length range of whichever country is selected, not one hardcoded rule |
| Localization, English + Bangla | ✅ done — every auth + helper-dashboard string routed through `AppLocalizations.of(context)!.xxx`; `nearbyAlertsCount` is a real ICU **plural** message (`=0`/`=1`/`other`), demonstrating dynamic-number-driven text, not just static translation |
| Isar persistent cache, TTL, no repeat API calls | ✅ wired into one real repository — `HelperRepositoryImpl.fetchStatus` (5-minute TTL); `nearbyAlerts` is deliberately left uncached since stale alert data is unsafe, not just slow. Wire `CacheBox` into future repositories the same way. |
| Drift | ❌ deliberately not used — Isar covers the stated need (cache with TTL); Drift adds relational-query machinery nothing here needs |

## Setup (this has no platform folders yet)

The reason `flutter run` fails right now is not a bug — this scaffold
was handed to you as `lib/` only, with no `android/`, `ios/`, `web/`
folders and no generated (`.g.dart`/`.freezed.dart`) files. Both are
required before the app compiles. In order, from inside this project's
root:

```
flutter create --org com.example --project-name sheshield .
```
This will ask to overwrite `pubspec.yaml` — say **no**, keep the one
here. It only adds the missing `android/`, `ios/`, `web/`, etc. folders
around the existing `lib/`.

```
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```
`build_runner` generates every `@freezed`/`@riverpod`/`@TypedGoRoute`
file (`*.freezed.dart`, `*.g.dart`, `core/router/app_router.g.dart`).
`gen-l10n` generates `lib/core/l10n/app_localizations.dart` from the
`.arb` files — the app will not compile without this step, since
`main.dart` imports that generated file directly.

Then run the **real** entry point — `lib/main.dart` (there is no
`main_auth.dart`; that path doesn't exist in this project):
```
flutter run -t lib/main.dart -d edge --dart-define=API_BASE_URL=http://localhost:8081
```
(Run the Go backend first — `go run .\cmd\api` — port 8081 to match
`ApiConstants.baseUrl`'s default. `-d edge` targets the Edge browser;
drop it to get a device picker instead.)

Re-run the `build_runner` command any time you add or edit a
`@freezed` class, a `@riverpod` provider, or a `@TypedGoRoute` class.
Keep `dart run build_runner watch -d` running in a second terminal
while you work instead of re-running it by hand each time.

## What's in here

- `shared/entities/` — `AppUser`, `Gender`, `UserType` (all Freezed)
- `shared/widgets/mode_switch.dart` — dual-role Ask-for-help / Respond-to-alerts toggle
- `core/` — DI, router, theme, network, cache, device location wrapper, localization stubs
- `features/auth/` — signup (with gender-gated role rule), login, session persistence, all Riverpod codegen
- `features/helper/` — GO ACTIVE toggle + radius, nearby alerts, accept-with-race-handling, post-accept detail screen with Maps/Call

## What's NOT in here yet

- `features/contacts/`, `features/sos/`, `features/verification/`, `features/profile/` — none built in this scaffold
- The corresponding Go backend endpoints for helper mode (`/api/v1/helper/*`) — contract is documented in `helper_api_datasource.dart`'s doc comments, not implemented server-side
- `root_shell.dart`'s plain-`user` branch is a placeholder (`_UserModePlaceholder`) — there's no SOS/home screen in this scaffold to route to yet
