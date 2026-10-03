#!/usr/bin/env bash
# Run the dev flavor on a USB-connected phone against the local backend.
# Re-establishes the adb reverse tunnel (it drops on every USB reconnect)
# so localhost:8080 on the phone reaches the backend on this machine.
set -euo pipefail

adb wait-for-device
adb reverse tcp:8080 tcp:8080

exec flutter run --flavor dev -t lib/main_dev.dart \
  --dart-define=API_BASE_URL=http://localhost:8080/api/v1 "$@"
