#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cp "$ROOT/nginx/recovery-upstream.conf" "$ROOT/nginx/active-upstream.conf"
docker exec dr-proxy nginx -t
docker exec dr-proxy nginx -s reload
echo "Failover complete: traffic routes to recovery."
