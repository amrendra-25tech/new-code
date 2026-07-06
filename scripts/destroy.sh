#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "========================================================"
echo " Starting Enterprise DevOps Stack Automated Destruction"
echo "========================================================"

cd "${PROJECT_ROOT}/terraform"
echo "--> Executing Terraform Destroy..."
terraform destroy -auto-approve

echo "========================================================"
echo " Infrastructure Successfully Destroyed!"
echo "========================================================"
