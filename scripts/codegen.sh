#!/usr/bin/env bash
# Regenerates freezed / json_serializable / riverpod / go_router code.
set -euo pipefail
flutter pub get
dart run build_runner build --delete-conflicting-outputs
