# React JS Installation via Bash Script

<p align="center">
<img width="200" height="150" alt="Go-Logo_Aqua" src="https://github.com/user-attachments/assets/950bb6ed-9301-4c7b-b2d3-0abc7082a718" />
</p>


## Document Information

| **Author** | **Created on** | **Version** | **Last Edited On** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------- | -------------- | ----------- | ------------------ | --------------- | --------------- | --------------- |
| Amrendra   | 03-09-2026     | 1.1        | 11-09-2026         | Shubham Rathi   | Shreya J/Nikita | Piyush Upadhyay |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Pre-requisites](#2-pre-requisites)
3. [React JS Installation via Bash Script](#3-react-js-installation-via-bash-script)
4. [Script Explanation](#4-script-explanation)
5. [Verification](#5-verification)
6. [Best Practices](#6-best-practices)
7. [Contact Information](#7-contact-information)
8. [References](#8-references)

---

## 1. Introduction

This document explains how to install and upgrade React JS on Ubuntu using a Bash script, enabling automated and repeatable setup for development or production environments.

---

## 2. Pre-requisites

| **Pre-requisite** | **Requirement / Description** |
| ---------------- | ----------------------------- |
| **Operating System** | Ubuntu 20.04 / 22.04 / 24.04 (Linux) |
| **User Privileges** | `sudo` / root administrative access |
| **Network Access** | Outbound internet connectivity (to download packages) |

---

## 3. React JS Installation via Bash Script

Create a script file:

```bash
nano install-react.sh
```

Add the following content:

```bash
#!/bin/bash

# Exit immediately if a command fails
set -e

# Define React version
# Default: latest
# Example: ./install-react.sh 18.2.0
REACT_VERSION=${1:-latest}

echo "======================================"
echo "Installing React JS ${REACT_VERSION}"
echo "======================================"

# Update system packages
echo "[1/5] Updating system packages..."
sudo apt update -y

# Install curl
echo "[2/5] Ensuring curl is installed..."
sudo apt install -y curl

# Install Node.js LTS and npm if not already present
echo "[3/5] Setting up Node.js LTS and npm..."
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
else
    echo "Node.js ($(node -v)) and npm ($(npm -v)) are already installed."
fi

# Install or upgrade React and ReactDOM globally
echo "[4/5] Installing/Upgrading React and ReactDOM (${REACT_VERSION})..."
sudo npm install -g react@${REACT_VERSION} react-dom@${REACT_VERSION}

# Verify installation
echo "[5/5] Verifying installation..."
node -v
npm -v
npm list -g react react-dom

echo "======================================"
echo "React JS ${REACT_VERSION} installed successfully!"
echo "======================================"
```

Make the script executable:

```bash
chmod +x install-react.sh
```

Run the script (installs the latest stable version by default):

```bash
./install-react.sh
```

Or install/upgrade to a specific React version:

```bash
./install-react.sh 18.2.0
```

---

## 4. Script Explanation

| **Command / Step** | **Description** |
| ------------------ | --------------- |
| `set -e` | Immediately stops script execution if any command fails |
| `REACT_VERSION=${1:-latest}` | Sets target React version from argument or defaults to latest |
| `sudo apt update -y` | Updates local package repository index |
| `sudo apt install -y curl` | Ensures curl utility is installed for repository retrieval |
| `if ! command -v node ...` | Checks if Node.js/npm exist, installing NodeSource v20 LTS if missing |
| `sudo npm install -g react@...` | Installs or upgrades React and ReactDOM globally to the target version |
| `node -v` & `npm -v` | Checks and displays installed Node.js and npm versions |
| `npm list -g react react-dom` | Verifies and displays the installed React and ReactDOM versions |

---

## 5. Verification

| **Verification Step** | **Command** | **Expected Result** |
| --------------------- | ----------- | ------------------- |
| **Check Node.js Version** | `node -v` | Node.js version is displayed (e.g., `v20.x.x`) |
| **Check npm Version** | `npm -v` | npm version is displayed (e.g., `10.x.x`) |
| **Check React Version** | `npm list -g react react-dom` | Installed React and ReactDOM versions are displayed |

---

## 6. Best Practices

| **Best Practice** | **Recommendation / Description** |
| ----------------- | -------------------------------- |
| **Node.js LTS** | Always deploy official Node.js Long Term Support (LTS) versions |
| **Version Pinning** | Explicitly specify React versions (e.g., `18.2.0`) in production environments |
| **Routine Updates** | Regularly update Node.js, npm, and dependencies for security patches |
| **Version Control** | Maintain the installation script in a centralized Git repository |

---

## 7. Contact Information

| Name     | Email                                                                                |
| -------- | ------------------------------------------------------------------------------------ |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

## 8. References

| Topic | Link |
| ----- | ---- |
| React Official Docs | [https://react.dev/](https://react.dev/) |
| NodeSource Distributions | [https://github.com/nodesource/distributions](https://github.com/nodesource/distributions) |
| npm Documentation | [https://docs.npmjs.com/](https://docs.npmjs.com/) |
