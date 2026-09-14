
# React JS Installation via Bash Script

<p align="center">
<img width="200" height="150" alt="reactjs" src="https://github.com/user-attachments/assets/7b6b7423-113e-4903-a9cc-c084b26e14f5" />
</p>


## Document Information

| **Author** | **Created on** | **Version** | **Last Edited On** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | ------------------------ | --------------------- | --------------------- | --------------------- |
| Amrendra         | 03-09-2026           | 1.1              | 07-09-2026               | Shubham Rathi         | Shreya J/Nikita       | Piyush Upadhyay       |

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

| **Pre-requisite**    | **Requirement / Description**                   |
| -------------------------- | ----------------------------------------------------- |
| **Operating System** | Ubuntu 20.04 / 22.04 / 24.04 (Linux)                  |
| **User Privileges**  | `sudo` / root administrative access                 |
| **Network Access**   | Outbound internet connectivity (to download packages) |

---

## 3. React JS Installation via Bash Script

Create a script file:

```bash
nano install-react.sh
```

Add the following content:

```bash
#!/bin/bash

# React version
REACT_VERSION=${1:-latest}

# Update system and install curl
sudo apt update -y
sudo apt install -y curl

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Get currently installed React version
CURRENT_VERSION=$(npm list -g --depth=0 react 2>/dev/null | grep -oP 'react@\K[0-9.]+')

# Check React version
if [ "$CURRENT_VERSION" = "$REACT_VERSION" ]; then
    echo "React $REACT_VERSION is already installed."
    echo "Nothing to do."
else
    # Remove old React
    if [ -n "$CURRENT_VERSION" ]; then
        echo "Removing React $CURRENT_VERSION..."
        sudo npm uninstall -g react react-dom
    fi

    # Install requested version
    echo "Installing React $REACT_VERSION..."
    sudo npm install -g "react@$REACT_VERSION" "react-dom@$REACT_VERSION"
fi

# Verify
echo ""
echo "Installed React:"
npm list -g --depth=0 react react-dom
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

| **Command / Step**                                          | **Description**                                                           |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `REACT_VERSION=${1:-latest}`                                    | Sets target React version dynamically from argument or defaults to`latest`    |
| `sudo apt update -y && sudo apt install -y curl`                | Updates system package repository and ensures curl is available                 |
| `curl -fsSL ... \| sudo -E bash - && sudo apt install -y nodejs` | Configures NodeSource repository and installs Node.js LTS with npm              |
| `CURRENT_VERSION=$(npm list ...)`                               | Queries npm to detect currently installed global React version                  |
| `if [ "$CURRENT_VERSION" = "$REACT_VERSION" ]`                  | Compares installed version with target version to avoid redundant installations |
| `sudo npm uninstall -g react react-dom`                         | Removes previous React and ReactDOM packages cleanly before upgrading           |
| `sudo npm install -g "react@..." "react-dom@..."`               | Installs or upgrades React and ReactDOM globally to the target version          |
| `npm list -g --depth=0 react react-dom`                         | Displays installed top-level global React and ReactDOM versions                 |

---

## 5. Verification

| **Verification Step**     | **Command**                         | **Expected Result**                           |
| ------------------------------- | ----------------------------------------- | --------------------------------------------------- |
| **Check React Version**   | `npm list -g --depth=0 react react-dom` | Installed React and ReactDOM versions are displayed |
| **Check Node.js Version** | `node -v`                               | Node.js version is displayed (e.g.,`v20.x.x`)     |
| **Check npm Version**     | `npm -v`                                | npm version is displayed (e.g.,`10.x.x`)          |

---

## 6. Best Practices

| **Best Practice**   | **Recommendation / Description**                                                |
| ------------------------- | ------------------------------------------------------------------------------------- |
| **Node.js LTS**     | Always deploy official Node.js Long Term Support (LTS) versions                       |
| **Idempotency**     | Detect existing versions prior to installation to avoid unnecessary package downloads |
| **Clean Uninstall** | Remove older package versions before installing new ones to prevent package conflicts |
| **Version Pinning** | Explicitly specify React versions (e.g.,`18.2.0`) in production environments        |
| **Version Control** | Maintain the installation script in a centralized Git repository                      |

---

## 7. Contact Information

| Name     | Email                                                                                |
| -------- | ------------------------------------------------------------------------------------ |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

## 8. References

| Topic                    | Link                                                                                      |
| ------------------------ | ----------------------------------------------------------------------------------------- |
| React Official Docs      | [https://react.dev/](https://react.dev/)                                                   |
| NodeSource Distributions | [https://github.com/nodesource/distributions](https://github.com/nodesource/distributions) |
| npm Documentation        | [https://docs.npmjs.com/](https://docs.npmjs.com/)                                         |
