# Frontend Detailed Documentation
<p align="center">
<img width="280" height="280" alt="image" src="https://github.com/user-attachments/assets/a2b1208b-c1cf-4b22-b1b4-1393da99302b" />
</p>

---
## Document Information
| Author   | Created on | Version |   L0 Reviewer           | L1 Reviewer       | L2 Reviewer     |
| -------- | ---------- | ------- | --------------------- | ----------------- | --------------- |
| Amrendra | 11/09/2026 | 1.0     | Shubham Rathi / Sunny | Shreya J / Nikita | Piyush Upadhyay |

---

## Table of Contents

<details>
<summary>Table of Contents</summary>

- [Introduction](#introduction)
- [Pre-requisites](#pre-requisites)
- [System Requirements](#system-requirements)

<details>
<summary>Dependencies</summary>

- [Build time Dependency](#build-time-dependency)
- [Run time Dependency](#run-time-dependency)
- [Other Dependency](#other-dependency)

</details>

- [Important Ports](#important-ports)
- [Others](#others)
- [Architecture](#architecture)
- [Dataflow Diagram](#dataflow-diagram)

<details>
<summary>Step-by-step installation of Frontend</summary>

- [Step1: Installation of software Dependencies](#step1-installation-of-software-dependencies)
- [Step2: Build/Artifact Generation](#step2-buildartifact-generation)
- [Step3: Application Deployment](#step3-application-deployment)

</details>

- [Monitoring](#monitoring)
- [Logging](#logging)
- [Disaster Recovery](#disaster-recovery)
- [High Availability](#high-availability)
- [Troubleshooting](#troubleshooting)
- [FAQs](#faqs)
- [Contact Information](#contact-information)
- [References](#references)

</details>

---

## Introduction
This document provides comprehensive software documentation for the **Frontend** web application of the **OT-Microservices** Employee Management System.

Frontend is the ReactJS-based web UI of the **OT-Microservices** Employee Management System. It gives employees and admins a single web interface to create and search employee, attendance, and salary records, instead of calling the backend REST APIs directly. It is stateless, cross-platform, and only needs a JavaScript runtime to build, plus a static file server (`serve`, or NGINX) to run.

The frontend does not own any database. It is directly dependent on three backend microservices, and indirectly tied to a fourth:

| Service                                                                                | Role                                                | Called directly by frontend?          |
| :------------------------------------------------------------------------------------- | :-------------------------------------------------- | :------------------------------------ |
| [Employee API](https://github.com/OT-MICROSERVICES/employee-api) (Go)                   | Employee records                                    | Yes                                   |
| [Attendance API](https://github.com/OT-MICROSERVICES/attendance-api) (Python)           | Attendance records                                  | Yes                                   |
| [Salary API](https://github.com/OT-MICROSERVICES/salary-api) (Java)                     | Salary records                                      | Yes                                   |
| [Notification Worker](https://github.com/OT-MICROSERVICES/notification-worker) (Python) | Emails employees on a schedule using the data above | No — indirect, downstream dependency |

---

## Pre-requisites

Before setting up the frontend, ensure the following are available and reachable.

| Dependency               | Version                   | Purpose                                        |
| :----------------------- | :------------------------ | :--------------------------------------------- |
| **Node.js**        | 16.15.1                   | Build the React application                    |
| **npm**            | bundled with Node 16.15.1 | Install packages, run the build                |
| **NGINX**          | latest (or 1.18+)         | Serve the production build / reverse proxy     |
| **Employee API**   | latest                    | Must be reachable for employee pages to work   |
| **Attendance API** | latest                    | Must be reachable for attendance pages to work |
| **Salary API**     | latest                    | Must be reachable for salary pages to work     |

---

## System Requirements

The frontend is a lightweight static React build with no heavy compute requirements.

| Hardware Specifications | Minimum Recommendation                                |
| :---------------------- | :---------------------------------------------------- |
| **Processor**     | Dual-core                                             |
| **RAM**           | 2 GB                                                  |
| **Disk**          | 5 GB                                                  |
| **OS**            | Ubuntu (22.04 / 20.04) or any OS with Node.js support |

---

## Dependencies

### Build time Dependency

| Name              | Version                   | Description                                                    |
| :---------------- | :------------------------ | :------------------------------------------------------------- |
| **Node.js** | 16.15.1                   | Required to install packages and build the React app           |
| **npm**     | bundled with Node 16.15.1 | Package manager used to install dependencies and run the build |

### Run time Dependency

| Name                       | Version | Description                            |
| :------------------------- | :------ | :------------------------------------- |
| **serve (or NGINX)** | latest  | Serves the production`build/` output |
| **Employee API**     | latest  | Backend service for employee records   |
| **Attendance API**   | latest  | Backend service for attendance records |
| **Salary API**       | latest  | Backend service for salary records     |

### Other Dependency

| Name                          | Version | Description                                                                           |
| :---------------------------- | :------ | :------------------------------------------------------------------------------------ |
| **Notification Worker** | latest  | Not called directly by the frontend; reads the same data on a schedule to send emails |

---

## Important Ports

| Inbound Traffic                  | Description     |
| :------------------------------- | :-------------- |
| **3000 (or 80 via NGINX)** | Frontend web UI |

| Outbound Traffic | Description    |
| :--------------- | :------------- |
| **8080**   | Employee API   |
| **8081**   | Attendance API |
| **8082**   | Salary API     |

---

## Others

### Stop Service

```bash
fuser -k 3000/tcp
```

### Repository

[https://github.com/OT-MICROSERVICES/frontend](https://github.com/OT-MICROSERVICES/frontend)

---

## Architecture

The browser loads the React app from the frontend server and makes REST calls to the three backend APIs (Employee API, Attendance API, and Salary API). The Notification Worker is not called by the browser; it separately reads the same data on a schedule to send automated email alerts.

---

## Dataflow Diagram

<img width="2912" height="1156" alt="frontend" src="https://github.com/user-attachments/assets/001b90fa-cd92-4ba6-a96e-cfe41367478f" />


---

## Step-by-step installation of Frontend

### Step1: Installation of software Dependencies

#### Build Dependency

```bash
cd ~/OT-Micro/frontend
npm install
```

#### Run time Dependency

The frontend needs the three backend APIs reachable before it is useful. From the machine running the frontend:

```bash
curl -I http://localhost:8080/api/v1/employee/health
curl -I http://localhost:8081/api/v1/attendance/health
curl -I http://localhost:8082/actuator/health
```

If any of these fail, start/fix that service first — see that service's own repository for its setup steps.

#### Other Dependency

Not applicable for this application.

---

### Step2: Build/Artifact Generation

```bash
mkdir -p ~/logs
fuser -k 3000/tcp 2>/dev/null

cd ~/OT-Micro/frontend
npm run build
```

---

### Step3: Application Deployment

```bash
nohup npx serve -s build -l 3000 > ~/logs/frontend.log 2>&1 &
```

Ensure the application deployed is in a working state:

```text
http://localhost:3000/
```

Open the UI in your browser and confirm employee, attendance, and salary pages load data properly. Equivalent API-level verification checks:

```bash
curl http://localhost:8080/api/v1/employee/search/all | jq
curl http://localhost:8081/api/v1/attendance/search | jq
curl http://localhost:8082/api/v1/salary/search | jq
```

---

## Monitoring

Basic functional and reachability checks for the frontend:

| Check                           | Command / URL                                             | Expected Result            |
| :------------------------------ | :-------------------------------------------------------- | :------------------------- |
| **Frontend UI reachable** | `http://localhost:3000/`                                | Page loads without errors  |
| **Employee data loads**   | `curl http://localhost:8080/api/v1/employee/search/all` | Returns employee records   |
| **Attendance data loads** | `curl http://localhost:8081/api/v1/attendance/search`   | Returns attendance records |
| **Salary data loads**     | `curl http://localhost:8082/api/v1/salary/search`       | Returns salary records     |

---

## Logging

To inspect live application logs generated by `serve`:

```bash
tail -f ~/logs/frontend.log
```

---

## Disaster Recovery

* **Stateless Architecture**: The frontend holds no database state or persistent files. All data is securely stored in backend microservice databases.
* **Rapid Redeployment**:
  1. In case of VM or process failure, re-run `nohup npx serve -s build -l 3000 > ~/logs/frontend.log 2>&1 &` or launch a fresh container.
  2. Total recovery time is **under 2 minutes**.
* **Pre-Built Artifacts**: Production `build/` archives can be stored in object storage (S3/Cloud Storage) for instant retrieval without waiting for compilation.

---

## High Availability

* **Multiple Replicas**: Run 2 or more frontend instances across different availability zones or VMs.
* **Load Balancer**: Deploy NGINX, Traefik, or an AWS Application Load Balancer (ALB) on port `80`/`443` to distribute user traffic evenly.
* **Edge CDN**: Cache static assets (`/static/js/`, `/static/css/`) using Cloudflare or AWS CloudFront to reduce server load and provide global high availability.

---

## Troubleshooting

| Issue                                         | Possible Cause                                    | Resolution                                                                                           |
| :-------------------------------------------- | :------------------------------------------------ | :--------------------------------------------------------------------------------------------------- |
| **Blank page after deployment**         | Backend APIs unreachable                          | Verify Employee, Attendance, and Salary API URLs and ensure their health endpoints return`200 OK`. |
| **`npm install` fails**               | Node.js version mismatch                          | Use Node.js`16.15.1` as pinned in the Dockerfile.                                                  |
| **Port already in use**                 | Another process is using port 3000                | Run`fuser -k 3000/tcp` to terminate the conflicting process, or map to a different port.           |
| **Data not showing on a specific page** | That page's backend service is down or unmigrated | Check that specific service's own health endpoint and application logs.                              |

---

## FAQs

**1. Why is the frontend showing a blank page?**

> One or more of the Employee/Attendance/Salary APIs is unreachable. Check each with `curl` against its health endpoint.

**2. Why does `npm run build` fail?**

> Usually a Node.js version mismatch — use `16.15.1` as pinned in the Dockerfile.

**3. Does the frontend talk to the Notification Worker?**

> No. Notification Worker is a separate scheduled job that later reads the data the frontend creates; the frontend never calls it directly.

**4. Can I run the frontend without Docker?**

> Yes — run `npm install && npm run build`, then serve the `build/` folder with `serve` or any static file server like NGINX.

---

## Contact Information

| Name     | Email                                                                                |
| :------- | :----------------------------------------------------------------------------------- |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

## References

| Resource                   | Link                                                                                                                                           |
| :------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- |
| Frontend repository        | [https://github.com/OT-MICROSERVICES/frontend](https://github.com/OT-MICROSERVICES/frontend)                                                    |
| Employee API               | [https://github.com/OT-MICROSERVICES/employee-api](https://github.com/OT-MICROSERVICES/employee-api)                                            |
| Attendance API             | [https://github.com/OT-MICROSERVICES/attendance-api](https://github.com/OT-MICROSERVICES/attendance-api)                                        |
| Salary API                 | [https://github.com/OT-MICROSERVICES/salary-api](https://github.com/OT-MICROSERVICES/salary-api)                                                |
| Notification Worker        | [https://github.com/OT-MICROSERVICES/notification-worker](https://github.com/OT-MICROSERVICES/notification-worker)                              
