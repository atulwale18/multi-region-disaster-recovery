# Automated Disaster Recovery & Backup Platform (Local Lab)

This is an AWS-free practical simulation because the AWS account is currently unavailable. It demonstrates primary/recovery services, backups, restore, traffic failover, and failback using Docker Compose and Nginx.

**Important:** This is not a real AWS multi-region deployment. It does not create RDS, EBS, S3 replication, AWS Backup, or Route 53. Use the AWS mapping in `docs/aws-mapping.md` when you later implement the cloud version.

## Requirements
- Docker Desktop with Docker Compose
- Git Bash or WSL for the shell scripts

## Start
```bash
docker compose up --build -d
docker compose ps
```
- Proxy: http://localhost:8080
- Primary: http://localhost:8081
- Recovery: http://localhost:8082

## Write data and make a backup
```bash
curl http://localhost:8080/health
curl -X POST http://localhost:8080/data -H "Content-Type: application/json" -d '{"message":"primary-data","owner":"Atul"}'
curl http://localhost:8080/data
bash scripts/backup.sh
```

## Simulate outage, restore and fail over
```bash
docker compose stop primary
bash scripts/restore-to-recovery.sh
bash scripts/failover-to-recovery.sh
curl http://localhost:8080/health
curl http://localhost:8080/data
```

## Fail back
```bash
docker compose start primary
bash scripts/failback-to-primary.sh
curl http://localhost:8080/health
```

## Concepts
- **Backup:** timestamped copy of the primary app's JSON data.
- **Restore:** copy the latest backup into the recovery app.
- **Failover:** change Nginx routing from primary to recovery.
- **Failback:** route traffic to primary after it is healthy.
- **RPO:** acceptable data-loss window, approximated by backup age.
- **RTO:** time needed to restore service, measured during the drill.

For a real AWS implementation, use supported AWS Backup, RDS/EBS snapshots, S3 versioning/replication, Terraform-managed resources, and Route 53 health checks/failover. Do not claim AWS implementation until it has actually been deployed and tested.
