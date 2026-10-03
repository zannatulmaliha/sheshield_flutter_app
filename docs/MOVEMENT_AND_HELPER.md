# Movement detection + Helper mode (this change set)

## What was added

### Movement detection (on-device)
* `lib/core/services/motion/` - `MotionDetector` (pure Dart, no I/O), `MotionService`
  (sensors_plus @ 50 Hz + Android foreground service), `MotionGuardController`
  (Riverpod: detection -> "Are you OK?" countdown -> SOS), prompt + settings screens.
* Detects: **fall** (free-fall/impact -> stillness -> orientation change, scored),
  **post-fall inactivity**, **sprint** (calm baseline -> sustained, rhythmic, fast gait),
  **struggle** (high gyro+accel energy with no rhythmic gait).
* Best practices applied: opt-in & reversible; every detection is confirmed with the person
  first (20-30 s countdown); sprint never auto-sends by default (runner vs. chased look
  identical); cooldowns; SOS suppressed while one is live; raw samples never leave the phone;
  only typed events are logged (30-day retention, user can erase); frequency is never used to
  restrict SOS access (spec core principle).
* Thresholds tuned on synthetic traces over 40 random seeds with 0 failures
  (`SheShield-Backend-main/docs/motion-prototype/`). **They are starting values - collect
  real-device data (walking, running, stairs, bus, bike, real staged falls) before shipping.**

### Backend
* Migration `016`: `alerts.trigger_type/helper_progress/resolved_by`, `helper_responses`,
  `motion_events`, `sos_messages`.
* `internal/trigger`: trigger -> label + risk shown to helpers (no identity).
* `internal/motion`: `POST/GET/DELETE /api/v1/motion/events` + retention purge.
* `internal/sosmsg`: `GET/POST /api/v1/sos/{id}/messages` - in-app chat, access enforced
  server-side (revoked on resolve/release), contact-info messages silently flagged.
* `internal/helper`: `/helper/stats`, `/helper/history`, `/helper/responses/current`,
  `/helper/alerts/{id}/live|progress|resolve`. Resolve requires "arrived" and is blocked while a
  duress signal is active. Alerts keep updating location after acceptance (before, location froze
  on accept, which also broke the connectivity-lost banner).

### Helper app (matches the screenshots)
5 tabs: Dashboard / Alerts (Nearby + My Response) / Profile / Support / History, real stats,
risk chips + reason + ETA on alert cards, stage tracking, live map, Call 999, in-app chat,
resolve / back out / report.

### Bugs fixed on the way
* `HelperApiDataSource` used `/api/v1/helper` on top of a base URL that already ends in `/api/v1`
  -> every helper call went to `/api/v1/api/v1/helper/...` (404).
* Support-screen card titles were invisible (light text on white cards) - explicit colours now.
* Dashboard numbers (24 / 91% / 8m) were static - now computed server-side.

## Not verified here (be honest with yourself before shipping)
* The Flutter code was **not compiled** (no Flutter SDK in my sandbox). Run:
  `flutter pub get && flutter analyze && flutter test` and fix any small typos.
* Backend: `go test` passes for trigger, motion, sosmsg, helper, alert (run via a scratch GOPATH
  with mattn/sqlite3 because the sandbox could not fetch modules); run `go mod tidy && go test ./...`
  on your machine.
* No iOS native service was added; sensing only continues in the background on Android.
* go_router's generated file was not touched (the 5 tabs live inside `HelperShell`).
* Legal/ethics: motion events + auto-SOS need the same counsel/privacy review as the rest of
  the spec (§7, §9, §13).
