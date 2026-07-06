#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "=== Generating Dynamic Ansible Inventory from Terraform Outputs ==="

TF_DIR="${PROJECT_ROOT}/terraform"
INV_FILE="${PROJECT_ROOT}/ansible/inventory/hosts.yml"

BASTION_IP=$(cd "${TF_DIR}" && terraform output -raw bastion_public_ip)
MONITORING_IP=$(cd "${TF_DIR}" && terraform output -raw monitoring_private_ip)
KEY_NAME="monitoring-ec2-key"
KEY_FILE_RELATIVE_TO_ANSIBLE="../terraform/${KEY_NAME}.pem"

cat <<EOF > "${INV_FILE}"
all:
  children:
    bastion:
      hosts:
        bastion_host:
          ansible_host: ${BASTION_IP}
          ansible_user: ubuntu
          ansible_ssh_private_key_file: ${KEY_FILE_RELATIVE_TO_ANSIBLE}
    monitoring:
      hosts:
        monitoring_server:
          ansible_host: ${MONITORING_IP}
          ansible_user: ubuntu
          ansible_ssh_private_key_file: ${KEY_FILE_RELATIVE_TO_ANSIBLE}
          ansible_ssh_common_args: '-o ProxyCommand="ssh -i ${KEY_FILE_RELATIVE_TO_ANSIBLE} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -W %h:%p -q ubuntu@${BASTION_IP}"'
EOF

echo "Ansible inventory successfully generated at ${INV_FILE}:"
cat "${INV_FILE}"
