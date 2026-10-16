# Automated Disaster Recovery & Backup Platform

## Overview

A Docker-based disaster recovery project that demonstrates backup, restoration, simulated application failure, traffic failover, and recovery verification.

## Technologies

* Docker
* Docker Compose
* Node.js
* Express.js
* Nginx
* Bash
* Git and GitHub

## Architecture

The project runs two application environments:

* **Primary:** Main application and data.
* **Recovery:** Secondary application for recovery testing.
* **Nginx:** Routes traffic between primary and recovery.
* **Backup scripts:** Create backups and restore data.

## Features

* Containerized primary and recovery applications.
* Health-check endpoints.
* Timestamped data backups.
* Backup restoration into the recovery environment.
* Simulated primary application failure.
* Traffic failover and failback.
* Recovery drill documentation.

## Run the Project

Start the containers:

```bash
docker compose up --build -d
```

Check container status:

```bash
docker compose ps
```

Access the applications:

* Main proxy: http://localhost:8080
* Primary: http://localhost:8081
* Recovery: http://localhost:8082

## Disaster Recovery Test

Create a backup:

```bash
bash scripts/backup.sh
```

Simulate primary failure:

```bash
docker compose stop primary
```

Restore the backup:

```bash
bash scripts/restore-to-recovery.sh
```

Switch traffic to recovery:

```bash
bash scripts/failover-to-recovery.sh
```

Verify recovery:

```bash
curl http://localhost:8080/health
curl http://localhost:8080/data
```

## Important Note

This is a local disaster recovery simulation. It does not provision actual AWS multi-region infrastructure or implement AWS Backup, RDS snapshots, EBS snapshots, S3 cross-region replication, or Route 53 failover.
