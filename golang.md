# Golang  Installation via Bash Script

---

## Author Table

| **Author** | **Created on** | **Version** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | --------------------- | --------------------- | --------------------- |
| Amrendra         | 30-08-2026           | v1.0              | Shubham Rathi         | Shreya J/Nikita       | Piyush Upadhyay       |

---

## Table of Contents

1. [Introduction](#introduction)
2. [Purpose](#purpose)
3. [Why Use Bash Script for Installation](#why-use-bash-script-for-installation)
4. [Prerequisites](#prerequisites)
5. [Golang Installation via Bash Script](#golang-installation-via-bash-script)
6. [Script Explanation](#script-explanation)
7. [Verification](#verification)
8. [Use Cases](#use-cases)
9. [Best Practices](#best-practices)
10. [Contact Information](#contact-information)
11. [References](#references)

---

## Introduction

This document contains step-by-step procedures for creating and running the Bash script, detailed script explanations, installation verification methods, use cases, best practices, FAQs, author contact information, and reference links.

---

## Purpose

This document explains how to install Golang on Ubuntu using a Bash script, enabling automated and repeatable setup for development or production environments.

---

## Why Use Bash Script for Installation

Using a Bash script provides several advantages:

* Automates repetitive installation steps
* Ensures consistent environment setup
* Saves time in multi-system deployments
* Integrates easily with CI/CD pipelines

---

## Prerequisites

* Ubuntu 20.04 / 22.04 / 24.04
* sudo privileges
* Internet access

---

## Golang Installation via Bash Script

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

## Script Explanation

* `apt update` → Updates package list
* `wget` → Downloads Go binary
* `rm -rf /usr/local/go` → Removes old installation
* `tar` → Extracts Go to system directory
* `PATH` → Adds Go binary to system path
* `go version` → Verifies installation

---

## Verification

Check Go version:

```bash
go version
```

Check environment:

```bash
echo $PATH
```

Expected Result:

* Go version should be displayed
* Go binary path should be available in PATH

---

## Use Cases

* Setting up development environments
* Cloud-native application development
* CI/CD pipeline initialization
* Kubernetes and DevOps tooling

---

## Best Practices

* Use stable Go versions
* Keep Go updated
* Use version management tools if required
* Maintain scripts in version control

---

## Contact Information

| Name     | Email                                                                                |
| -------- | ------------------------------------------------------------------------------------ |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

## References

| Topic            | Link                                      |
| ---------------- | ----------------------------------------- |
| Go Official Docs | [https://go.dev/doc/](https://go.dev/doc/) |
| Go Downloads     | [https://go.dev/dl/](https://go.dev/dl/)   |
