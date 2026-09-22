## Cloud Infrastructure Design & Dev Documentation

<p align="center">
 <img width="256" height="256" alt="image" src="https://github.com/user-attachments/assets/b0044854-bf55-4fb4-82e2-6a4199a6eb22" />

</p>

# Document Information

| Author   | Created On | Version | L0 Reviewer           | L1 Reviewer       | L2 Reviewer     |
| :------- | :--------- | :------ | :-------------------- | :---------------- | :-------------- |
| Amrendra | 23-09-2026 | 1.0     | Shubham Rathi / Sunny | Shreya J / Nikita | Piyush Upadhyay |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
3. [Infrastructure Diagram](#3-infrastructure-diagram)
4. [Description of the Infrastructure](#4-description-of-the-infrastructure)
5. [Security Groups and NACL Details](#5-security-groups-and-nacl-details)
6. [Conclusion](#6-conclusion)
7. [Contact Information](#7-contact-information)
8. [References](#8-references)

---

# 1. Introduction

This document provides a simple and clear overview of the cloud infrastructure design for the **Cloud Infra Design Dev** ticket.
It details the network setup, required cloud resources, and firewall security rules needed to build a secure and highly available cloud environment.

---

# 2. Prerequisites

| Category                    | Requirement                 | Details / Purpose                                               |
| :-------------------------- | :-------------------------- | :-------------------------------------------------------------- |
| **Cloud Account**     | AWS / Azure / GCP Account   | IAM permissions for VPC, EC2, Subnets, and Route Tables.        |
| **IaC Tool**          | Terraform (>= 1.5.0)        | For automated and repeatable infrastructure provisioning.       |
| **CLI Tool**          | AWS CLI / Azure CLI         | To verify credentials and manage resources from the terminal.   |
| **SSH Key**           | RSA 2048-bit Key (`.pem`) | For secure remote administrative access to instances.           |
| **Network Knowledge** | CIDR & Subnetting           | Basic understanding of IP ranges (`10.0.0.0/16`) and routing. |

---

# 3. Infrastructure Diagram

<img width="1002" height="852" alt="infrastructure-multi-az" src="https://github.com/user-attachments/assets/65eda204-6338-430d-88c0-b2d7d55dcbb7" />




### Workflow Steps:

| Step        | Stage                            | Description                                                                      |
| :---------- | :------------------------------- | :------------------------------------------------------------------------------- |
| **1** | **User Requests**          | Users send HTTPS requests from the internet to the domain name.                  |
| **2** | **Internet Gateway (IGW)** | Passes external traffic into the public subnet of the VPC.                       |
| **3** | **Load Balancer (ALB)**    | Receives traffic on Port 443 and distributes it to healthy application servers.  |
| **4** | **Application Servers**    | Process requests inside private subnets without having public IP addresses.      |
| **5** | **Database Tier**          | Stores data securely in isolated subnets accessible only by application servers. |
| **6** | **Outbound Updates**       | Application servers download patches safely through the NAT Gateway and IGW.     |

---

# 4. Description of the Infrastructure

| Layer              | Resource Name               | Sizing / CIDR                    | Purpose & Requirement                                                |
| :----------------- | :-------------------------- | :------------------------------- | :------------------------------------------------------------------- |
| **Network**  | Virtual Private Cloud (VPC) | `10.0.0.0/16` (65,536 IPs)     | Provides an isolated private network container in the cloud.         |
| **Tier 1**   | Public Subnets (2x AZs)     | `10.0.1.0/24`, `10.0.4.0/24` | Hosts the internet-facing Load Balancer and NAT Gateway.             |
| **Tier 2**   | Private Subnets (2x AZs)    | `10.0.2.0/24`, `10.0.5.0/24` | Hosts application servers; blocks direct inbound internet traffic.   |
| **Tier 3**   | Database Subnets (2x AZs)   | `10.0.3.0/24`, `10.0.6.0/24` | Hosts isolated database instances with zero direct internet access.  |
| **Routing**  | Internet Gateway (IGW)      | 1 per VPC                        | Enables communication between public subnet and the internet.        |
| **Egress**   | NAT Gateway                 | 1 per Public Subnet              | Allows private servers to download updates from the internet safely. |
| **Compute**  | EC2 Instances               | `t3.medium` (2 vCPU, 4GB RAM)  | Runs application services and business logic.                        |
| **Database** | AWS RDS PostgreSQL          | `db.t3.medium` (Multi-AZ)      | Stores application data with automatic backups and failover.         |

---

# 5. Security Groups and NACL Details

### Security Groups (Stateful - Instance Level)

| Security Group       | Inbound Rules                                              | Outbound Rules                                  | Purpose                                                      |
| :------------------- | :--------------------------------------------------------- | :---------------------------------------------- | :----------------------------------------------------------- |
| **`sg-alb`** | Port`80` (HTTP), Port `443` (HTTPS) from `0.0.0.0/0` | Port`8080` to `sg-app`                      | Accepts external web traffic and forwards it to app servers. |
| **`sg-app`** | Port`8080` from `sg-alb` only                          | Port`5432` to `sg-db`, Port `443` via NAT | Protects app instances from direct public internet exposure. |
| **`sg-db`**  | Port`5432` from `sg-app` only                          | None (Response traffic handled statefully)      | Restricts database access strictly to backend app servers.   |

### Network Access Control Lists (Stateless - Subnet Level)

| Subnet            | Rule # | Direction        | Protocol | Port Range              | Source / Destination            | Action          |
| :---------------- | :----- | :--------------- | :------- | :---------------------- | :------------------------------ | :-------------- |
| **Public**  | 100    | Inbound          | TCP      | 80, 443                 | `0.0.0.0/0`                   | **ALLOW** |
| **Public**  | 110    | Inbound          | TCP      | 1024–65535 (Ephemeral) | `0.0.0.0/0`                   | **ALLOW** |
| **Public**  | 100    | Outbound         | ALL      | ALL                     | `0.0.0.0/0`                   | **ALLOW** |
| **Private** | 100    | Inbound          | TCP      | 8080                    | `10.0.1.0/24` (Public Subnet) | **ALLOW** |
| **Private** | 110    | Inbound          | TCP      | 1024–65535 (Ephemeral) | `0.0.0.0/0` (via NAT)         | **ALLOW** |
| **Private** | 100    | Outbound         | TCP      | 443                     | `0.0.0.0/0` (via NAT)         | **ALLOW** |
| **Private** | 110    | Outbound         | TCP      | 5432                    | `10.0.3.0/24` (DB Subnet)     | **ALLOW** |
| **All**     | *      | Inbound/Outbound | ALL      | ALL                     | `0.0.0.0/0`                   | **DENY**  |

---

# 6. Conclusion

This cloud infrastructure design provides a secure, reliable, and scalable environment for deploying application workloads.
By using tiered subnets and strict firewall rules, backend systems and databases remain completely protected from unauthorized access.

---

# 7. Contact Information

| Name     | Email                                                                                |
| :------- | :----------------------------------------------------------------------------------- |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

# 8. References

| Resource Name                               | Link                                                                                         |
| :------------------------------------------ | :------------------------------------------------------------------------------------------- |
| AWS Well-Architected Framework              | [AWS Architecture](https://aws.amazon.com/architecture/well-architected/)                     |
| Amazon VPC and Subnets Documentation        | [Amazon VPC](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)               |
| Security Groups and Network ACLs Comparison | [AWS Security](https://docs.aws.amazon.com/vpc/latest/userguide/infrastructure-security.html) |
| AWS RDS Multi-AZ Deployments Guide          | [Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html)    |
