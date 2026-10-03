# Per-flavor Firebase config

Each flavor has its own application id, so each needs its own
`google-services.json` in its folder:

- `android/app/src/dev/google-services.json`        -> `com.example.sheshield.dev`
- `android/app/src/staging/google-services.json`    -> `com.example.sheshield.staging`
- `android/app/src/production/google-services.json` -> `com.example.sheshield`

Register one Android app per id in the Firebase console and download each
file. The current `android/app/google-services.json` only covers the
production id; keep it until the flavor files exist, then remove it.
