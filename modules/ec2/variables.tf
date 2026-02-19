variable "project_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "ec2_sg_id" {}
variable "private_app_subnet_ids" { type = list(string) }
variable "target_group_arn" {}
variable "db_host" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}
variable "tags" {
  type    = map(string)
  default = {}
}