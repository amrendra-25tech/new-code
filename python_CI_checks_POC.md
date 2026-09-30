# POC: Python CI Checks | DAST

## Author Information

| **Author** | **Created On** | **Version** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | --------------------- | --------------------- | --------------------- |
| Amrendra         | 29-09-2026           | 1.0               | Shubham Rathi / Sunny | Shreya J / Nikita     | Piyush Upadhyay       |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Pre-requisites](#2-pre-requisites)
3. [Step-by-Step Setup Guide](#3-step-by-step-setup-guide)
   - [3.1 Verify Attendance API &amp; OpenAPI](#31-verify-attendance-api--openapi)
   - [3.2 Start OWASP ZAP Daemon](#32-start-owasp-zap-daemon)
   - [3.3 Import and Discover API Endpoints](#33-import-and-discover-api-endpoints)
   - [3.4 Run Active DAST Scan](#34-run-active-dast-scan)
   - [3.5 Analyze Security Alerts](#35-analyze-security-alerts)
   - [3.6 Generate DAST Report](#36-generate-dast-report)
4. [Conclusion](#4-conclusion)
5. [Contact Information](#5-contact-information)
6. [References](#6-references)

---

# 1. Introduction

This Proof of Concept (POC) demonstrates DAST for the Python Attendance API using OWASP ZAP.
It covers endpoint discovery, security scanning, alert analysis, and report generation in a headless environment.

---

# 2. Pre-requisites

The following components are required to perform the DAST scan:

| Requirement                     | Purpose                                                           |
| ------------------------------- | ----------------------------------------------------------------- |
| **Ubuntu Linux**          | Operating system running on the EC2 instance.                     |
| **Python & Gunicorn**     | Runtime and WSGI server running the Attendance API on port 8080.  |
| **PostgreSQL**            | Database backend for the Attendance service.                      |
| **Redis**                 | In-memory cache for application data.                             |
| **OWASP ZAP 2.17.0**      | DAST security scanner running in daemon mode on port 8090.        |
| **OpenAPI Specification** | JSON definition (`apispec_1.json`) used for endpoint discovery. |

---

# 3. Step-by-Step Setup Guide

### 3.1 Verify Attendance API & OpenAPI

Verify that the Attendance API service is healthy:

```bash
curl -i http://127.0.0.1:8080/api/v1/attendance/health
```

Expected response:
<img width="1087" height="284" alt="image" src="https://github.com/user-attachments/assets/16582d50-3bb2-4ceb-9d75-5c53f4d7b09e" />


Save and verify the OpenAPI JSON specification:

```bash
mkdir -p /home/ubuntu/zap-reports
curl -s http://127.0.0.1:8080/apispec_1.json -o /home/ubuntu/zap-reports/apispec_1.json
ls -lh /home/ubuntu/zap-reports/apispec_1.json
```

<img width="1209" height="63" alt="image" src="https://github.com/user-attachments/assets/5856c05f-d126-4b54-8995-8d3b69be1cfc" />


---

### 3.2 Start OWASP ZAP Daemon

Start OWASP ZAP in headless daemon mode on port 8090:

```bash
/opt/zap/zap.sh -daemon -port 8090 -host 127.0.0.1 -config api.disablekey=true
```
<img width="1691" height="900" alt="image" src="https://github.com/user-attachments/assets/140e6911-95a8-424d-a374-4bafb5717ec8" />

Verify that ZAP is running:

```bash
curl "http://127.0.0.1:8090/JSON/core/view/version/"
```

Expected output:

```json
{"version":"2.17.0"}
```
<img width="873" height="177" alt="image" src="https://github.com/user-attachments/assets/c1c2c74d-bc60-4c93-81a7-4dd0f93fe26d" />


---

### 3.3 Import and Discover API Endpoints

Import the OpenAPI specification URL into ZAP for automated endpoint discovery:

```bash
curl "http://127.0.0.1:8090/JSON/openapi/action/importUrl/?url=http%3A%2F%2F127.0.0.1%3A8080%2Fapispec_1.json"
```

Verify the discovered endpoints:

```bash
curl "http://127.0.0.1:8090/JSON/core/view/urls/?baseurl=http%3A%2F%2F127.0.0.1%3A8080"
```

Discovered endpoints include:

- `POST /api/v1/attendance/create`
- `GET  /api/v1/attendance/search`
- `GET  /api/v1/attendance/search/all`
- `GET  /api/v1/attendance/health`
- `GET  /api/v1/attendance/health/detail`

<img width="1671" height="179" alt="image" src="https://github.com/user-attachments/assets/bdd65315-0f8d-4d4f-b491-912875dd8663" />


---

### 3.4 Run Active DAST Scan

Start the active vulnerability scan:

```bash
curl "http://127.0.0.1:8090/JSON/ascan/action/scan/?url=http%3A%2F%2F127.0.0.1%3A8080%2Fapi%2Fv1%2Fattendance&recurse=true&inScopeOnly=false"
```

Expected output:

<img width="1617" height="99" alt="image" src="https://github.com/user-attachments/assets/b1c3dd6a-bbc9-47fc-b2be-ea2de6129baa" />

Monitor scan progress until completion:

```bash
curl "http://127.0.0.1:8090/JSON/ascan/view/status/?scanId=0"
```

Expected output:

```json
{"status":"100"}
```
<img width="1036" height="212" alt="image" src="https://github.com/user-attachments/assets/8048f056-9660-4f4b-a231-fa2788b21488" />


---

### 3.5 Analyze Security Alerts

Retrieve all detected security alerts from ZAP:

```bash
curl "http://127.0.0.1:8090/JSON/core/view/alerts/"
```

Summary of detected findings:

| Alert                                                   | ZAP Risk      | Confidence |
| ------------------------------------------------------- | ------------- | ---------- |
| **Content Security Policy Header Not Set**        | Medium        | High       |
| **HTTP Only Site**                                | Medium        | Medium     |
| **Application Error Disclosure**                  | Low           | Medium     |
| **Information Disclosure - Debug Error Messages** | Low           | Medium     |
| **X-Content-Type-Options Header Missing**         | Low           | Medium     |
| **User Agent Fuzzer**                             | Informational | Medium     |

<img width="1690" height="783" alt="image" src="https://github.com/user-attachments/assets/440533a5-4465-4b8c-9711-73c13559ee5d" />


---

### 3.6 Generate DAST Report

Generate the HTML security report:

```bash
curl -s "http://127.0.0.1:8090/OTHER/core/other/htmlreport/" -o /home/ubuntu/zap-reports/attendance-dast-report.html
```

Save the JSON alert details:

```bash
curl -s "http://127.0.0.1:8090/JSON/core/view/alerts/" -o /home/ubuntu/zap-reports/attendance-dast-alerts.json
```

Verify generated report files:

```bash
ls -lh /home/ubuntu/zap-reports/
```

Generated files:

- `apispec_1.json`
- `attendance-dast-alerts.json`
- `attendance-dast-report.html`

<img width="944" height="253" alt="image" src="https://github.com/user-attachments/assets/af99e35a-ba41-438a-8fc4-8bb45f0e501b" />


---

# 4. Conclusion

This Proof of Concept successfully demonstrated Dynamic Application Security Testing (DAST) for the Python-based Attendance API.

OWASP ZAP was configured in daemon mode, discovered all endpoints via OpenAPI, executed an active vulnerability scan to 100%, and generated an HTML report.

**Chosen Tool:**
**OWASP ZAP** is chosen for our Python CI checks because it is free, supports headless daemon mode, and scans OpenAPI endpoints effectively.

---

# 5. Contact Information

|        Name        |          Email Address          |
| :----------------: | :-----------------------------: |
| **Amrendra** | amrendra.snaatak@mygurukulam.co |

---

# 6. References

| Reference                           | Link                                                                                    |
| ----------------------------------- | --------------------------------------------------------------------------------------- |
| **OWASP ZAP**                 | [ZAP](https://www.zaproxy.org/docs/)                                                     |
| **OWASP ZAP User Guide**      | [UserGuide](https://www.zaproxy.org/docs/desktop/)                                       |
| **OWASP DAST**                | [OWASP](https://owasp.org/www-community/Activities/Dynamic_Application_Security_Testing) |
| **Attendance API Repository** | [Attendance](https://github.com/OT-MICROSERVICES/attendance-api)                         |
