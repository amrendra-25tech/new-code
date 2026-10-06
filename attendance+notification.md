# POC: Python CI Checks | DAST

## Author Information

| **Author** | **Created On** | **Version** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | --------------------- | --------------------- | --------------------- |
| Amrendra         | 29-09-2026           | 1.0               | Shubham Rathi / Sunny | Shreya J / Nikita     | Piyush Upadhyay       |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Pre-requisites](#2-pre-requisites)
3. [Step-by-Step Setup Guide — Attendance API](#3-step-by-step-setup-guide--attendance-api)
   - [3.1 Verify Attendance API &amp; OpenAPI](#31-verify-attendance-api--openapi)
   - [3.2 Start OWASP ZAP Daemon](#32-start-owasp-zap-daemon)
   - [3.3 Import and Discover API Endpoints](#33-import-and-discover-api-endpoints)
   - [3.4 Run Active DAST Scan](#34-run-active-dast-scan)
   - [3.5 Analyze Security Alerts](#35-analyze-security-alerts)
   - [3.6 Generate DAST Report](#36-generate-dast-report)
4. [Step-by-Step Setup Guide — Notification Worker](#4-step-by-step-setup-guide--notification-worker)
   - [4.1 Verify Notification Worker Adapter](#41-verify-notification-worker-adapter)
   - [4.2 Verify Notification Test Request](#42-verify-notification-test-request)
   - [4.3 Verify Notification OpenAPI Specification](#43-verify-notification-openapi-specification)
   - [4.4 Configure DAST Automation Plan](#44-configure-dast-automation-plan)
   - [4.5 Execute Automated DAST Scan](#45-execute-automated-dast-scan)
   - [4.6 Verify Generated DAST Report](#46-verify-generated-dast-report)
5. [Conclusion](#5-conclusion)
6. [Contact Information](#6-contact-information)
7. [References](#7-references)

---

# 1. Introduction

This Proof of Concept (POC) demonstrates DAST for Python web services using OWASP ZAP.
It covers security scanning, alert analysis, and report generation for both the Attendance API and Notification Worker.

---

# 2. Pre-requisites

The following components are required to perform the DAST scans:

| Requirement                         | Purpose                                                                |
| ----------------------------------- | ---------------------------------------------------------------------- |
| **Ubuntu Linux**              | Operating system running on the EC2 instance.                          |
| **Python & Gunicorn**         | Runtime and WSGI server running the Attendance API on port 8080.       |
| **Notification DAST Adapter** | HTTP test adapter exposing Notification Worker endpoints on port 8081. |
| **PostgreSQL**                | Database backend for application data.                                 |
| **Redis**                     | In-memory message broker and caching service.                          |
| **OWASP ZAP 2.17.0**          | DAST security scanner supporting automation plans and headless mode.   |
| **OpenAPI Specifications**    | JSON definitions used by ZAP for endpoint discovery.                   |

---

# 3. Step-by-Step Setup Guide — Attendance API

### 3.1 Verify Attendance API & OpenAPI

Verify that the Attendance API service is healthy:

```bash
curl http://127.0.0.1:8080/api/v1/attendance/health
```

Expected response:

```json
{"message":"Attendance API is running fine and ready to serve requests"}
```

<img width="1087" height="284" alt="Attendance API Health" src="https://github.com/user-attachments/assets/16582d50-3bb2-4ceb-9d75-5c53f4d7b09e" />

Save and verify the OpenAPI JSON specification:

```bash
mkdir -p /home/ubuntu/zap-reports
curl -s http://127.0.0.1:8080/apispec_1.json -o /home/ubuntu/zap-reports/apispec_1.json
ls -lh /home/ubuntu/zap-reports/apispec_1.json
```

<img width="1209" height="63" alt="Attendance OpenAPI Spec" src="https://github.com/user-attachments/assets/5856c05f-d126-4b54-8995-8d3b69be1cfc" />

---

### 3.2 Start OWASP ZAP Daemon

Start OWASP ZAP in headless daemon mode on port 8090:

```bash
/opt/zap/zap.sh -daemon -port 8090 -host 127.0.0.1 -config api.disablekey=true
```

<img width="1691" height="900" alt="ZAP Daemon Started" src="https://github.com/user-attachments/assets/140e6911-95a8-424d-a374-4bafb5717ec8" />

Verify that ZAP is running:

```bash
curl "http://127.0.0.1:8090/JSON/core/view/version/"
```

Expected output:

```json
{"version":"2.17.0"}
```

<img width="873" height="177" alt="Verify ZAP Version" src="https://github.com/user-attachments/assets/c1c2c74d-bc60-4c93-81a7-4dd0f93fe26d" />

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

<img width="1671" height="179" alt="Discovered Endpoints" src="https://github.com/user-attachments/assets/bdd65315-0f8d-4d4f-b491-912875dd8663" />

---

### 3.4 Run Active DAST Scan

Start the active vulnerability scan:

```bash
curl "http://127.0.0.1:8090/JSON/ascan/action/scan/?url=http%3A%2F%2F127.0.0.1%3A8080%2Fapi%2Fv1%2Fattendance&recurse=true&inScopeOnly=false"
```

Expected output:

<img width="1617" height="99" alt="Scan Started" src="https://github.com/user-attachments/assets/b1c3dd6a-bbc9-47fc-b2be-ea2de6129baa" />

Monitor scan progress until completion:

```bash
curl "http://127.0.0.1:8090/JSON/ascan/view/status/?scanId=0"
```

Expected output:

```json
{"status":"100"}
```

<img width="1036" height="212" alt="Active Scan Progress 100%" src="https://github.com/user-attachments/assets/8048f056-9660-4f4b-a231-fa2788b21488" />

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

<img width="1690" height="783" alt="Attendance Security Alerts" src="https://github.com/user-attachments/assets/440533a5-4465-4b8c-9711-73c13559ee5d" />

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

<img width="944" height="253" alt="Attendance Generated Report" src="https://github.com/user-attachments/assets/af99e35a-ba41-438a-8fc4-8bb45f0e501b" />

---

# 4. Step-by-Step Setup Guide — Notification Worker

### 4.1 Verify Notification Worker Adapter

Verify that the Notification Worker test adapter is running on port 8081:

```bash
curl http://127.0.0.1:8081/notification/health
```

Expected response:

```json
{"status":"Notification Worker test adapter is running"}
```

<img width="1587" height="416" alt="adaptor" src="https://github.com/user-attachments/assets/e69c3a27-612a-44d4-b93f-82145bfaac8d" />


---

### 4.2 Verify Notification Test Request

Send a test notification payload to verify message processing:

```bash
curl -X POST \
  http://127.0.0.1:8081/notification/test \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com"}'
```

Expected response:

```json
{"message":"Notification processing completed"}
```
<img width="1218" height="243" alt="image" src="https://github.com/user-attachments/assets/c160f4f9-d3ff-4a3b-976a-eba6ea8d25c1" />



---

### 4.3 Verify Notification OpenAPI Specification

Inspect the OpenAPI schema for the Notification service:

```bash
cat ~/zap-reports/notification-openapi.json
```


---

### 4.4 Configure DAST Automation Plan

Inspect the unified ZAP automation plan configuration file:

```bash
cat ~/attendance-api/security/zap/notification-dast.yaml
```

*(If the file does not fit on one screen, use `nl -ba ~/attendance-api/security/zap/notification-dast.yaml`)*.

The configuration specifies:

- Target endpoints: `127.0.0.1:8080` & `127.0.0.1:8081`
- OpenAPI schemas: `apispec_1.json` & `notification-openapi.json`
- Jobs: `activeScan` and `report`

<img width="1766" height="911" alt="image" src="https://github.com/user-attachments/assets/b5ca23bc-278a-4e37-9ab4-1bfc202d98dd" />




---

### 4.5 Execute Automated DAST Scan

Run the automated scan plan across both Attendance and Notification services.

**Terminal 1 (Keep adapter running):**

```bash
cd ~/notification-worker
source venv/bin/activate
python3 ~/notification_dast_adapter.py
```

**Terminal 2 (Run ZAP Automation Plan):**

```bash
~/ZAP_2.17.0/zap.sh -cmd \
  -autorun ~/attendance-api/security/zap/notification-dast.yaml
```

Expected scan log output:

```text
Job openapi added 5 URLs
Job openapi added 2 URLs
Job activeScan finished
Job report generated report /home/ubuntu/zap-reports/notification-attendance-dast-report.html
Automation plan succeeded!
```

<!-- Screenshot 6 — Run the DAST scan -->

<img width="1716" height="670" alt="dast" src="https://github.com/user-attachments/assets/d3c03ff4-aa8c-4691-b439-826253747a2b" />


---

### 4.6 Verify Generated DAST Report

Verify that the unified security report was generated successfully:

```bash
ls -lh ~/zap-reports/notification-attendance-dast-report.html
```

<img width="1199" height="87" alt="image" src="https://github.com/user-attachments/assets/2fdb2c65-98ed-48ff-9cec-d3420ec888d9" />


---

# 5. Conclusion

This Proof of Concept successfully demonstrated Dynamic Application Security Testing (DAST) for both the **Attendance API** and **Notification Worker**.

Using OWASP ZAP and the ZAP Automation Framework (`notification-dast.yaml`), all endpoints were discovered and scanned automatically to 100%, generating the comprehensive HTML report `notification-attendance-dast-report.html`.

**Chosen Tool:**
**OWASP ZAP** is chosen for our Python CI checks because it is free, supports headless daemon mode, and automates multi-service scans effectively.

---

# 6. Contact Information

|        Name        |          Email Address          |
| :----------------: | :-----------------------------: |
| **Amrendra** | amrendra.snaatak@mygurukulam.co |

---

# 7. References

| Reference                                | Link                                                                                    |
| ---------------------------------------- | --------------------------------------------------------------------------------------- |
| **OWASP ZAP**                      | [ZAP](https://www.zaproxy.org/docs/)                                                     |
| **OWASP ZAP User Guide**           | [UserGuide](https://www.zaproxy.org/docs/desktop/)                                       |
| **OWASP DAST**                     | [OWASP](https://owasp.org/www-community/Activities/Dynamic_Application_Security_Testing) |
| **Attendance API Repository**      | [Attendance](https://github.com/OT-MICROSERVICES/attendance-api)                         |
| **Notification Worker Repository** | [Notification](https://github.com/OT-MICROSERVICES/notification-worker)                  |
