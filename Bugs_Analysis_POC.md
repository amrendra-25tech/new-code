# POC: Go CI Checks | Bug Analysis

## Author Information

| **Author** | **Created On** | **Version** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | --------------------- | --------------------- | --------------------- |
| Amrendra         | 01-10-2026           | 1.0               | Shubham Rathi / Sunny | Shreya J / Nikita     | Piyush Upadhyay       |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Pre-requisites](#2-pre-requisites)
3. [Step-by-Step Setup Guide](#3-step-by-step-setup-guide)
   - [3.1 Verify Go Environment](#31-verify-go-environment)
   - [3.2 Pre-Validation with go vet](#32-pre-validation-with-go-vet)
   - [3.3 Install golangci-lint](#33-install-golangci-lint)
   - [3.4 Verify golangci-lint Installation](#34-verify-golangci-lint-installation)
   - [3.5 Execute Bug Analysis Scan](#35-execute-bug-analysis-scan)
   - [3.6 Analyze Identified Findings](#36-analyze-identified-findings)
4. [Conclusion](#4-conclusion)
5. [Contact Information](#5-contact-information)
6. [References](#6-references)

---

# 1. Introduction

This Proof of Concept (POC) demonstrates static Bug Analysis for the Go-based Employee API using golangci-lint.
It covers tool installation, pre-validation checks, analysis execution, and findings review.

---

# 2. Pre-requisites

The following components are required to perform the bug analysis:

| Requirement             | Purpose                                                               |
| ----------------------- | --------------------------------------------------------------------- |
| **Ubuntu Linux**  | Operating system hosting the application environment.                 |
| **Go**            | Go compiler and runtime environment (`go1.20.14`).                  |
| **Git**           | Version control system to clone the Employee API repository.          |
| **Employee API**  | Go source code targeted for static bug analysis (`~/employee-api`). |
| **golangci-lint** | Fast, aggregate Go linter used to scan the codebase (v1.64.8).        |

---

# 3. Step-by-Step Setup Guide

### 3.1 Verify Go Environment

Navigate to the Employee API project directory:

```bash
cd ~/employee-api
```

Verify the installed Go version:

```bash
go version
```

Expected output:

```text
go version go1.20.14 linux/amd64
```

Verify that the Go modules and dependencies are present:

```bash
go mod tidy
```

<img width="1169" height="600" alt="image" src="https://github.com/user-attachments/assets/dc64d13c-1ab1-4d1a-8076-613cfe0c590b" />


---

### 3.2 Pre-Validation with go vet

Run the built-in Go static analysis tool to verify basic code syntax:

```bash
go vet ./...
```

Check the command exit status:

```bash
echo $?
```

Expected output:

```text
0
```

An exit code of `0` confirms that basic compiler checks pass without syntax errors.

<img width="739" height="175" alt="image" src="https://github.com/user-attachments/assets/f9591d49-9f4f-4e42-b05c-f58bf4502687" />


---

### 3.3 Install golangci-lint

Download and install the pinned version (`v1.64.8`) of `golangci-lint`:

```bash
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh -o /tmp/golangci-install.sh
sudo sh /tmp/golangci-install.sh -b /usr/local/bin v1.64.8
```

<img width="1515" height="119" alt="image" src="https://github.com/user-attachments/assets/ab421e53-eb1f-4be1-95f3-f7ccf267215e" />


---

### 3.4 Verify golangci-lint Installation

Verify that `golangci-lint` is installed and accessible in the system PATH:

```bash
golangci-lint version
```

Expected output:

```text
golangci-lint has version v1.64.8 built with go1.20.14
```

<img width="919" height="56" alt="image" src="https://github.com/user-attachments/assets/bdf42f08-f27d-44d5-b304-d7261af16089" />


---

### 3.5 Execute Bug Analysis Scan

Run `golangci-lint` across all packages in the Employee API repository:

```bash
cd ~/employee-api
golangci-lint run ./...
```

Check the command exit status:

```bash
echo $?
```

Expected output:

```text
1
```

An exit code of `1` indicates that the tool detected code defects and issues that require attention.

<img width="945" height="94" alt="image" src="https://github.com/user-attachments/assets/757e16d3-e28d-452b-842f-a4dc8ad03d9c" />


---

### 3.6 Analyze Identified Findings

The analysis reported a total of **11 code findings** across the project:

|      #      | File                        | Line | Analyzer        | Finding Description                                         |
| :----------: | --------------------------- | :--: | --------------- | ----------------------------------------------------------- |
| **1** | `main.go`                 |  47  | `errcheck`    | Return value of`router.Run` is not checked.               |
| **2** | `api/api.go`              |  71  | `errcheck`    | Return value of`json.Unmarshal` is not checked.           |
| **3** | `api/api.go`              |  95  | `errcheck`    | Return value of`json.Unmarshal` is not checked.           |
| **4** | `api/api.go`              | 128 | `errcheck`    | Return value of`json.Unmarshal` is not checked.           |
| **5** | `api/health_test.go`      |  82  | `errcheck`    | Return value of Redis`.Err()` is not checked.             |
| **6** | `api/api.go`              |  73  | `gosimple`    | Redundant`return` statement.                              |
| **7** | `api/api.go`              | 130 | `gosimple`    | Redundant`return` statement.                              |
| **8** | `api/api.go`              | 235 | `staticcheck` | Surrounding loop is unconditionally terminated.             |
| **9** | `client/scylladb_test.go` |  40  | `errcheck`    | Return value of`gocqlCreateSessionMock()` is not checked. |
| **10** | `config/viper_test.go`    |  36  | `errcheck`    | Return value of`viperReadInConfig()` is not checked.      |
| **11** | `config/viper.go`         |  19  | `ineffassign` | Assignment to variable`err` is ineffective.               |

### Summary by Analyzer

| Analyzer              | Findings Count | Defect Category                  |
| --------------------- | :------------: | -------------------------------- |
| **errcheck**    |       7       | Unhandled error return values    |
| **gosimple**    |       2       | Redundant code constructs        |
| **staticcheck** |       1       | Logic flaw in loop control flow  |
| **ineffassign** |       1       | Ineffective variable assignment  |
| **Total**       |  **11**  | **Actionable code issues** |

<img width="1418" height="777" alt="image" src="https://github.com/user-attachments/assets/2cffc2da-a5cc-41b4-a6ae-2237f9e8feb2" />


---

# 4. Conclusion

This Proof of Concept successfully demonstrated static Bug Analysis for the Go-based Employee API.

The scan detected 11 actionable code flaws including unhandled errors, redundant statements, and ineffective assignments.

**Chosen Tool:**
**golangci-lint** is chosen for our Go CI pipeline because it combines multiple linters into a single command, runs fast, and provides clear line-by-line findings.

---

# 5. Contact Information

|        Name        |          Email Address          |
| :----------------: | :-----------------------------: |
| **Amrendra** | amrendra.snaatak@mygurukulam.co |

---

# 6. References

| Reference                         | Link                                                        |
| --------------------------------- | ----------------------------------------------------------- |
| **golangci-lint**           | [golangci-lint](https://golangci-lint.run/)                  |
| **Go Vet**                  | [Vet](https://pkg.go.dev/cmd/vet)                            |
| **Staticcheck**             | [Staticcheck](https://staticcheck.dev/)                      |
| **errcheck**                | [errcheck](https://github.com/kisielk/errcheck)              |
| **ineffassign**             | [ineffassign](https://github.com/gordonklaus/ineffassign)    |
| **Employee API Repository** | [Employee](https://github.com/OT-MICROSERVICES/employee-api) |
