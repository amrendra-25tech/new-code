#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "=== Validating SSH Connectivity across Security Boundaries ==="

TF_DIR="${PROJECT_ROOT}/terraform"
BASTION_IP=$(cd "${TF_DIR}" && terraform output -raw bastion_public_ip)
MONITORING_IP=$(cd "${TF_DIR}" && terraform output -raw monitoring_private_ip)
KEY_NAME="monitoring-ec2-key"
KEY_FILE="${TF_DIR}/${KEY_NAME}.pem"

echo "Testing Bastion SSH Connectivity (${BASTION_IP})..."
ssh -i "${KEY_FILE}" -o StrictHostKeyChecking=no -o ConnectTimeout=10 ubuntu@${BASTION_IP} "echo Bastion Reachable"

echo "Testing Private Monitoring Server SSH Connectivity via Bastion (${MONITORING_IP})..."
ssh -i "${KEY_FILE}" -o StrictHostKeyChecking=no -o ConnectTimeout=10 -J ubuntu@${BASTION_IP} ubuntu@${MONITORING_IP} "echo Monitoring Server Reachable"

echo "SSH Connectivity Checks Passed!"
