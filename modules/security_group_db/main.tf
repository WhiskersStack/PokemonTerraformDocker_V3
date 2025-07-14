resource "aws_security_group" "this" {
  name        = var.name
  description = "Security group for SSH access"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    description     = "Allow Flask API (5000) from game SG"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = var.allowed_source_sg_ids
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}
