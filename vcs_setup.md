
# Detailed Documentation of VCS Setup
<p align="center"><img width="204" height="202" alt="GitFlow" src="https://git-scm.com/images/logos/downloads/Git-Icon-1788C.png" /></p>

---


## Document Information

| Author   | Created On | Version | L0 Reviewer     | L1 Reviewer | L2 Reviewer        |
| :------- | :--------- | :-----  | :-------------- | :---------- | :----------------- |
| Amrendra | 27-09-2026 | 1.0     | Shubham Rathi / Sunny | Shreya J / Nikita | Piyush Upadhyay |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [SaaS Solution vs. Local Setup (On-Prem) Comparison](#2-saas-solution-vs-local-setup-on-prem-comparison)
3. [VCS Setup Prerequisites](#3-vcs-setup-prerequisites)
4. [VCS Setup Steps](#4-vcs-setup-steps)
5. [Verification](#5-verification)
6. [Best Practices](#6-best-practices)
7. [Conclusion](#7-conclusion)
8. [Contact Information](#8-contact-information)
9. [References](#9-references)

---

# 1. Introduction

This document outlines the standard process for setting up and configuring a Version Control System (VCS) repository, incorporating an evaluation of SaaS versus Local (On-Prem) hosting solutions.
The purpose is to ensure that project source code is securely versioned, remotely backed up, and readily accessible for collaborative development and automated build pipelines.

---

# 2. SaaS Solution vs. Local Setup (On-Prem) Comparison

| Dimension                              | SaaS Solution (GitHub Cloud, GitLab SaaS)                                         | Local / On-Prem Setup (Self-Managed GitLab, Gitea)                               | Recommendation |
| :------------------------------------- | :-------------------------------------------------------------------------------- | :------------------------------------------------------------------------------- | :---------------------- |
| **Setup Time**                   | **< 15 minutes** (Instant provisioning, zero hardware required)             | **1 – 3 days** (Host provisioning, network, OS hardening, DB setup)       | **SaaS**          |
| **Maintenance Overhead**         | **Near Zero** (Managed entirely by vendor; zero patching or OS maintenance) | **High** (Requires dedicated SRE/DevOps for OS, DB, CVE patching, backups) | **SaaS**          |
| **Total Cost (< 100 Devs)**      | **Lower** (~$21/user/month; predictable subscription)                       | **Higher** (Server compute + storage + DevOps engineering hours)           | **SaaS**          |
| **Total Cost (> 1000 Devs)**     | **Higher** ($252,000+/year in per-seat licenses)                            | **Lower** (Fixed infrastructure + 1 dedicated SRE = ~$160k/yr)             | **On-Prem**       |
| **Data Sovereignty & Privacy**   | Shared cloud infrastructure; data stored outside corporate perimeter              | **100% internal control**; can be deployed completely air-gapped           | **On-Prem**       |
| **Network Latency & Speed**      | Bound by office WAN speed (50–100 Mbps); 3–5 min clone times for large repos    | **LAN gigabit speed (1–10 Gbps)**; sub-30s clone times                    | **On-Prem**       |
| **Git LFS & Large Assets**       | Strict per-GB storage and bandwidth overage charges ($0.08–$0.20/GB)             | Bound only by attached EBS/NFS/EFS storage cost ($0.023/GB)                      | **On-Prem**       |
| **High Availability (HA) & SLA** | **99.9% to 99.95% SLA** across multi-region availability zones              | Must architect multi-node DB, Redis, Gitaly/GlusterFS, and failover              | **SaaS**          |
| **Disaster Recovery (DR)**       | Managed snapshots and geo-replication handled by cloud vendor                     | SRE team must implement automated RPO/RTO backup verification drills             | **SaaS**          |
| **Compliance & Audits**          | Pre-certified SOC 1/2/3, ISO 27001, FedRAMP, HIPAA                                | Self-certified; company is 100% responsible for audit compliance                 | **SaaS**          |

---

# 3. VCS Setup Prerequisites

Before setting up a VCS repository, ensure the following requirements are met:

| Requirement                     | Purpose                                                                      |
| :------------------------------ | :--------------------------------------------------------------------------- |
| **Git installed**         | Required to execute Git commands on the system.                              |
| **VCS account**           | Required to create and manage remote repositories (GitHub/GitLab/Bitbucket). |
| **Authentication method** | Required for secure repository access (SSH Key or Personal Access Token).    |
| **Repository access**     | Required permissions to create, push, and manage the repository.             |
| **Project source code**   | Initial application files, documentation, and`.gitignore`.                 |

---

# 4. VCS Setup Steps

| Step                                     | Action                                                                | Command / Example                                                                                                  | Why Required                                                                                          |
| :--------------------------------------- | :-------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------- |
| **1. Install Git**                 | Install Git on the system.                                            | `sudo apt updatesudo apt install git -y`                                                                         | Git must be installed before using Git commands for version control.                                  |
| **2. Verify Git**                  | Check the installed Git version.                                      | `git --version`                                                                                                  | Confirms that Git has been installed correctly and is available on the system.                        |
| **3. Configure Git Identity**      | Configure the username and email address used for commits.            | `git config --global user.name "Amrendra"git config --global user.email "amrendra.yadav.snaatak@mygurukulam.co"` | Associates commits with the correct developer identity.                                               |
| **4. Configure Default Branch**    | Set the default branch name to`main`.                               | `git config --global init.defaultBranch main`                                                                    | Standardizes repository branch naming conventions across the team.                                    |
| **5. Create Remote Repository**    | Create a repository on GitHub, GitLab, or Bitbucket.                  | `VCS Console → New Repository`                                                                                  | Provides a remote location where project code is stored, backed up, and shared.                       |
| **6. Initialize Local Repository** | Initialize a new local Git repository.                                | `git init`                                                                                                       | Converts an existing local project directory into a Git repository and creates the`.git` directory. |
| **7. Check Status**                | Check the current state of the working directory and untracked files. | `git status`                                                                                                     | Identifies modified, deleted, staged, and untracked files before committing.                          |
| **8. Stage Initial Files**         | Add initial project files and`.gitignore` to the staging area.      | `git add .`                                                                                                      | Selects the initial files that will be included in the repository's baseline commit.                  |
| **9. Commit Changes**              | Create the baseline commit containing the staged files.               | `git commit -m "Initial project setup"`                                                                          | Creates an initial versioned snapshot of the repository.                                              |
| **10. Configure Remote**           | Connect the local repository to the remote VCS repository.            | `git remote add origin <repository-url>`                                                                         | Establishes the connection between the local repository and the remote repository.                    |
| **11. Verify Remote**              | Verify the configured remote repository URLs.                         | `git remote -v`                                                                                                  | Confirms that the correct remote repository URL is configured for fetch and push operations.          |
| **12. Push Initial Setup**         | Upload local commits to the remote repository.                        | `git push -u origin main`                                                                                        | Publishes local commits to the remote repository and sets upstream tracking.                          |

---

# 5. Verification

After completing the setup steps, verify the repository using the following commands:

```bash
git status
git remote -v
git branch
git log --oneline
```

### Expected Output:

<img width="1357" height="622" alt="output" src="https://github.com/user-attachments/assets/226977d3-d528-46cd-b088-54509f24abf2" />


These commands confirm that:

- The local working tree is clean.
- The remote `origin` is correctly mapped for fetch and push.
- The `main` branch tracks `origin/main`.
- The initial baseline commit has been successfully pushed to the remote repository.

---

# 6. Best Practices

| Best Practice                             | Description                                                                                |
| :---------------------------------------- | :----------------------------------------------------------------------------------------- |
| **Configure Global Identity**       | Ensure`user.name` and corporate email are configured properly before creating commits.   |
| **Set Default Branch to Main**      | Standardize`init.defaultBranch main` to avoid legacy `master` naming discrepancies.    |
| **Maintain a Clean `.gitignore`** | Include build artifacts, node_modules, cache, and`.env` files from repository inception. |
| **Use Secure Authentication**       | Prefer SSH keys (ed25519) or short-lived Personal Access Tokens over passwords.            |
| **Verify Remote URLs**              | Always verify remote connection strings with`git remote -v` before pushing code.         |
| **Avoid Committing Secrets**        | Never commit passwords, private keys, API secrets, or credentials to version control.      |

---

# 7. Conclusion

A properly executed VCS setup establishes the necessary foundation for source code version tracking, secure remote storage, and team accessibility. By completing the essential installation, identity configuration, initialization, and remote linking, the repository is verified and ready for project development and subsequent CI/CD automation.

---

# 8. Contact Information

| Name               | Email Address                                                                        |
| :----------------- | :----------------------------------------------------------------------------------- |
| **Amrendra** | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

# 9. References

| Resource                | Link                                     |
| :---------------------- | :--------------------------------------- |
| Git Documentation       | https://git-scm.com/docs                 |
| GitHub Documentation    | https://docs.github.com/                 |
| GitLab Documentation    | https://docs.gitlab.com/                 |
| Bitbucket Documentation | https://support.atlassian.com/bitbucket/ |
