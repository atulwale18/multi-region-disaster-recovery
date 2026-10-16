#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
curl -fsS http://localhost:8081/health >/dev/null
cp "$ROOT/nginx/primary-upstream.conf" "$ROOT/nginx/active-upstream.conf"
docker exec dr-proxy nginx -t
docker exec dr-proxy nginx -s reload
echo "Failback complete: traffic routes to primary."
