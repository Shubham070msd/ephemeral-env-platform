# Ephemeral Environment Deployment Platform

## 🧩 Objective

This project is a DevOps platform that allows developers to **deploy feature branches on-demand** into **temporary AWS environments**, primarily for QA testing. Each environment is **self-destructing after 24 hours** of inactivity, or can be destroyed manually.

---

## 🚀 Features

- CLI to input GitHub repo URL and branch name
- Checkout and deploy code from the specified branch
- Deploy infrastructure to AWS using Terraform
- Provision ECS Fargate + ALB + VPC with 2 public subnets
- Output a live deployment URL
- Auto-destroy inactive environments (simulated)
- Manual destroy option
- Clear evidence and documentation

---

## 🛠 Tech Stack

- **Terraform** for Infrastructure as Code
- **AWS ECS Fargate**, **ALB**, **Route Tables**, **VPC**
- **Bash scripts** for CLI, deploy, auto-destroy
- **GitHub** as source repo
- **nginxdemos/hello** used as sample container image

---

## 🖥️ How to Use


### 1. Deploy a New Branch
```bash
./scripts/deploy-from-branch.sh
# Enter repo URL and branch when prompted


### 2. Manual Cleanup Instructions
To manually remove the deployed environment, run the following script:
```bash
./scripts/destroy-env.sh

## Manual cleanup logic
This script goes into the Terraform folder and runs terraform destroy -auto-approve, which deletes all the AWS resources created during deployment. You can use this anytime to manually clean up the environment.

### 3.Auto-Destruct Script
```bash
./scripts/auto-destroy-check.sh

## Auto-destroy logic explanation
when a new environment is deployed, the current time is saved in a file called `deployed_at.txt`. A script named `auto-destroy-check.sh` checks this file to see how much time has passed. If more than 24 hours (or a set time) has passed, the script runs `terraform destroy` to delete all the resources automatically. This simulates the idea of auto-destroy after inactivity.
