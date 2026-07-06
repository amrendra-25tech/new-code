#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "========================================================"
echo " Starting Enterprise DevOps Stack Automated Deployment"
echo "========================================================"

echo "--> Step 1: Terraform Init & Apply"
cd "${PROJECT_ROOT}/terraform"
terraform init
terraform apply -auto-approve

echo "--> Step 2: Generating Dynamic Ansible Inventory"
cd "${PROJECT_ROOT}"
bash "${SCRIPT_DIR}/inventory.sh"

echo "--> Step 3: Validating Network & SSH Connectivity"
bash "${SCRIPT_DIR}/validate.sh"

echo "--> Step 4: Executing Ansible Configuration Playbooks"
cd "${PROJECT_ROOT}/ansible"
ansible-playbook -i inventory/hosts.yml playbooks/site.yml

echo "--> Step 5: Service Verification & Endpoint Checks"
cd "${PROJECT_ROOT}"
bash "${SCRIPT_DIR}/healthcheck.sh"

echo "========================================================"
echo " Deployment Successfully Completed!"
echo "========================================================"
