<p align="center">
<img width="236" height="133" alt="image" src="https://github.com/user-attachments/assets/d7efe372-b200-414b-9a50-77407e880158" />
</p>

---

# Ansible Role CD Workflow

---

# Author Table

| Author       | Created on | Version | L0 Reviewer     | L1 Reviewer    | L2 Reviewer        |
| ------------ | ---------- | ------- | --------------- | -------------- | ------------------ |
| Riya Chauhan | 01-10-2026 | v1.0    | Deepak kushwaha | Faisal/Mohit K | Mahesh kumar/Varun |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [What and Why Ansible Role CD](#2-what-and-why-ansible-role-cd)
3. [How the Ansible Role is Deployed in Target Environments](#3-how-the-ansible-role-is-deployed-in-target-environments)
4. [Deployment Steps](#4-deployment-steps)
5. [Environment Requirements](#5-environment-requirements)
6. [Best Practices](#6-best-practices)
7. [Continuous Delivery vs Continuous Deployment](#7-continuous-delivery-vs-continuous-deployment)
8. [Advantages](#8-advantages)
9. [FAQs](#9-faqs)
10. [Contact Information](#10-contact-information)
11. [References](#11-references)

---

## 1. Introduction

This document explains how Ansible roles are deployed in target environments, including steps, prerequisites, and best practices.
It details what and why Ansible Role CD is used to achieve automated, consistent, and zero-drift server deployments.

---

## 2. What and Why Ansible Role CD

| Topic                              | Description                                                                                         |
| ---------------------------------- | --------------------------------------------------------------------------------------------------- |
| **What is an Ansible Role?** | A modular, reusable package of tasks, handlers, variables, and templates.                           |
| **What is Ansible Role CD?** | Automated process to fetch, test, version, and apply role configurations to target servers.         |
| **Why use Ansible Role CD?** | Eliminates manual server configuration, stops configuration drift, and ensures repeatable releases. |
| **Role CD vs Playbook CD**   | Role CD publishes and deploys reusable modules; Playbook CD orchestrates full multi-tier workflows. |

---

## 3. How the Ansible Role is Deployed in Target Environments

| Mechanism                    | Description                                                               | Action                                                  |
| ---------------------------- | ------------------------------------------------------------------------- | ------------------------------------------------------- |
| **Role Packaging**     | Role is version-tagged in Git or published to private Ansible Galaxy.     | Tagged release (e.g.,`v1.0.0`).                       |
| **Role Ingestion**     | CI runner pulls the pinned role into the deployment workspace.            | Run`ansible-galaxy install -r requirements.yml`.      |
| **Inventory Mapping**  | Target hosts are selected dynamically or statically based on environment. | Match target host groups (e.g.,`webservers`, `db`). |
| **Execution Trigger**  | A deployment playbook executes the role tasks against target servers.     | Run`ansible-playbook -i inventory deploy.yml`.        |
| **Transport Layer**    | Ansible connects over SSH (Linux) or WinRM (Windows) using service keys.  | Authenticate and elevate privileges via`sudo`.        |
| **Target Application** | Role tasks apply desired state, copy files, and trigger handlers.         | Services configured and reloaded on change.             |
| **Health Check**       | Post-deployment validation confirms services are listening and healthy.   | Verify ports, endpoints, and systemd units.             |

---

## 4. Deployment Steps

| Step        | Stage                        | Description                                              | Key Activity                                                    |
| ----------- | ---------------------------- | -------------------------------------------------------- | --------------------------------------------------------------- |
| **1** | **Tag Release**        | Role is tagged with a semantic version after passing CI. | Create release tag in Git (e.g.,`v1.2.0`).                    |
| **2** | **Update Manifest**    | Deployment project pins the new role version tag.        | Update version in`requirements.yml`.                          |
| **3** | **Fetch Role**         | CI/CD runner downloads the specified role version.       | Run`ansible-galaxy install -r requirements.yml --force`.      |
| **4** | **Dry-Run Check**      | Pipeline simulates changes against target servers.       | Execute`ansible-playbook -i hosts deploy.yml --check --diff`. |
| **5** | **Live Deployment**    | Tasks execute on target servers in controlled batches.   | Execute`ansible-playbook -i hosts deploy.yml`.                |
| **6** | **State Verification** | Pipeline runs automated health checks on target nodes.   | Check service status and application endpoints.                 |
| **7** | **Idempotency Test**   | Second run verifies that no unintended changes happen.   | Ensure second execution returns`changed=0`.                   |

---

## 5. Environment Requirements

| Category                    | Component        | Requirement                                                  |
| --------------------------- | ---------------- | ------------------------------------------------------------ |
| **Control Node (CI)** | Ansible Core     | Ansible version 2.15+ with Python 3.9+.                      |
| **Control Node (CI)** | Tools            | Git,`ansible-core`, and `ansible-galaxy` CLI.            |
| **Control Node (CI)** | Secrets          | SSH private keys and Ansible Vault password configured.      |
| **Target Nodes**      | Operating System | Ubuntu 20.04+, Debian 11+, RHEL 8+, or Rocky Linux.          |
| **Target Nodes**      | Runtime          | Python 3 installed on all target instances.                  |
| **Target Nodes**      | Network & Ports  | Port 22 (SSH) accessible from the CI control runner.         |
| **Target Nodes**      | User Access      | Automation user configured with passwordless`sudo` rights. |
| **Target Nodes**      | SSH Keys         | CI runner public key added to`~/.ssh/authorized_keys`.     |

---

## 6. Best Practices

| Best Practice                 | Purpose                                        | Implementation                                      |
| ----------------------------- | ---------------------------------------------- | --------------------------------------------------- |
| **Semantic Versioning** | Prevent unexpected breaking changes.           | Tag roles as`vMAJOR.MINOR.PATCH`.                 |
| **Version Pinning**     | Ensure reproducible deployments.               | Always lock version tag in`requirements.yml`.     |
| **Idempotent Tasks**    | Prevent repeated or breaking task runs.        | Design all tasks so re-running causes zero changes. |
| **Dry-Run Mode**        | Detect unexpected state drift before deploy.   | Run with`--check --diff` in pipeline gates.       |
| **Rolling Updates**     | Maintain service uptime during deployment.     | Use`serial: 2` or `serial: "30%"` in playbooks. |
| **Automated Rollback**  | Restore service quickly on deployment failure. | Re-run deployment using previous stable role tag.   |

---

## 7. Continuous Delivery vs Continuous Deployment

| Model                           | Trigger                 | Deployment Action                         | Target Scope         |
| ------------------------------- | ----------------------- | ----------------------------------------- | -------------------- |
| **Continuous Delivery**   | Automated CI tests pass | Deploys after manual approval             | Staging & Production |
| **Continuous Deployment** | Automated CI tests pass | Deploys automatically without manual gate | Dev & QA             |

---

## 8. Advantages

| Advantage                   | Benefit                                                         |
| --------------------------- | --------------------------------------------------------------- |
| **Modularity**        | Single role reused across multiple environments and teams.      |
| **Consistency**       | Exact same configuration applied across all target servers.     |
| **Zero Drift**        | Target environments always match the Git-versioned state.       |
| **Auditability**      | Every infrastructure change is tracked to a Git commit and tag. |
| **High Availability** | Rolling batch deployments prevent application downtime.         |

---

## 9. FAQs

| Question                                                                  | Answer                                                                                 |
| ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| **Q1. What is the difference between Playbook CD and Role CD?**     | Role CD releases reusable components; Playbook CD executes them on infrastructure.     |
| **Q2. How is the role pulled to target environments?**              | The CD runner runs`ansible-galaxy install -r requirements.yml` before execution.     |
| **Q3. How are sensitive secrets protected during role deployment?** | Secrets are encrypted using Ansible Vault and decrypted at runtime via CI credentials. |
| **Q4. What happens if a deployment task fails midway?**             | Deployment halts and an automated rollback triggers with the prior stable tag.         |

---

## 10. Contact Information

| Name         | Email ID                                                                         |
| ------------ | -------------------------------------------------------------------------------- |
| Riya Chauhan | [riya.chauhan.snaatak@mygurukulam.co](mailto:riya.chauhan.snaatak@mygurukulam.co) |

---

## 11. References

| Description                         | Link                                                                                        |
| ----------------------------------- | ------------------------------------------------------------------------------------------- |
| Official Ansible role documentation | [Ansible](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html) |
| Molecule testing framework guide    | [Molecule](https://ansible.readthedocs.io/projects/molecule/)                                |
| Jenkins pipeline documentation      | [Jenkins](https://www.jenkins.io/doc/)                                                       |
