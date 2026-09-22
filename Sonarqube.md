
## SonarQube High Availability (HA) Documentation
<p align="center">
<img width="300" height="150" alt="Sonarqube--Streamline-Svg-Logos (2)" src="https://github.com/user-attachments/assets/c9d95441-a521-4332-a11d-71157ac46abb" />
</p>


# Document Information

| Author   | Created On | Version | L0 Reviewer   | L1 Reviewer       | L2 Reviewer     |
| :------- | :--------- | :------ | :------------ | :---------------- | :-------------- |
| Amrendra | 23-09-2026 | 1.0     | Shubham Rathi / Sunny | Shreya J / Nikita | Piyush Upadhyay |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [What is SonarQube HA?](#2-what-is-sonarqube-ha)
3. [Why SonarQube HA?](#3-why-sonarqube-ha)
4. [Different Methods for HA](#4-different-methods-for-ha)
5. [Workflow Diagram](#5-workflow-diagram)
6. [How HA of SonarQube Will Be Done](#6-how-ha-of-sonarqube-will-be-done)
7. [Advantages](#7-advantages)
8. [Disadvantages](#8-disadvantages)
9. [Best Practices](#9-best-practices)
10. [Conclusion](#10-conclusion)
11. [Contact Information](#11-contact-information)
12. [References](#12-references)

---

# 1. Introduction

This document provides a simple guide on how to set up High Availability (HA) for SonarQube to prevent downtime.
It explains the core concepts, methods, setup steps, and best practices to keep code quality checks running without interruption.

---

# 2. What is SonarQube HA?

SonarQube HA means running SonarQube across multiple servers instead of just one single server. If one server crashes or needs maintenance, the other servers continue to handle requests automatically so developers can scan their code without any interruption.

---

# 3. Why SonarQube HA?

| Reason                          | Without HA (Single Server)                                                   | With HA (Multiple Servers)                                          |
| :------------------------------ | :--------------------------------------------------------------------------- | :------------------------------------------------------------------ |
| **No Build Failures**     | If SonarQube stops, CI/CD pipelines fail and PRs cannot be merged.           | Pipelines continue to scan and pass Quality Gates without stopping. |
| **Faster Scan Times**     | Only one worker queue exists, causing delays when many developers scan code. | Multiple worker nodes process scan reports at the same time.        |
| **Zero-Downtime Updates** | Upgrades or server reboots require stopping the service completely.          | Servers can be updated one by one without stopping developer work.  |
| **Disaster Recovery**     | A server crash causes hours of complete downtime until restored.             | Backup servers take over automatically within seconds to minutes.   |

---

# 4. Different Methods for HA

| Method                                            | How It Works                                                                        | Failover Time       | Required Edition                   | Best For                                                       |
| :------------------------------------------------ | :---------------------------------------------------------------------------------- | :------------------ | :--------------------------------- | :------------------------------------------------------------- |
| **Method 1: Multi-Node Cluster**            | Runs 2+ App nodes and 3 Search nodes in active-active mode behind a Load Balancer.  | 0 seconds (Instant) | Data Center Edition                | Large teams with heavy build traffic needing zero downtime.    |
| **Method 2: Active-Passive (Warm Standby)** | 1 Primary node runs actively; 1 Standby node is ready to start if Primary fails.    | 3 to 5 minutes      | Community / Developer / Enterprise | Small to mid-size teams looking for simple, low-cost failover. |
| **Method 3: Kubernetes Cloud-Native**       | Runs SonarQube in a container on Kubernetes with auto-restart and persistent disks. | 1 to 2 minutes      | Community / Developer / Enterprise | Teams already using Kubernetes (EKS / GKE / AKS).              |

---

# 5. Workflow Diagram


<img width="760" height="480" alt="sonarqube" src="https://github.com/user-attachments/assets/b5da8152-c167-479e-9751-798ad9edf257" />


### Workflow Steps:

| Step | Stage | Description |
| :--- | :--- | :--- |
| **1** | **CI/CD & Users** | Developers and build runners (Jenkins / GitLab) submit code analysis reports over HTTPS. |
| **2** | **Load Balancer** | AWS ALB or NGINX receives traffic on Port 443 and routes it to healthy application nodes. |
| **3** | **Application Nodes** | Two active-active nodes run Web Server (:9000) and Compute Engine (CE) workers in parallel. |
| **4** | **Search Cluster** | Exactly 3 dedicated Elasticsearch nodes maintain quorum and handle issue indexing. |
| **5** | **Database HA** | AWS RDS PostgreSQL Multi-AZ automatically replicates data and provides 30–60s failover. |

---

# 6. How HA of SonarQube Will Be Done

| Step             | Component                              | Action                             | Key Configuration / Details                                                                                                               |
| :--------------- | :------------------------------------- | :--------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------- |
| **Step 1** | **Load Balancer** (ALB / NGINX)  | Setup SSL & Traffic Routing        | • Listen on Port`443` (HTTPS) and forward to Port `9000`• Health check path: `/api/system/status`• Enable cookie sticky sessions |
| **Step 2** | **Application Nodes** (Web + CE) | Deploy 2 App Nodes (Active-Active) | • Set`sonar.cluster.enabled=true`• Set `sonar.cluster.node.type=application`• Point to 3 search nodes and shared database          |
| **Step 3** | **Search Nodes** (Elasticsearch) | Deploy 3 Dedicated Search Nodes    | • Set`sonar.cluster.enabled=true`• Set `sonar.cluster.node.type=search`• 3 nodes maintain quorum to prevent split-brain            |
| **Step 4** | **Database HA** (PostgreSQL)     | Setup Clustered Database           | • Deploy AWS RDS PostgreSQL Multi-AZ• Primary (Read/Write) + Standby replica• Automated failover in 30–60 seconds                     |
| **Step 5** | **Shared Storage** (EFS / NFS)   | Mount Shared File System           | • Mount to`/opt/sonarqube/extensions/plugins`• Ensures identical plugins across all application nodes                                 |

---

# 7. Advantages

| Advantage                  | Description                                                                      |
| :------------------------- | :------------------------------------------------------------------------------- |
| **Zero Downtime**    | Traffic automatically routes to healthy servers if any single server crashes.    |
| **High Performance** | Multiple Compute Engine workers process many code scans simultaneously.          |
| **Safe Maintenance** | Servers can be updated or restarted one by one without stopping developer work.  |
| **Data Protection**  | Continuous database replication ensures scan history and metrics are never lost. |

---

# 8. Disadvantages

| Disadvantage / Challenge         | Why It Happens                                       | Simple Solution                                                              |
| :------------------------------- | :--------------------------------------------------- | :--------------------------------------------------------------------------- |
| **Licensing Cost**         | Official clustering requires Data Center Edition.    | Use Kubernetes or Active-Passive setup for Community/Developer edition.      |
| **More Servers to Manage** | Requires at least 5 servers (2 App + 3 Search + DB). | Use Terraform to automate server provisioning and management.                |
| **Network Speed**          | Search and App nodes require low latency.            | Keep all nodes within the same cloud region across local availability zones. |

---

# 9. Best Practices

| Best Practice                        | Why It Is Important                                                                                      |
| :----------------------------------- | :------------------------------------------------------------------------------------------------------- |
| **Always Use 3 Search Nodes**  | An odd number of search nodes (minimum 3) is required to maintain quorum and prevent split-brain errors. |
| **Monitor Health Endpoints**   | Monitor`/api/system/health` continuously (Green = Normal, Yellow = Degraded, Red = Down).              |
| **Automated Database Backups** | Take daily automated snapshots and enable point-in-time recovery (PITR).                                 |
| **Keep Nodes in Same Region**  | Maintain low network latency (< 2 ms) between application, search, and database nodes.                   |
| **Set System Limits**          | Set`vm.max_map_count=262144` and `ulimit -n 131072` on all Linux host machines.                      |

---

# 10. Conclusion

SonarQube High Availability ensures that code quality checks and CI/CD pipelines run continuously without downtime.
By using redundant application nodes, a 3-node search cluster, and a replicated database, teams achieve seamless failover and faster scan processing.

---

# 11. Contact Information

| Name     | Email                                                                                |
| :------- | :----------------------------------------------------------------------------------- |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

# 12. References

| Resource Name                               | Link                                                                                                         |
| :------------------------------------------ | :----------------------------------------------------------------------------------------------------------- |
| SonarQube Cluster Installation Guide        | [SonarQube](https://docs.sonarsource.com/sonarqube/latest/setup-and-upgrade/install-the-server-as-a-cluster/) |
| SonarQube Hardware & Sizing Recommendations | [Hardware](https://docs.sonarsource.com/sonarqube/latest/setup-and-upgrade/hardware-recommendations/)         |
| PostgreSQL High Availability Guide          | [PostgreSQL](https://www.postgresql.org/docs/current/high-availability.html)                                  |
| AWS RDS Multi-AZ Deployments                | [RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html)                           |
