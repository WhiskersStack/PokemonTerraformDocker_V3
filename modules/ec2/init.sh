#!/bin/bash

# --- Ansible Setup ---
echo "[INFO] Installing Ansible and dependencies..."
sudo apt update -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
ansible-galaxy collection install community.docker
ansible --version

# --- Run Ansible Playbook ---
cd /home/ubuntu/pokemon-ansible || {
  echo "[ERROR] /home/ubuntu/pokemon-ansible not found!"
  exit 1
}
echo "[INFO] Running Ansible playbook..."
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini pokemon_stack.yml

# --- AWS CLI Install ---
echo "[INFO] Installing AWS CLI..."
sudo apt install -y unzip curl
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# --- Docker Install ---
echo "[INFO] Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# --- Fix Docker Permissions for ubuntu user (no recursion) ---
echo "[INFO] Adding ubuntu to docker group..."
sudo usermod -aG docker ubuntu
# Apply group change once during provisioning (does NOT touch .bashrc)
sg docker -c "echo '[INFO] Docker group active during provisioning'"

# --- Game Setup ---
cd /home/ubuntu
git clone https://github.com/WhiskersStack/PokemonWithMongo.git
chown -R ubuntu:ubuntu /home/ubuntu/PokemonWithMongo

# --- Fallback: Add minimal requirements.txt if missing ---
if [ ! -f /home/ubuntu/PokemonWithMongo/requirements.txt ]; then
  echo "[INFO] Creating minimal requirements.txt with pymongo + requests"
  cat <<'REQ' >/home/ubuntu/PokemonWithMongo/requirements.txt
pymongo
requests
REQ
fi

# --- Create Dockerfile for game ---
cat <<'EOF' >/home/ubuntu/PokemonWithMongo/Dockerfile
FROM python:3.12-slim

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python3", "main.py"]
EOF

# --- Build Docker Image ---
cd /home/ubuntu/PokemonWithMongo
sudo docker build -t pokemon-game .

# --- Update .bashrc to auto-run game in Docker on SSH ---
cat <<'EOF' >> /home/ubuntu/.bashrc

# Auto-launch Pokémon game in Docker on SSH
if [ -n "$SSH_CONNECTION" ] && [ -z "$POKEMON_GAME_LAUNCHED" ]; then
  export POKEMON_GAME_LAUNCHED=1
  export PRIVATE_IP_DB=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=Database" \
    --query "Reservations[*].Instances[*].PrivateIpAddress" \
    --output text)

  cd ~/PokemonWithMongo
  docker run --rm -it \
    -e PRIVATE_IP_DB="$PRIVATE_IP_DB" \
    pokemon-game
fi
EOF


echo "[DONE] SSH into this instance and the Pokémon game will auto-launch inside Docker (connected to remote MongoDB)."
