# 🧩 Pokémon Terraform Docker Deployment on AWS ☁️

[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform)](https://www.terraform.io/)
[![Docker](https://img.shields.io/badge/Containers-Docker-2496ED?logo=docker)](https://www.docker.com/)
[![Ansible](https://img.shields.io/badge/Automation-Ansible-EE0000?logo=ansible)](https://www.ansible.com/)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazon-aws)](https://aws.amazon.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This project automates the infrastructure and deployment of a Pokémon game and its backend using **Terraform**, **Docker**, **Ansible**, and **AWS EC2** — all inside containerized environments. Perfect for developers, cloud learners, and game enthusiasts seeking a hands-on full-stack deployment experience.

<img width="1024" height="1536" alt="image" src="https://github.com/user-attachments/assets/7c34e741-4021-43b7-adca-aed496735370" />

---

## 🚀 Project Highlights

* 🏗️ Fully reproducible setup with Terraform
* 📦 EC2 instances provisioned with Docker and containerized services
* 🤖 Ansible automates backend configuration
* 🐳 Game and API run in isolated Docker containers
* ☁️ Cloud-native architecture with clean service separation
* 🔁 End-to-end automation: just `terraform apply` and go!

---

## 📊 Architecture Diagram

```text
+------------+        +-----------+         +-----------------------------+
| AWS CLI    | -----> | Terraform | ----->  | EC2 (Game) 🎮 (Dockerized)    |
|            |        |           |         | - Pokémon Game Client       |
+------------+        +-----------+         +-----------------------------+
                             |
                             v
                    +-----------------------------+
                    | EC2 (DB/Backend) 🛢️ (Dockerized) |
                    | - Flask API 🐍                 |
                    | - MongoDB 🍃                   |
                    +-----------------------------+
```

---

## 🧵 Deployment Flow

1. ✅ Clone the repository and authenticate with AWS CLI
2. ⚙️ Run Terraform to provision:

   * VPC, subnets, security groups, key pairs
   * Two EC2 instances:

     * 🛢️ DB EC2 (Flask + MongoDB)
     * 🎮 Game EC2 (Pokémon client)
3. ✨ Terraform executes `user_data` scripts to:

   * Install Docker
   * Pull and launch containers
   * Trigger Ansible playbook via remote script or cloud-init
4. ✅ Game and backend are up and running, securely networked within your AWS environment

---

## 🛠️ Prerequisites

* ✅ [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and authenticated
* ✅ [Terraform v1.4+](https://developer.hashicorp.com/terraform/downloads)
* ✅ [Ansible](https://docs.ansible.com/) (optional locally; auto-run via EC2)
* ✅ SSH key pair for EC2 access
* ✅ IAM permissions: EC2, VPC, IAM, and optionally SSM for advanced automation

---

## 📦 Setup Instructions

```bash
# 🔧 Initialize Terraform
terraform init

# 🔍 Preview changes
terraform plan

# 🚀 Deploy infrastructure
terraform apply
```

Terraform will:

* Launch EC2 instances with `user_data` for bootstrapping
* Configure VPC networking and firewall rules
* Automatically deploy Docker containers and services

---

## 🎮 Deployed Services

| Component    | Host     | Containerized | Description                |
| ------------ | -------- | ------------- | -------------------------- |
| Pokémon Game | EC2 Game | ✅ Yes         | Frontend game client       |
| Flask API    | EC2 DB   | ✅ Yes         | Serves game data endpoints |
| MongoDB      | EC2 DB   | ✅ Yes         | NoSQL database for storage |

---

## 🌟 Future Enhancements

* 📊 Add monitoring with Prometheus + Grafana
* 🔒 Enforce private-only access for MongoDB
* 📺 Build a web dashboard for the game via Flask
* 🧪 Add Docker Compose for full local dev support
* 🤝 Contributions are welcome! Open a PR with ideas or improvements

---

## 📄 License

MIT License © 2025

---

## 💬 Support / Contact

Have questions or issues? Open an issue on GitHub or drop a message via Discussions.

---
