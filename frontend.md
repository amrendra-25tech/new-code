# Software Documentation: Frontend (OT-Microservices)
<p align="center">
<img width="280" height="280" alt="image" src="https://github.com/user-attachments/assets/a2b1208b-c1cf-4b22-b1b4-1393da99302b" />
</p>

## Document Information

| Author | Created On | Version | Last Edited On | L0 Reviewer | L1 Reviewer | L2 Reviewer |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Amrendra** | 11-09-2026 | 1.1 | 22-9-2026 | Shubham Rathi / Sunny | Shreya J / Nikita | Piyush Upadhyay |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Purpose](#2-purpose)
3. [Key Features](#3-key-features)
4. [Getting Started](#4-getting-started)
   - 4.1 [Pre-requisites](#41-pre-requisites)
   - 4.2 [License Type](#42-license-type)
5. [Software Overview](#5-software-overview)
6. [System Requirement](#6-system-requirement)
7. [Important Ports](#7-important-ports)
8. [Dependencies](#8-dependencies)
   - 8.1 [Run-time Dependency](#81-run-time-dependency)
   - 8.2 [Other Dependency](#82-other-dependency)
9. [Configuration](#9-configuration)
10. [Maintenance](#10-maintenance)
11. [Architecture](#11-architecture)
12. [Workflow Diagram](#12-workflow-diagram)
13. [Monitoring](#13-monitoring)
14. [High Availability](#14-high-availability)
15. [Disaster Recovery](#15-disaster-recovery)
16. [Troubleshooting](#16-troubleshooting)
17. [FAQs](#17-faqs)
18. [Contact Information](#18-contact-information)
19. [References](#19-references)

---

## 1. Introduction

This document serves as the technical reference for the Frontend application within the OT-Microservices ecosystem. It is intended for developers, DevOps engineers, and system administrators to understand the application's design, operational characteristics, and backend integrations.

---

## 2. Purpose

| Purpose | Description |
| :--- | :--- |
| **Manage Employees** | Add, view, and search employee details. |
| **Track Attendance** | Record daily check-ins and check attendance history. |
| **View Salary** | Check salary details and download PDF pay slips. |
| **View Dashboards** | See visual charts of company and attendance stats. |
| **Unified Portal** | Access all backend services from a single screen. |

---

## 3. Key Features

| Feature | Description |
| :--- | :--- |
| **ReactJS Framework** | Fast, modern Single Page Application (SPA) for web browsers. |
| **Material Design** | Clean, responsive UI with styled tables, buttons, and forms. |
| **Search & Filters** | Instant sorting and filtering for employee and attendance data. |
| **PDF Export** | Generates downloadable salary slips and attendance reports in PDF. |
| **Visual Charts** | Integrated C3.js / D3 charts for real-time data visualization. |
| **Form Validation** | Built-in Formik validation for error-free data entry. |

---

## 4. Getting Started

### 4.1 Pre-requisites

| Dependency | Version / Port | Purpose |
| :--- | :--- | :--- |
| **Node.js** | `16.15.1` (or 16.x) | Runtime for building the React application. |
| **npm** | `8.x` or higher | Package manager to install libraries. |
| **Nginx** | `1.18+` / Port `80` | Web server used to serve static assets or reverse proxy. |
| **Employee API** | Port `8080` | Backend API for employee data. |
| **Attendance API** | Port `5000` | Backend API for attendance data. |
| **Salary API** | Port `8081` | Backend API for salary data. |

### 4.2 License Type

| License Type | Description | Commercial Use | Open Source |
| :--- | :--- | :---: | :---: |
| **MIT / Apache 2.0** | Free to use, modify, and share publicly or commercially. | **Yes** | **Yes** |

---

## 5. Software Overview

| Software | Version | Purpose |
| :--- | :--- | :--- |
| **Node.js** | `16.15.1` | JavaScript runtime environment. |
| **ReactJS** | `16.2.0` | Frontend UI library. |
| **npm** | `8.11.0+` | Package dependency manager. |
| **Serve / Nginx** | `14.x` / `1.19+` | Static web server / Reverse proxy. |
| **Docker** | `20.10+` | Container runtime engine. |

---

## 6. System Requirement

| Component | Minimum Requirement | Recommended |
| :--- | :--- | :--- |
| **Operating System** | Ubuntu 20.04 / 22.04 LTS (or Linux) | Ubuntu 22.04 LTS |
| **Instance Type** | `t2.small` | `t2.medium` |
| **Processor** | Single-core | Dual-core |
| **RAM** | 2 GB | 4 GB or higher |
| **Disk Space** | 5 GB | 10 GB free space |

---

## 7. Important Ports

| Port | Protocol | Used By | Description |
| :--- | :--- | :--- | :--- |
| **3000** | HTTP | Frontend UI | Application port for React dev server and `serve`. |
| **80** | HTTP | Nginx | Standard web port for browser access. |
| **443** | HTTPS | Nginx | Secure web port with SSL/TLS encryption. |
| **22** | TCP / SSH | SSH | Remote server terminal access. |
| **8080** | HTTP | Employee API | Upstream employee backend service. |
| **5000** | HTTP | Attendance API | Upstream attendance backend service. |
| **8081** | HTTP | Salary API | Upstream salary backend service. |

---

## 8. Dependencies

### 8.1 Run-time Dependency

| Name | Version | Description |
| :--- | :--- | :--- |
| **react / react-dom** | `^16.2.0` | Core UI rendering framework. |
| **@material-ui/core** | `^4.11.0` | Material design styling and components. |
| **material-table** | `^1.63.1` | Data tables with built-in search and pagination. |
| **formik** | `^2.1.4` | Form management and validation. |
| **@progress/kendo-react-pdf** | `^3.14.0` | Client-side PDF generation for salary slips. |
| **react-c3js** | `^0.1.20` | Charting library for graphs. |
| **serve** | `^14.x` | Lightweight production HTTP static server. |

### 8.2 Other Dependency

| Name | Version | Description |
| :--- | :--- | :--- |
| **Employee API** | `latest` | Upstream service for employee profiles. |
| **Attendance API** | `latest` | Upstream service for attendance records. |
| **Salary API** | `latest` | Upstream service for payroll calculations. |
| **Nginx** | `1.18+` | Reverse proxy and web server. |

---

## 9. Configuration

Settings are controlled via environment variables in `.env`:

```bash
# Web Server Port
PORT=3000

# Upstream Backend API URLs
REACT_APP_EMPLOYEE_API_URL=http://localhost:8080
REACT_APP_ATTENDANCE_API_URL=http://localhost:5000
REACT_APP_SALARY_API_URL=http://localhost:8081
```

---

## 10. Maintenance

Common maintenance commands:

```bash
# 1. Update application code
git pull origin master
npm install
npm run build

# 2. Restart services
sudo systemctl restart frontend
sudo systemctl restart nginx

# 3. Check service status
sudo systemctl status frontend
sudo systemctl status nginx
```

---

## 11. Architecture

The browser loads the React app from the frontend server and makes REST calls to the three backend APIs (Employee API, Attendance API, and Salary API). The Notification Worker is not called by the browser; it separately reads the same data on a schedule to send automated email alerts.

---

## 12. Workflow Diagram

<img width="2912" height="1156" alt="frontend" src="https://github.com/user-attachments/assets/001b90fa-cd92-4ba6-a96e-cfe41367478f" />

---

## 13. Monitoring

| Check | Command / URL | Expected Result |
| :--- | :--- | :--- |
| **Frontend Webpage** | `curl -I http://localhost:3000/` | HTTP/1.1 200 OK |
| **Service Status** | `sudo systemctl status frontend` | Active (running) |
| **Port Listening** | `sudo ss -lntp \| grep ':80'` | Listening on port 80 |
| **Live Logs** | `journalctl -u frontend -f` | Shows runtime logs without errors |

---

## 14. High Availability

| Strategy | Description |
| :--- | :--- |
| **Multiple Replicas** | Run 2 or more frontend instances across different availability zones or VMs. |
| **Load Balancing** | Use Nginx or AWS Application Load Balancer (ALB) to distribute user traffic evenly. |
| **CDN Caching** | Cache static JS and CSS files via Cloudflare or AWS CloudFront for fast global delivery and uptime. |
| **Health Checks** | Load balancer health checks automatically remove unhealthy instances from traffic. |

---

## 15. Disaster Recovery

| Strategy | Description |
| :--- | :--- |
| **Stateless UI** | Frontend stores no persistent data; all data resides safely in backend databases. |
| **Fast Recovery** | A replacement container or server can be deployed in under 2 minutes using pre-built artifacts. |
| **Auto-Restart** | Systemd automatically restarts the service (`Restart=always`) in the event of an application crash. |
| **RTO & RPO** | Recovery Time Objective (RTO) < 5 minutes; Recovery Point Objective (RPO) = 0. |

---

## 16. Troubleshooting

| Problem | Cause | Solution |
| :--- | :--- | :--- |
| **Port 3000 in use (`EADDRINUSE`)** | Another process is using port 3000. | Stop the old process: `fuser -k 3000/tcp`. |
| **502 Bad Gateway** | Backend APIs are down or unreachable. | Verify Employee (`8080`), Attendance (`5000`), and Salary (`8081`) APIs are running. |
| **OpenSSL error (`unsupported`)** | Node 17+ crypto incompatibility. | Run: `export NODE_OPTIONS=--openssl-legacy-provider`. |
| **Blank White Screen on Refresh** | SPA deep links not routed to `index.html`. | Set fallback rule in Nginx: `try_files $uri /index.html;`. |

---

## 17. FAQs

| Question | Answer |
| :--- | :--- |
| **Is this application free?** | Yes, it is 100% open-source under the MIT / Apache 2.0 license. |
| **Can it be deployed on any cloud platform?** | Yes, it can be deployed on AWS, Azure, GCP, or on-premise Linux servers. |
| **Does the frontend need Node.js in production?** | No. Once built with `npm run build`, the static files can be served directly using Nginx or Apache. |

---

## 18. Contact Information

| Name | Email |
| :--- | :--- |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

## 19. References

| Resource | Link |
| :--- | :--- |
| Frontend Repository | [Frontend](https://github.com/OT-MICROSERVICES/frontend) |
| Employee API | [Employee](https://github.com/OT-MICROSERVICES/employee-api) |
| Attendance API | [Attendance](https://github.com/OT-MICROSERVICES/attendance-api) |
| Salary API | [Salary](https://github.com/OT-MICROSERVICES/salary-api) |
| Node.js Documentation | [NodeJS](https://nodejs.org/en/download/package-manager) |
| React Documentation | [React](https://reactjs.org/docs/getting-started.html) |
| Nginx Documentation | [Nginx](https://nginx.org/en/docs/) |
