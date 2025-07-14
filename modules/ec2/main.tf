resource "aws_instance" "pokemon_game" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = "LabInstanceProfile" # Attach existing profile here

  provisioner "file" {
    source      = local_file.private_key.filename
    destination = "/home/ubuntu/MyKeyPair.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/MyKeyPair.pem"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.my_key.private_key_pem
    host        = self.public_ip
  }

  # Copies your script from local to remote instance
  provisioner "file" {
    source      = "${path.module}/init.sh"
    destination = "/tmp/init.sh"
  }

  provisioner "file" {
    source      = "${path.module}/pokemon-ansible"
    destination = "/home/ubuntu/pokemon-ansible"
  }

  provisioner "file" {
    source      = "${path.module}/pokemon-ansible/inventory.ini"
    destination = "/home/ubuntu/pokemon-ansible/inventory.ini"
  }

  # Runs the script remotely via SSH
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "sudo /tmp/init.sh"
    ]
  }

  tags = {
    Name = "PokemonGame"
  }
}

resource "aws_instance" "pokemon_db" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids_db

  tags = {
    Name = "Database"
  }
}


# Generate a demo SSH key pair
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.my_key.private_key_pem
  filename        = "${path.module}/MyKeyPair.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "generated_key" {
  key_name   = "MyKeyPair"
  public_key = tls_private_key.my_key.public_key_openssh
}
