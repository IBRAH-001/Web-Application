terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # Optional: S3 backend for state management
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "3tier-app/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment = var.environment
      Project     = "3tier-webapp"
      ManagedBy   = "Terraform"
    }
  }
}

# Data source for latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}# ... (previous provider configuration)

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                 = var.vpc_cidr
  project_name             = var.project_name
  availability_zones       = var.availability_zones
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
}

module "security_groups" {
  source = "./modules/security_groups"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
}

module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  rds_sg_id             = module.security_groups.rds_sg_id
  db_name               = "appdatabase"
  db_username           = var.db_username
  db_password           = var.db_password
}

module "ec2" {
  source = "./modules/ec2"

  project_name           = var.project_name
  ami_id                 = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  ec2_sg_id              = module.security_groups.ec2_sg_id
  private_app_subnet_ids = module.vpc.private_app_subnet_ids
  target_group_arn       = module.alb.target_group_arn
  
  db_host                = module.rds.db_address
  db_name                = module.rds.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = var.desired_capacity
  
  tags = {
    Environment = var.environment
  }
}