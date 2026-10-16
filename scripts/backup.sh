#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$ROOT/backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
docker cp dr-primary:/data/data.json "$ROOT/backups/primary-$STAMP.json"
echo "Backup created: $ROOT/backups/primary-$STAMP.json"
