# Project Summary

## Objective
Demonstrate repeatable backup, restore, failover, and failback for a primary and recovery application.

## Demo
1. Start the stack.
2. Write data through the proxy.
3. Create a timestamped backup.
4. Stop the primary service.
5. Restore the latest backup into recovery.
6. Switch proxy traffic to recovery.
7. Verify health and restored data.
8. Restart primary and fail back.

## Measure
- Backup completion time
- Age of latest backup at outage (approximate RPO)
- Time from outage to recovery (approximate RTO)
- Whether restored data matches the backup

## Limitations
Local simulation only. It does not provide cloud-region isolation, managed backup retention, encryption, or production-grade health-based routing.
