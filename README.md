Here’s your enhanced `README.md` with icons and emoji:

---

````markdown
# 🧩 Pokémon Terraform Docker Deployment on AWS ☁️

This project automates the infrastructure and deployment of a Pokémon game and its backend using **Terraform**, **Docker**, **Ansible**, and **AWS EC2**.

---

## 🚀 Project Highlights

- 🏗️ **Terraform** provisions the infrastructure (2 EC2 instances)
- 🐳 **Docker** runs the Pokémon game, Flask API, and MongoDB
- 🤖 **Ansible** configures the DB instance post-deployment
- ⚙️ Fully automated from CLI to app launch

---

## 🧵 Flow Overview

1. ✅ **Download the project**
2. 🔐 **Authenticate with AWS CLI**
3. 🛠️ **Run Terraform**: 
   - Provisions two EC2 instances
   - Sets up security groups, key pairs, and triggers init scripts
4. 🤖 **Ansible** configures the DB instance:
   - Installs Docker
   - Deploys Flask API + MongoDB in separate containers
5. 🕹️ The **game instance** runs a Dockerized Pokémon game

---

## 🗺️ Architecture Diagram

```text
+------------+        +-----------+         +------------------+
| AWS CLI    | -----> | Terraform | ----->  | EC2 (Game) 🕹️     |
|            |        |           |         | - Pokémon Game 🐉 |
+------------+        +-----------+         +------------------+
                             |
                             v
                    +---------------------------+
                    | EC2 (DB/Backend) 🛢️         |
                    | - Flask API (Docker) 🐍     |
                    | - MongoDB (Docker) 🍃       |
                    +---------------------------+
````

---

## 🧰 Prerequisites

* ✅ AWS CLI configured
* ✅ Terraform installed
* ✅ Ansible installed (locally or in EC2)
* ✅ SSH key pair for EC2 access
* ✅ IAM user with EC2 + VPC permissions

---

## 📦 Setup Instructions

```bash
# 🧱 Initialize Terraform
terraform init

# 🔍 Preview the changes
terraform plan

# 🚀 Apply the infrastructure
terraform apply
```

Terraform will:

* Launch EC2 instances
* Trigger instance setup via `user_data`
* Run Ansible on the DB instance to install and deploy containers

---

## 📌 Notes

* MongoDB and Flask are deployed in **separate containers**
* All setup is done automatically through **init scripts**
* The Pokémon game runs independently and connects to the Flask API

---

## 📄 License

MIT © 2025

---

## 📬 Contact

Need help? Open an issue or message me!

---
