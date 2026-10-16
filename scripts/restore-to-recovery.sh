#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LATEST="$(find "$ROOT/backups" -maxdepth 1 -type f -name 'primary-*.json' -print | sort | tail -n 1)"
if [[ -z "${LATEST:-}" ]]; then echo "No backup found in $ROOT/backups"; exit 1; fi
docker cp "$LATEST" dr-recovery:/data/data.json
echo "Restored $LATEST into recovery app."
