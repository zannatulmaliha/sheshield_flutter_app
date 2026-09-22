#!/usr/bin/env bash
# Run the Flutter app on a USB-connected phone against the local backend.
# Re-establishes the adb reverse tunnel (which drops on every USB
# reconnect/adb restart) before launching, so localhost:8080 on the phone
# always reaches the backend on this machine.
set -euo pipefail

adb wait-for-device
adb reverse tcp:8080 tcp:8080

exec flutter run --dart-define=API_BASE_URL=http://localhost:8080/api/v1 "$@"
