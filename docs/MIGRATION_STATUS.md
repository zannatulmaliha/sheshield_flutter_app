# Migration status

Migrated end-to-end to the rules in `ARCHITECTURE.md`:
**admin**, **contacts**, **report**, **verification**, **ai**, **chat**, **helper**, **sos**, **auth**, **settings**, **shared widgets**, most of **user** (everything except `ai_mode_screen`), plus **core**
(config/flavors, network, error, DI modules, router, hooks).

## Remaining work

All features are migrated (admin, contacts, report, verification, ai, chat, helper, sos, auth, settings, user,
shared widgets, core). What is left is the three background services in `lib/core/services`, which are not
UI features:

- `motion/motion_detector.dart` (530 lines), `motion/motion_guard.dart` (196), `push_service.dart` (152):
  still the originals; they call `getIt` directly.

## Cross-feature patches in un-migrated files

These compile against the new types but still call `getIt` directly; they disappear when their feature migrates:
`share_location_provider`, `ai_mode_screen`, `sos_provider` (now `GetTrustedContactsUseCase`),
`sos_activated_view` (now `GetResponderStateUseCase`, `ResponderProgress`, `AppFailure`).

## Known gaps in what *was* migrated

- Helper: an accept now surfaces a failure (`AppFailure`) as a snackbar instead of an unhandled exception, and the
  two accept dialogs (dashboard, alerts tab) share one wording. A held alert ending because the lock was lost
  (403/409) now shows "no longer assigned to you" where it used to end silently. The lock-lost check uses the HTTP
  status, not the old `message.contains('currently hold')` string match.
- Admin report detail: the review panel and the suspension panel each disable only their own buttons while running
  (the old screen shared one busy flag).
- Chat: error text for network failures is now the shared `AppFailure` wording, not the old per-feature strings.
- Nothing has been compiled or analyzed.
