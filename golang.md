# Golang Installation via Bash Script

<p align="center">
<img width="200" height="150" alt="Go-Logo_Aqua" src="https://github.com/user-attachments/assets/950bb6ed-9301-4c7b-b2d3-0abc7082a718" />
</p>

## Document Information

| **Author** | **Created on** | **Version** | **Last Edited On** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | ------------------------ | --------------------- | --------------------- | --------------------- |
| Amrendra         | 30-08-2026           | 1.2              | 10-09-2026               | Shubham Rathi         | Shreya J/Nikita       | Piyush Upadhyay       |

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

# Exit immediately if a command fails
set -e

# Define Go version
# Default: 1.22.0
# Example: ./install-go.sh 1.23.0
GO_VERSION=${1:-1.22.0}

# Go download URL
GO_URL="https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"

# Temporary download location
GO_ARCHIVE="/tmp/go${GO_VERSION}.linux-amd64.tar.gz"

echo "======================================"
echo "Installing Go ${GO_VERSION}"
echo "======================================"

# Update system packages
echo "[1/6] Updating system packages..."
sudo apt update -y

# Download Go
echo "[2/6] Downloading Go ${GO_VERSION}..."
wget -q -O "$GO_ARCHIVE" "$GO_URL"


# Remove existing Go installation
echo "[3/6] Removing existing Go installation..."
sudo rm -rf /usr/local/go

# Extract Go
echo "[4/6] Extracting Go..."
sudo tar -C /usr/local -xzf "$GO_ARCHIVE"

# Remove downloaded archive
echo "[5/6] Cleaning up..."
rm -f "$GO_ARCHIVE"

# Add Go to PATH if not already present
if ! grep -q '/usr/local/go/bin' ~/.bashrc; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
fi

# Reload .bashrc
source ~/.bashrc

# Verify installation
echo "[6/6] Verifying Go installation..."
go version

echo "======================================"
echo "Go ${GO_VERSION} installed successfully!"
echo "======================================"
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

| **Command / Step**               | **Description**                                                                          |
| -------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `set -e`                             | Immediately stops script execution if any command fails                                        |
| `GO_VERSION=${1:-1.22.0}`            | Sets target Go version from argument or defaults to 1.22.0                                     |
| `GO_URL=...` & `GO_ARCHIVE=...`    | Defines the official download URL and specifies`/tmp` as the download path                   |
| `sudo apt update -y`                 | Updates local package repository index                                                         |
| `wget -q -O "$GO_ARCHIVE" "$GO_URL"` | Downloads the Go archive quietly to the`/tmp` directory                                      |
| `if [ ! -f "$GO_ARCHIVE" ]`          | Validates archive existence to prevent extracting a missing or failed download                 |
| `sudo rm -rf /usr/local/go`          | Removes previous Go installation to guarantee a clean version upgrade                          |
| `sudo tar -C /usr/local -xzf ...`    | Extracts Go binaries into`/usr/local` directory                                              |
| `rm -f "$GO_ARCHIVE"`                | Deletes the downloaded archive from`/tmp` to prevent disk clutter                            |
| `if ! grep -q ...`                   | Appends Go binary path to`~/.bashrc` only if not already present, avoiding duplicate entries |
| `source ~/.bashrc`                   | Reloads environment variables in the user's shell configuration                                |
| `go version`                         | Verifies the installed or upgraded Go version                                                  |

---

## 5. Verification

| **Verification Step**      | **Command** | **Expected Result**                                               |
| -------------------------------- | ----------------- | ----------------------------------------------------------------------- |
| **Check Go Version**       | `go version`    | Displays installed Go version (e.g.`go version go1.22.0 linux/amd64`) |
| **Check Environment PATH** | `echo $PATH`    | `/usr/local/go/bin` is present in the `PATH` string                 |

---

## 6. Best Practices

| **Best Practice**              | **Recommendation / Description**                                                     |
| ------------------------------------ | ------------------------------------------------------------------------------------------ |
| **Version Stability**          | Always deploy official and stable Go releases                                              |
| **Routine Updates**            | Keep the Go environment updated to receive security patches                                |
| **Use `/tmp` for Downloads** | Download temporary archives to`/tmp` so working directories remain clean                 |
| **Immediate Cleanup**          | Delete the`.tar.gz` archive immediately after extraction to conserve disk space          |
| **Idempotent Profile Updates** | Check`~/.bashrc` before appending `PATH` to avoid duplicate lines on repeated upgrades |
| **Fail Fast (`set -e`)**     | Use`set -e` to prevent partial or corrupted installations when a command fails           |
| **Version Control**            | Maintain the installation script in a centralized Git repository                           |

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
