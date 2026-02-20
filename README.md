🚀 Enterprise-Grade 3-Tier Web Application on AWS (Terraform)
🏢 Executive Summary
This project demonstrates the design and implementation of a production-ready 3-tier web application architecture on AWS, provisioned entirely using Terraform Infrastructure as Code (IaC).
The solution adheres to enterprise cloud design principles focusing on:
High Availability
Fault Tolerance
Cost Optimization
Security Best Practices
Observability & Monitoring
Modular and Reusable Infrastructure Code
This architecture reflects real-world production standards and showcases hands-on cloud engineering expertise.
🏗️ Architecture Overview
🔹 High-Level Design
Internet Users
        │
        ▼
Application Load Balancer (Public Subnets)
        │
        ▼
Auto Scaling Group (EC2 - Private Subnets)
        │
        ▼
Amazon RDS (Private Subnets - Multi-AZ)
🌐 Networking Layer
The networking layer enforces strict isolation between application tiers while maintaining secure external access.
Core Components:
Custom VPC
Public Subnets (Multi-AZ)
Private Subnets (Multi-AZ)
Internet Gateway (IGW)
NAT Gateway (secure outbound access)
Route Tables with segmented routing
Dedicated Security Groups
Network Isolation Strategy:
ALB deployed in Public Subnets
EC2 instances deployed in Private Subnets
RDS deployed in Private Subnets (no public access)
NAT Gateway allows outbound updates without exposing instances
Strict Security Group rules enforcing least privilege
This layered design strengthens perimeter and internal security controls.
⚙️ Application Layer
Designed for scalability, resilience, and performance optimization.
Components:
Application Load Balancer (ALB)
Target Groups
Auto Scaling Group (ASG)
Launch Template
IAM Role (Least Privilege Principle)
Auto Scaling Strategy:
Dynamic scaling based on CPU utilization
Automatic replacement of unhealthy instances
Multi-AZ deployment for fault tolerance
Even traffic distribution via ALB
This ensures performance stability during traffic spikes.
🗄️ Database Layer
The database tier is engineered for reliability and security.
Components:
Amazon RDS (Multi-AZ Deployment)
Private Subnet Placement
Encrypted Storage
Automated Backups
Failover Support
Access Control:
Restricted exclusively to the application tier via Security Groups
📊 Monitoring & Observability
Operational visibility is implemented using Amazon CloudWatch.
Monitoring Capabilities:
EC2 CPU utilization tracking
Auto Scaling metrics
RDS performance monitoring
ALB health checks
Alarm configuration for threshold breaches
Log aggregation and troubleshooting
This enables proactive performance monitoring and rapid incident response.
🔐 Security Implementation
Security is enforced through layered defensive controls:
Least Privilege IAM Roles
Segregated Security Groups (ALB / EC2 / RDS)
Private Subnet Isolation
No direct public access to EC2 or RDS
Remote Terraform state stored securely in S3
State locking enabled to prevent concurrent changes
🧠 Infrastructure as Code Strategy
Terraform Features Used:
Modular architecture for maintainability
Remote backend in Amazon S3
State locking enabled
Environment separation via workspaces
Parameterized variables and outputs
Clean module abstraction
This ensures consistent, repeatable, and auditable deployments.
📊 Business & Operational Impact
💰 Cost Optimization
Auto Scaling prevents over-provisioning
Efficient network design
Managed database reduces operational overhead
⏱ High Availability
Multi-AZ architecture
Load-balanced traffic distribution
Self-healing infrastructure
🔐 Security & Compliance
Network segmentation
IAM least privilege model
Controlled database access
🚀 Operational Efficiency
Repeatable Terraform deployments
Version-controlled infrastructure
Reduced human configuration errors
Improved system visibility through monitoring
📁 Repository Structure
├── modules/
│   ├── vpc/
│   ├── alb/
│   ├── ec2/
│   ├── rds/
│   └── security-groups/
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
├── provider.tf
🚀 Deployment Instructions
1️⃣ Initialize Terraform
terraform init
2️⃣ Review Plan
terraform plan
3️⃣ Apply Infrastructure
terraform apply
4️⃣ Destroy Infrastructure
terraform destroy
👨‍💻 Author
Ibrahim Naleba
Cloud & DevOps Engineer
GitHub: https://github.com/IBRAH-001
LinkedIn: https://www.linkedin.com/in/Ibrahim-Naleba<img width="1920" height="1080" alt="Screen Shot 2026-02-19 at 2 28 04 PM (2)" src="https://github.com/user-attachments/assets/af99e789-8d47-4cc1-8281-edc1a920d92a" />
<img width="1440" height="900" alt="Screen Shot 2026-02-19 at 12 24 01 PM" src="https://github.com/user-attachments/assets/b4434f6b-830f-4c3b-bfe1-6121cb76e6b0" />
<img width="1440" height="900" alt="Screen Shot 2026-02-19 at 2 28 04 PM" src="https://github.com/user-attachments/assets/9f66cf45-ddc4-4ecc-8978-78334ed88ace" />
<img width="1440" height="900" alt="Screen Shot 2026-02-19 at 2 26 21 PM" src="https://github.com/user-attachments/assets/656904c7-ac43-4921-8573-fb7d8d082217" />
