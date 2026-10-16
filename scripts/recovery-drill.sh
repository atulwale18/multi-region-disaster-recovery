#!/usr/bin/env bash
set -euo pipefail
echo "1. Check primary: curl http://localhost:8081/health"
echo "2. Create backup: bash scripts/backup.sh"
echo "3. Record start time."
echo "4. Stop primary: docker compose stop primary"
echo "5. Restore: bash scripts/restore-to-recovery.sh"
echo "6. Fail over: bash scripts/failover-to-recovery.sh"
echo "7. Verify: curl http://localhost:8080/health && curl http://localhost:8080/data"
echo "8. Record recovery time and calculate approximate RTO."
echo "9. Restart primary and fail back when ready."
