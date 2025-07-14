#!/bin/bash

# --- Ansible Setup ---
echo "[INFO] Installing Ansible and dependencies..."

sudo apt update -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# Optional: install Python Docker support (if needed by some modules)
# sudo apt install -y python3-docker

echo "[INFO] Installing Ansible Docker collection..."
ansible-galaxy collection install community.docker

ansible --version

# --- Run Ansible Playbook ---
cd /home/ubuntu/pokemon-ansible || {
  echo "[ERROR] /home/ubuntu/pokemon-ansible not found!"
  exit 1
}

echo "[INFO] Running playbook..."
#ansible-playbook -i inventory.ini pokemon_stack.yml
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini pokemon_stack.yml

# *****************************************************************************

# Install AWS CLI
echo "[INFO] Installing AWS CLI..."
# Install dependencies
sudo apt update && sudo apt install -y unzip curl

# Download the installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip
unzip awscliv2.zip

# Run the installer
sudo ./aws/install

# Verify
aws --version



# Game setup
cd /home/ubuntu
git clone https://github.com/WhiskersStack/PokemonWithMongo.git
chown -R ubuntu:ubuntu /home/ubuntu/PokemonWithMongo
cat <<'EOF' >> /home/ubuntu/.bashrc

# Auto-launch Pokemon game on SSH
if [ -n "$SSH_CONNECTION" ]; then
  export PRIVATE_IP_DB=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=Database" \
    --query "Reservations[*].Instances[*].PrivateIpAddress" \
    --output text)
  cd ~/PokemonWithMongo && python3 main.py
fi
EOF






echo "All done! You can now run the game by SSHing into the instance and executing the game script."