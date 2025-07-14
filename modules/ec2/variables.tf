variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  #   default     = "ami-075686beab831bb7f" # Example AMI ID, replace with your own
}
variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  #   default     = "t2.micro" # Example instance type, replace with your own
}
variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
  default     = "MyKeyPair" # Example key pair name, replace with your own
}
# variable "tags" {
#   description = "Tags to apply to the instance"
#   type        = map(string)
#   default = {
#     Name = "PokemonGame" # Default tag, can be overridden
#   }
# }
variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = []
}
variable "vpc_security_group_ids_db" {
  description = "List of security group IDs to associate with the database instance"
  type        = list(string)
  default     = []
}
