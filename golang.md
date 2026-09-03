#  Golang Installation via Bash Script
<p align="center">
<img width="200" height="150" alt="Go-Logo_Aqua" src="https://github.com/user-attachments/assets/950bb6ed-9301-4c7b-b2d3-0abc7082a718" />
</p>


## Author Table

| **Author** | **Created on** | **Version** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------- | -------------- | ----------- | --------------- | --------------- | --------------- |
| Amrendra   | 30-08-2026     | 1.0        | Shubham Rathi   | Shreya J/Nikita | Piyush Upadhyay |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
3. [Golang Installation via Bash Script](#3-golang-installation-via-bash-script)
4. [Script Explanation](#4-script-explanation)
5. [Verification](#5-verification)
6. [Best Practices](#6-best-practices)
7. [Contact Information](#7-contact-information)
8. [References](#8-references)

---

## 1. Introduction

This document contains prerequisites, step-by-step procedures for creating and running the Bash script, detailed script explanations, installation verification methods, best practices, author contact information, and reference links.

---

## 2. Prerequisites

| **Prerequisite** | **Requirement / Description** |
| ---------------- | ----------------------------- |
| **Operating System** | Ubuntu 20.04 / 22.04 / 24.04 (Linux) |
| **User Privileges** | `sudo` / root administrative access |
| **Network Access** | Outbound internet connectivity (to download Go binary) |

---

## 3. Golang Installation via Bash Script

Create a script file:

```bash
nano install-go.sh
```

Add the following content:

```bash
#!/bin/bash

# Update system packages
sudo apt update -y

# Download Go binary
wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz

# Remove any existing Go installation
sudo rm -rf /usr/local/go

# Extract Go
sudo tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz

# Set environment variables
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc

# Reload environment
source ~/.bashrc

# Verify installation
go version
```

Make the script executable:

```bash
chmod +x install-go.sh
```

Run the script:

```bash
./install-go.sh
```

---

## 4. Script Explanation

| **Command / Step** | **Description** |
| ------------------ | --------------- |
| `sudo apt update -y` | Updates the local package index to ensure package availability |
| `wget https://...` | Downloads the official Go binary archive from `go.dev` |
| `sudo rm -rf /usr/local/go` | Removes any prior Go directory to prevent stale/conflicting files |
| `sudo tar -C /usr/local -xzf ...` | Extracts the Go archive into `/usr/local` directory |
| `export PATH=...` & `echo ... >> ~/.bashrc` | Appends Go binary path to `PATH` in both active shell and `.bashrc` profile |
| `source ~/.bashrc` | Reloads environment variables in the user's shell configuration |
| `go version` | Executes the compiler command to verify successful installation |

---

## 5. Verification

| **Verification Step** | **Command** | **Expected Result** |
| --------------------- | ----------- | ------------------- |
| **Check Go Version** | `go version` | `go version go1.21.0 linux/amd64` |
| **Check Environment PATH** | `echo $PATH` | `/usr/local/go/bin` is present in the `PATH` string |

---

## 6. Best Practices

| **Best Practice** | **Recommendation / Description** |
| ----------------- | -------------------------------- |
| **Version Stability** | Always deploy official and stable Go releases |
| **Routine Updates** | Keep the Go environment updated to receive security patches |
| **Version Management** | Utilize version managers or explicit paths if multi-version environments are required |
| **Version Control** | Maintain the installation script in a centralized Git repository |

---

## 7. Contact Information

| Name     | Email                                                                                |
| -------- | ------------------------------------------------------------------------------------ |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

## 8. References

| Topic            | Link                                       |
| ---------------- | ------------------------------------------ |
| Go Official Docs | [https://go.dev/doc/](https://go.dev/doc/) |
| Go Downloads     | [https://go.dev/dl/](https://go.dev/dl/)   |
