#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

echo "=== Performing Infrastructure Service Health Verification ==="

TF_DIR="${PROJECT_ROOT}/terraform"
BASTION_IP=$(cd "${TF_DIR}" && terraform output -raw bastion_public_ip)
MONITORING_IP=$(cd "${TF_DIR}" && terraform output -raw monitoring_private_ip)
KEY_NAME="monitoring-ec2-key"
KEY_FILE="${TF_DIR}/${KEY_NAME}.pem"

echo "Testing Prometheus Endpoint (9090)..."
ssh -i "${KEY_FILE}" -o StrictHostKeyChecking=no -J ubuntu@${BASTION_IP} ubuntu@${MONITORING_IP} "curl -s http://localhost:9090/-/healthy" | grep -q "Prometheus Server is Healthy" && echo "Prometheus: OK"

echo "Testing Grafana Endpoint (3000)..."
ssh -i "${KEY_FILE}" -o StrictHostKeyChecking=no -J ubuntu@${BASTION_IP} ubuntu@${MONITORING_IP} "curl -s http://localhost:3000/api/health" | grep -q "ok" && echo "Grafana: OK"

echo "Testing Node Exporter Endpoint (9100)..."
ssh -i "${KEY_FILE}" -o StrictHostKeyChecking=no -J ubuntu@${BASTION_IP} ubuntu@${MONITORING_IP} "curl -s http://localhost:9100/metrics" | grep -q "node_cpu_seconds_total" && echo "Node Exporter: OK"

echo "All Endpoints verified operational!"
