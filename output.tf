output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.alb.alb_dns_name
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_endpoint
  sensitive   = true
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = module.ec2.autoscaling_group_name
}