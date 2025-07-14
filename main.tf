# Terraform configuration for AWS infrastructure

# This file sets up the necessary AWS resources including VPC, security groups, and EC2 instances.

# Provider configuration
provider "local" {}

# Data source to get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Module for security group allowing SSH access
module "security_group" {
  source   = "./modules/security_group"
  name     = "allow_ssh"
  vpc_id   = data.aws_vpc.default.id
  ssh_cidr = "0.0.0.0/0"
}

# Module for security group allowing database access
# This module creates a security group that allows access to the database from specified security groups.
# It allows SSH access and also allows the Flask API to be accessed from the game security group
module "security_group_db" {
  source                = "./modules/security_group_db"
  name                  = "allow_db_access"
  vpc_id                = data.aws_vpc.default.id
  allowed_source_sg_ids = [module.security_group.security_group_id] # game SG
}

# Module for EC2 instance setup
# This module creates an EC2 instance with the specified AMI and instance type.
module "ec2" {
  source                    = "./modules/ec2"
  ami                       = var.ami
  instance_type             = var.instance_type
  vpc_security_group_ids    = [module.security_group.security_group_id]
  vpc_security_group_ids_db = [module.security_group_db.security_group_id]
}

# Output the public IP of the EC2 instance
output "Instance_1_ssh" {
  value = "ssh -o StrictHostKeyChecking=no -i MyKeyPair.pem ubuntu@${module.ec2.public_ip}"
}

output "Instance_2_ssh" {
  value = "ssh -o StrictHostKeyChecking=no -i MyKeyPair.pem ubuntu@${module.ec2.db_public_ip}"
}

# Local file resource to create Ansible inventory file
# This file will be used by Ansible to connect to the EC2 instance.
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/modules/ec2/pokemon-ansible/inventory.ini"
  content  = <<EOF
[web]
ec2 ansible_host=${module.ec2.db_public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/MyKeyPair.pem
EOF
}
