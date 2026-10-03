#!/usr/bin/env bash
# Usage: scripts/build_release.sh <dev|staging|production> [apk|appbundle]
set -euo pipefail
flavor="${1:?flavor required: dev | staging | production}"
target="${2:-appbundle}"
flutter build "$target" --flavor "$flavor" -t "lib/main_${flavor}.dart" --release
