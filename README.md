# Enterprise DevOps Monitoring Infrastructure (Terraform + Ansible + Jenkins + AWS)

## 📌 Project Overview
This enterprise-grade DevOps project provides an automated, modular, and production-ready CI/CD infrastructure solution for deploying a robust observability stack on Amazon Web Services (AWS). Using **Terraform**, **Ansible**, and **Jenkins**, the pipeline automatically provisions VPC networks, secure bastions, private monitoring nodes, and installs **Prometheus**, **Grafana OSS**, and **Node Exporter**.

---

## 🏗 AWS Architecture
The infrastructure is strictly compartmentalized following AWS Well-Architected Framework principles:

```
+---------------------------------------------------------------------------------------------------+
| AWS Cloud (us-east-1)                                                                             |
|                                                                                                   |
|  +---------------------------------------------------------------------------------------------+  |
|  | VPC (10.0.0.0/16)                                                                          |  |
|  |                                                                                             |  |
|  |   +---------------------------------------+   +-----------------------------------------+   |  |
|  |   | Public Subnet 1 (10.0.1.0/24)          |   | Private Subnet 1 (10.0.10.0/24)         |   |  |
|  |   | AZ: us-east-1a                        |   | AZ: us-east-1a                          |   |  |
|  |   |                                       |   |                                         |   |  |
|  |   |  +---------------------------------+  |   |  +-----------------------------------+  |   |  |
|  |   |  | Bastion Host                    |  |   |  | Private Monitoring Server        |  |   |  |
|  |   |  | - Elastic IP / Public IP        |  |   |  | - No Public IP                       |  |   |  |
|  |   |  | - Security Group: Allow SSH     |--+---+->| - Prometheus (Port 9090)             |  |   |  |
|  |   |  +---------------------------------+  |   |  | - Grafana (Port 3000)                |  |   |  |
|  |   |                                       |   |  | - Node Exporter (Port 9100)          |  |   |  |
|  |   |  +---------------------------------+  |   |  +-----------------------------------+  |   |  |
|  |   |  | NAT Gateway (with Elastic IP)   |--+---+--------------------+                     |   |  |
|  |   |  +---------------------------------+  |   |                    | (Outbound Internet) |   |  |
|  |   +---------------------------------------+   +--------------------+--------------------+   |  |
|  |                       |                                            |                        |  |
|  |                       v                                            v                        |  |
|  |             Internet Gateway (IGW)                        Route Table (Private)             |  |
|  +-----------------------+---------------------------------------------------------------------+  |
+--------------------------|------------------------------------------------------------------------+
                           v
                     Internet / Admins
```

* **VPC**: `10.0.0.0/16`
* **Subnets**: 2 Public Subnets (`10.0.1.0/24`, `10.0.2.0/24`) and 2 Private Subnets (`10.0.10.0/24`, `10.0.20.0/24`).
* **Security Model**: Only the Bastion Host has a public IP. The Monitoring Host lives in a Private Subnet and only accepts SSH (Port 22) ingress directly from the Bastion Security Group.

---

## 🛠 Terraform Workflow
Terraform is structured modularly with 11 custom modules (`vpc`, `subnet`, `internet_gateway`, `nat_gateway`, `route_table`, `security_group`, `ec2`, `iam`, `keypair`, `cloudwatch`, `s3_backend`).

### S3 Backend & State Locking Architecture Note
The Terraform state is stored securely in an Amazon S3 bucket with versioning and AES256 server-side encryption enabled.
* **Why DynamoDB state locking is omitted (per requirement)**: DynamoDB distributed locking prevents race conditions during parallel builds. By omitting DynamoDB locking, team members and Jenkins pipelines must execute sequentially (Concurrency = 1) to prevent state file corruption.

---

## 🔄 Jenkins Pipeline Workflow
The project features a 16-stage declarative Jenkins pipeline (`Jenkinsfile`):
1. **Checkout GitHub Repository**
2. **Terraform Init**
3. **Terraform Validate**
4. **Terraform fmt**
5. **Terraform Plan**
6. **Terraform Apply / Destroy**
7. **Generate Dynamic Ansible Inventory**
8. **Test SSH Connectivity**
9. **Execute Ansible Playbooks**
10. **Install Prometheus**
11. **Install Grafana**
12. **Install Node Exporter**
13. **Verify Services**
14. **Display Outputs**
15. **Archive Logs**
16. **Cleanup Workspace**

---

## ⚙️ Ansible Workflow
Ansible configuration management is divided across 8 modular roles:
1. `common`: System utilities and baseline packages.
2. `users`: Creation of administrative DevOps users and sudo privileges.
3. `firewall`: Host-level UFW firewall definitions.
4. `docker`: Docker container engine setup.
5. `prometheus`: Systemd deployment and TSDB configuration.
6. `grafana`: Grafana OSS deployment with automated Prometheus datasource and dynamic dashboard provisioning.
7. `node_exporter`: Kernel and hardware metrics collector.
8. `monitoring`: Automated endpoint integration and health checks.

---

## 🚀 Installation & Deployment Guide

### Prerequisites
* AWS CLI configured with administrator credentials.
* Terraform `>= 1.5.0` and Ansible `>= 2.14`.
* Jenkins server with Git, AWS Credentials Plugin, and SSH Agent Plugin.

### Quick Local Deployment via Script
```bash
# Clone repository
git clone https://github.com/your-org/monitoring-project.git
cd monitoring-project

# Run one-touch deployment
bash scripts/deploy.sh
```

### Manual Execution Steps
```bash
# 1. Provision Infrastructure
cd terraform
terraform init
terraform apply -auto-approve
cd ..

# 2. Generate Inventory & Validate Connectivity
bash scripts/inventory.sh
bash scripts/validate.sh

# 3. Apply Configuration Management
cd ansible
ansible-playbook -i inventory/hosts.yml playbooks/site.yml
cd ..

# 4. Run Verification
bash scripts/healthcheck.sh
```

---

## 🧹 Destroy Guide
To safely teardown all AWS resources and avoid incurring unwanted charges:
```bash
bash scripts/destroy.sh
```

---

## 🔍 Troubleshooting & Verification
* **SSH Connection Denied**: Verify that your public key corresponds to the private key output in `terraform/enterprise-monitoring-key.pem` and that permissions are set to `0600`.
* **Grafana Login**: Access Grafana on port `3000` via SSH tunneling. Default credentials are standard admin / configured secure variables.
* **Prometheus Targets**: Verify targets at `http://localhost:9090/targets` to ensure Node Exporter status is `UP`.

---

## 🛡 Security Best Practices
* **Zero Direct Exposure**: Monitoring instances do not possess public IPv4 addresses.
* **Least Privilege Security Groups**: Ingress is restricted by security group references rather than broad IP ranges.
* **Key Encryption**: Encrypted root volumes (`gp3`) and S3 bucket server-side encryption.

---

## 💰 Cost Estimation (AWS Monthly Approximation)
* 1x Bastion Host (`t3.micro`): ~$7.50 / month
* 1x Monitoring Host (`t3.medium`): ~$30.00 / month
* 1x NAT Gateway + EIP: ~$32.00 / month + data transfer
* **Total Estimated Cost**: ~$70.00 USD / month (Eligible for AWS Free Tier discounts where applicable).

---

## 🚀 Future Improvements
* Add AWS DynamoDB table for automated state locking.
* Implement SSL/TLS termination using AWS ALB (Application Load Balancer) and Route53.
* Add Slack/PagerDuty alerting rules to Prometheus Alertmanager.
