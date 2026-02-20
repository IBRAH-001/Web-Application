<img width="1440" height="900" alt="Screen Shot 2026-02-19 at 2 26 21 PM" src="https://github.com/user-attachments/assets/a010e2d9-0e7d-40e5-a2e6-68788816733b" />
<img width="1440" height="900" alt="Screen Shot 2026-02-19 at 2 28 04 PM" src="https://github.com/user-attachments/assets/3d79a19e-0a33-4e5d-8b83-d5dfe3cffc1a" />
<img width="1440" height="900" alt="Screen Shot 2026-02-19 at 12 24 01 PM" src="https://github.com/user-attachments/assets/90e33eab-8339-4136-afb9-8db51950e2de" />
<img width="1440" height="900" alt="Screen Shot 2026-02-19 at 2 28 04 PM" src="https://github.com/user-attachments/assets/d2185733-78d1-4cd2-bbf4-d9a1f9d52e95" />
<img width="1440" height="900" alt="Screen Shot 2026-02-19 at 2 26 58 PM" src="https://github.com/user-attachments/assets/6fc847d1-2a42-4703-b55b-fb507629229d" />

Copy
Code
Preview
# 🚀 Enterprise-Grade 3-Tier Web Application on AWS (Terraform)

<p align="center">
  <img src="https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS">
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform">
  <img src="https://img.shields.io/badge/IaC-Infrastructure%20as%20Code-blue?style=for-the-badge" alt="IaC">
  <img src="https://img.shields.io/badge/High%20Availability-Production%20Ready-success?style=for-the-badge" alt="Production Ready">
</p>

<p align="center">
  <b>A production-ready, enterprise-grade cloud architecture implementing Infrastructure as Code best practices</b>
</p>

---

## 📋 Table of Contents

- [Executive Summary](#-executive-summary)
- [Architecture Overview](#-architecture-overview)
- [Networking Layer](#-networking-layer)
- [Application Layer](#-application-layer)
- [Database Layer](#-database-layer)
- [Security Implementation](#-security-implementation)
- [Monitoring & Observability](#-monitoring--observability)
- [Repository Structure](#-repository-structure)
- [Prerequisites](#-prerequisites)
- [Deployment Instructions](#-deployment-instructions)
- [Business Impact](#-business--operational-impact)
- [Author](#-author)

---

## 🏢 Executive Summary

This project demonstrates the design and implementation of a **production-ready 3-tier web application architecture** on AWS, provisioned entirely using **Terraform Infrastructure as Code (IaC)**.

The solution adheres to enterprise cloud design principles focusing on:

| Principle | Implementation |
|-----------|---------------|
| **High Availability** | Multi-AZ deployment with automatic failover |
| **Fault Tolerance** | Auto-healing infrastructure with health checks |
| **Cost Optimization** | Auto-scaling and right-sized resources |
| **Security** | Defense in depth with layered controls |
| **Observability** | Comprehensive CloudWatch monitoring |
| **Modularity** | Reusable, maintainable Terraform modules |

---

## 🏗️ Architecture Overview

### 🔹 High-Level Design
┌─────────────────────────────────────────────────────────────┐
│                        Internet Users                        │
└──────────────────────┬──────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│           Application Load Balancer (Public Subnets)         │
│                    [Highly Available]                        │
└──────────────────────┬──────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│         Auto Scaling Group (EC2 - Private Subnets)           │
│              [Dynamic Scaling | Multi-AZ]                    │
└──────────────────────┬──────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│        Amazon RDS (Private Subnets - Multi-AZ)               │
│              [Encrypted | Automated Backups]                 │
└─────────────────────────────────────────────────────────────┘
plain

Copy

---

## 🌐 Networking Layer

The networking layer enforces **strict isolation** between application tiers while maintaining secure external access.

### Core Components

| Component | Purpose | Deployment |
|-----------|---------|------------|
| **Custom VPC** | Isolated network environment | Multi-AZ |
| **Public Subnets** | External-facing resources | 2+ Availability Zones |
| **Private Subnets** | Internal application resources | 2+ Availability Zones |
| **Internet Gateway** | Inbound internet access | VPC-attached |
| **NAT Gateway** | Secure outbound access | Highly available |
| **Route Tables** | Segmented traffic routing | Tier-specific |
| **Security Groups** | Stateful firewall rules | Least privilege |

### Network Isolation Strategy

- 🔓 **ALB** → Public Subnets (accepts internet traffic)
- 🔒 **EC2** → Private Subnets (no direct public access)
- 🔒 **RDS** → Private Subnets (database tier isolation)
- 🔄 **NAT Gateway** → Secure outbound updates without exposure

---

## ⚙️ Application Layer

Designed for **scalability, resilience, and performance optimization**.

### Components

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Load Balancer** | AWS ALB | Traffic distribution & SSL termination |
| **Target Groups** | ALB TG | Health checks & routing |
| **Auto Scaling** | ASG | Dynamic capacity management |
| **Launch Template** | EC2 LT | Standardized instance configuration |
| **IAM Roles** | AWS IAM | Least-privilege access |

### Auto Scaling Strategy

```hcl
# Dynamic scaling based on CPU utilization
scaling_policy = {
  target_tracking = "CPUUtilization"
  target_value    = 70.0
  scale_out_cooldown = 300
  scale_in_cooldown  = 300
}
✅ Dynamic scaling based on CPU utilization
✅ Automatic replacement of unhealthy instances
✅ Multi-AZ deployment for fault tolerance
✅ Even traffic distribution via ALB
🗄️ Database Layer

Engineered for reliability and security with enterprise-grade features.
Components

Table

Copy
Feature	Implementation	Benefit
Engine	Amazon RDS (MySQL/PostgreSQL)	Managed database service
Deployment	Multi-AZ	Automatic failover
Storage	Encrypted at rest	Data protection
Backups	Automated with retention	Point-in-time recovery
Access	Security Group restricted	Network isolation
Access Control

hcl

Copy
# RDS Security Group - Only accessible from application tier
ingress {
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  security_groups = [aws_security_group.app_tier.id]
}
🔐 Security Implementation

Defense in depth through layered defensive controls:
Table

Copy
Layer	Control	Implementation
Identity	IAM	Least privilege roles & policies
Network	Security Groups	Tier-segregated access
Data	Encryption	RDS storage encryption
Infrastructure	Network Isolation	Private subnet placement
State	Remote Backend	S3 with state locking
Security Highlights

🔒 No direct public access to EC2 or RDS instances
🔒 Remote Terraform state stored securely in S3
🔒 State locking enabled to prevent concurrent changes
🔒 All traffic encrypted in transit (TLS/SSL)
📊 Monitoring & Observability

Operational visibility implemented using Amazon CloudWatch.
Monitoring Capabilities

Table

Copy
Metric Type	Resource	Alerts
CPU Utilization	EC2 instances	> 80% threshold
ASG Metrics	Auto Scaling Group	Scaling events
RDS Performance	Database	Connection limits, CPU
ALB Health	Load Balancer	Target health checks
Custom Alarms	All resources	Configurable thresholds
CloudWatch Dashboard

hcl

Copy
# Example alarm configuration
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_actions       = [aws_sns_topic.alerts.arn]
}
📁 Repository Structure

plain

Copy
terraform-aws-3tier/
├── 📂 modules/
│   ├── 📂 vpc/              # Network infrastructure
│   ├── 📂 alb/              # Application Load Balancer
│   ├── 📂 ec2/              # Auto Scaling & Launch Templates
│   ├── 📂 rds/              # Database configuration
│   └── 📂 security-groups/  # Firewall rules & IAM
├── 📄 main.tf               # Root module configuration
├── 📄 variables.tf          # Input parameters
├── 📄 outputs.tf            # Output values
├── 📄 backend.tf            # Remote state configuration
├── 📄 provider.tf           # AWS provider setup
├── 📄 terraform.tfvars      # Environment variables (gitignored)
└── 📄 README.md             # This documentation
📋 Prerequisites

Before deploying, ensure you have:
[ ] AWS CLI configured with appropriate credentials
[ ] Terraform >= 1.0 installed
[ ] S3 Bucket for remote state storage
[ ] DynamoDB Table for state locking (optional but recommended)
bash

Copy
# Verify installations
aws --version
terraform --version
🚀 Deployment Instructions

1️⃣ Initialize Terraform

bash

Copy
terraform init
Initializes the working directory and downloads required providers.
2️⃣ Review Execution Plan

bash

Copy
terraform plan
Preview changes before applying (dry run).
3️⃣ Apply Infrastructure

bash

Copy
terraform apply
Deploys the infrastructure. Type yes to confirm.
4️⃣ Destroy Infrastructure (Cleanup)

bash

Copy
terraform destroy
⚠️ Warning: This will permanently delete all resources.
💼 Business & Operational Impact

💰 Cost Optimization

Table

Copy
Strategy	Savings
Auto Scaling	Prevents over-provisioning
Efficient Network Design	Optimized data transfer
Managed Database	Reduces operational overhead
Reserved Instances	Long-term cost savings
⏱ High Availability

✅ Multi-AZ architecture with automatic failover
✅ Load-balanced traffic distribution
✅ Self-healing infrastructure
🔐 Security & Compliance

✅ Network segmentation (DMZ pattern)
✅ IAM least privilege model
✅ Controlled database access
✅ Audit-ready infrastructure code
🚀 Operational Efficiency

✅ Repeatable Terraform deployments
✅ Version-controlled infrastructure (Git)
✅ Reduced human configuration errors
✅ Improved system visibility
👨‍💻 Author

Ibrahim Naleba
Cloud & DevOps Engineer
https://github.com/IBRAH-001
https://www.linkedin.com/in/Ibrahim-Naleba

