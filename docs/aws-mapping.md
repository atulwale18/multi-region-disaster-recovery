# Mapping to AWS later

| Local lab | Possible AWS implementation |
|---|---|
| Primary container | Application in primary AWS region on EC2/ECS/EKS |
| Recovery container | Pilot-light application in recovery region |
| JSON data file | RDS or application data |
| Timestamped file backup | AWS Backup recovery point, RDS/EBS snapshot, or S3 backup |
| Nginx upstream switch | Route 53 failover routing with health checks |
| Shell scripts | Jenkins pipeline or EventBridge/Lambda automation |
| Docker Compose | Terraform-managed cloud infrastructure |

This project does not provision AWS resources. A genuine AWS implementation must separately configure region-specific Terraform providers, IAM permissions, encryption, retention, cross-region copies, DNS health checks, and recovery tests.
