# Golang Installation via Bash Script
<p align="center">
<img width="200" height="150" alt="Go-Logo_Aqua" src="https://github.com/user-attachments/assets/950bb6ed-9301-4c7b-b2d3-0abc7082a718" />
</p>


## Document Information

| **Author** | **Created on** | **Version** | **Last Edited On** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | ------------------------ | --------------------- | --------------------- | --------------------- |
| Amrendra         | 30-08-2026           | 1.1               | 07-09-2026               | Shubham Rathi         | Shreya J/Nikita       | Piyush Upadhyay       |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Pre-requisites](#2-pre-requisites)
3. [Golang Installation via Bash Script](#3-golang-installation-via-bash-script)
4. [Script Explanation](#4-script-explanation)
5. [Verification](#5-verification)
6. [Best Practices](#6-best-practices)
7. [Contact Information](#7-contact-information)
8. [References](#8-references)

---

## 1. Introduction

This document explains how to install Golang on Ubuntu using a Bash script, enabling automated and repeatable setup for development or production environments.

---

## 2. Pre-requisites

| **Pre-requisite**    | **Requirement / Description**                    |
| -------------------------- | ------------------------------------------------------ |
| **Operating System** | Ubuntu 20.04 / 22.04 / 24.04 (Linux)                   |
| **User Privileges**  | `sudo` / root administrative access                  |
| **Network Access**   | Outbound internet connectivity (to download Go binary) |

---

## 3. Golang Installation via Bash Script

Create a script file:

```bash
nano install-go.sh
```

Add the following content:

```bash
#!/bin/bash

# Define Go version (default: 1.22.0 or pass argument e.g. 1.23.0)
GO_VERSION=${1:-1.22.0}

# Update system packages
sudo apt update -y

# Download Go binary
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz

# Remove any existing Go installation
sudo rm -rf /usr/local/go

# Extract Go
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

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

Run the script (installs default version 1.22.0):

```bash
./install-go.sh
```

Or install / upgrade to any specific version:

```bash
./install-go.sh 1.23.0
```

---

## 4. Script Explanation

| **Command / Step**                        | **Description**                                                          |
| ----------------------------------------------- | ------------------------------------------------------------------------------ |
| `GO_VERSION=${1:-1.22.0}`                     | Dynamically accepts target Go version as an argument, or defaults to 1.22.0    |
| `sudo apt update -y`                          | Updates local package repository index                                         |
| `wget https://...`                            | Downloads the official Go archive for the specified version                    |
| `sudo rm -rf /usr/local/go`                   | Removes previous Go installation to enable clean version upgrades              |
| `sudo tar -C /usr/local -xzf ...`             | Extracts Go package into`/usr/local` directory                               |
| `export PATH=...` & `echo ... >> ~/.bashrc` | Appends Go binary path to`PATH` in both active shell and `.bashrc` profile |
| `source ~/.bashrc`                            | Reloads environment variables in the user's shell configuration                |
| `go version`                                  | Verifies the installed or upgraded Go version                                  |

---

## 5. Verification

| **Verification Step**      | **Command** | **Expected Result**                                               |
| -------------------------------- | ----------------- | ----------------------------------------------------------------------- |
| **Check Go Version**       | `go version`    | Displays installed Go version (e.g.`go version go1.22.0 linux/amd64`) |
| **Check Environment PATH** | `echo $PATH`    | `/usr/local/go/bin` is present in the `PATH` string                 |

---

## 6. Best Practices

| **Best Practice**      | **Recommendation / Description**                                                |
| ---------------------------- | ------------------------------------------------------------------------------------- |
| **Version Stability**  | Always deploy official and stable Go releases                                         |
| **Routine Updates**    | Keep the Go environment updated to receive security patches                           |
| **Version Management** | Utilize version managers or explicit paths if multi-version environments are required |
| **Version Control**    | Maintain the installation script in a centralized Git repository                      |

---

## 7. Contact Information

| Name     | Email                                                                                |
| -------- | ------------------------------------------------------------------------------------ |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

## 8. References

| Topic            | Link                                      |
| ---------------- | ----------------------------------------- |
| Go Official Docs | [https://go.dev/doc/](https://go.dev/doc/) |
| Go Downloads     | [https://go.dev/dl/](https://go.dev/dl/)   |
