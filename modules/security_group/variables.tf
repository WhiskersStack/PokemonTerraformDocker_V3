variable "name" {
  description = "Name for the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to create the security group in"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR block allowed for SSH access"
  type        = string
  default     = "0.0.0.0/0"
}
