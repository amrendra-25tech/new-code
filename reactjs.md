# React JS Installation via Bash Script

---

## Author Table

| **Author** | **Created on** | **Version** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | --------------------- | --------------------- | --------------------- |
| Amrendra         | 03-09-2026           | 1.0              | Shubham Rathi         | Shreya J/Nikita       | Piyush Upadhyay       |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
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

## 2. Prerequisites

| **Prerequisite**     | **Requirement / Description**                   |
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

# Target React version (default: latest, or pass e.g. 18.2.0)
REACT_VERSION=${1:-latest}

# Update system packages and install curl
sudo apt update -y && sudo apt install -y curl

# Install Node.js LTS and npm
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Install or upgrade React and ReactDOM globally
sudo npm install -g react@$REACT_VERSION react-dom@$REACT_VERSION

# Verify installation
node -v
npm -v
npm list -g react react-dom
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

| **Command / Step**                           | **Description**                                                     |
| -------------------------------------------------- | ------------------------------------------------------------------------- |
| `REACT_VERSION=${1:-latest}`                     | Sets target React version dynamically from argument or defaults to latest |
| `sudo apt update -y && sudo apt install -y curl` | Updates system package repository and ensures curl is available           |
| `curl -fsSL ... \| sudo -E bash -`                | Configures NodeSource repository for Node.js LTS (v20.x)                  |
| `sudo apt install -y nodejs`                     | Installs Node.js runtime and bundled npm package manager                  |
| `sudo npm install -g react@...`                  | Installs or upgrades React and ReactDOM globally to the desired version   |
| `node -v` & `npm -v`                           | Checks and displays installed Node.js and npm versions                    |
| `npm list -g react react-dom`                    | Verifies and displays the installed React and ReactDOM versions           |

---

## 5. Verification

| **Verification Step**     | **Command**               | **Expected Result**                           |
| ------------------------------- | ------------------------------- | --------------------------------------------------- |
| **Check Node.js Version** | `node -v`                     | Node.js version is displayed (e.g.,`v20.x.x`)     |
| **Check npm Version**     | `npm -v`                      | npm version is displayed (e.g.,`10.x.x`)          |
| **Check React Version**   | `npm list -g react react-dom` | Installed React and ReactDOM versions are displayed |

---

## 6. Best Practices

| **Best Practice**   | **Recommendation / Description**                                         |
| ------------------------- | ------------------------------------------------------------------------------ |
| **Node.js LTS**     | Always deploy official Node.js Long Term Support (LTS) versions                |
| **Version Pinning** | Explicitly specify React versions (e.g.,`18.2.0`) in production environments |
| **Routine Updates** | Regularly update Node.js, npm, and dependencies for security patches           |
| **Version Control** | Maintain the installation script in a centralized Git repository               |

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
