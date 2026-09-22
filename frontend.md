# Software Documentation: Frontend (OT-Microservices)
<p align="center">
<img width="280" height="280" alt="image" src="https://github.com/user-attachments/assets/d9e8568a-1893-4123-931e-4423498a2cff" />
</p>

## Document Information

| Author             | Created On | Version | L0 Reviewer           | L1 Reviewer       | L2 Reviewer     |
| :----------------- | :--------- | :------ | :-------------------- | :---------------- | :-------------- |
| **Amrendra** | 11-09-2026 | 1.0     | Shubham Rathi / Sunny | Shreya J / Nikita | Piyush Upadhyay |

---

## Introduction

This document provides complete, easy-to-understand software documentation for the **Frontend** web application of the **OT-Microservices** project, created from the validated Proof of Concept (PoC).

The **Frontend** is a web application built using **React.js**. It provides an intuitive graphical user interface (UI) for interacting with underlying backend microservices (Employee, Attendance, and Salary). It runs on port `3000`, is reverse-proxied through **Nginx** on standard port `80`, and is managed automatically as a Linux **systemd** service.

---

## Purpose

| S.No | Purpose                                      | Description                                                                                               |
| :--: | :------------------------------------------- | :-------------------------------------------------------------------------------------------------------- |
|  1  | **User Interface for Microservices**   | Acts as the visual portal for users to interact with Employee, Attendance, and Salary microservices.      |
|  2  | **Employee Management**                | Allows HR and managers to view, add, and search employee profiles.                                        |
|  3  | **Attendance Tracking**                | Enables employees to record daily check-in and check-out logs and view monthly summaries.                 |
|  4  | **Salary & Payroll Inspection**        | Allows employees to inspect salary structures, deductions, and download salary slips as PDF files.        |
|  5  | **Production-Ready PoC Demonstration** | Demonstrates the manual setup, reverse proxy configuration, and systemd service management on a Linux VM. |

---

## Key Features

| S.No | Feature                               | Description                                                                                              |
| :--: | :------------------------------------ | :------------------------------------------------------------------------------------------------------- |
|  1  | **Built with React.js**         | Fast, responsive Single Page Application (SPA) running smoothly in modern web browsers.                  |
|  2  | **Nginx Reverse Proxy**         | Routes standard HTTP web traffic on port`80` to the React app running on port `3000`.                |
|  3  | **Systemd Service Integration** | Runs as a managed background service that automatically restarts on system reboot or unexpected crashes. |
|  4  | **Material-UI Components**      | Clean and responsive user interface with styled buttons, forms, and data tables.                         |
|  5  | **Search and Filter Tables**    | Easily filter, sort, and search employee and attendance records.                                         |
|  6  | **PDF Slip Download**           | Native export of salary slips and attendance reports to downloadable PDF documents.                      |
|  7  | **Interactive Visual Charts**   | Visual graphs displaying company workforce and attendance metrics.                                       |

---

## Getting Started

### Pre-requisites

| S.No | Tool / Requirement     | Version / Port                    | Description                                                                        |
| :--: | :--------------------- | :-------------------------------- | :--------------------------------------------------------------------------------- |
|  1  | **Node.js**      | `v16.x` / `v18.x`             | JavaScript runtime required to install dependencies, build, and run the React app. |
|  2  | **npm**          | `8.x` or higher                 | Node Package Manager used to install and manage project dependencies.              |
|  3  | **Nginx**        | `1.18+` / Port `80`           | Web server used as a reverse proxy to serve the frontend application to users.     |
|  4  | **Git**          | `2.25+`                         | Version control tool used to clone the project repository.                         |
|  5  | **Backend APIs** | Ports`8080`, `5000`, `8081` | Upstream Employee, Attendance, and Salary REST APIs.                               |

### License Type

| License Type               | Description                                                   | Commercial Use |  Open Source  |
| :------------------------- | :------------------------------------------------------------ | :------------: | :-----------: |
| **MIT / Apache 2.0** | Free and open for public use, modification, and distribution. | **Yes** | **Yes** |

---

## Software Overview

| Software           | Version         | Purpose                                                                 |
| :----------------- | :-------------- | :---------------------------------------------------------------------- |
| **Node.js**  | `16.x / 18.x` | Runtime environment for executing JavaScript code.                      |
| **npm**      | `8.x+`        | Package manager for managing React libraries.                           |
| **React.js** | `16.2.0`      | Frontend UI framework.                                                  |
| **Nginx**    | `1.18.0+`     | Reverse proxy server routing port`80` to port `3000`.               |
| **Systemd**  | Linux standard  | Service manager keeping the app running continuously in the background. |

---

## System Requirement

| Component                  | Minimum Requirement (PoC / Testing)       | Recommended (Production)      |
| :------------------------- | :---------------------------------------- | :---------------------------- |
| **Operating System** | Ubuntu 20.04 / 22.04 LTS (or Linux-based) | Ubuntu 22.04 LTS              |
| **Instance Type**    | `t2.small`                              | `t2.medium` / `t3.medium` |
| **Processor**        | Single-core                               | Dual-core (2 vCPUs)           |
| **RAM (Memory)**     | 2 GB                                      | 4 GB or higher                |
| **Disk Space**       | 8 GB                                      | 15 GB or higher               |

---

## Important Ports

| Port           | Protocol  | Used By        | Description                                                                   |
| :------------- | :-------- | :------------- | :---------------------------------------------------------------------------- |
| **22**   | TCP / SSH | SSH            | Used for secure remote terminal login and VM administration.                  |
| **80**   | HTTP      | Nginx          | Standard web port used to serve the frontend to users over HTTP.              |
| **3000** | HTTP      | React.js App   | Internal application port where the React development/runtime server listens. |
| **8080** | HTTP      | Employee API   | Upstream backend service providing employee records.                          |
| **5000** | HTTP      | Attendance API | Upstream backend service providing attendance logs.                           |
| **8081** | HTTP      | Salary API     | Upstream backend service providing salary and payroll calculations.           |

---

## Dependencies

### Run-time Dependency

| Run-time Dependency                 | Version     | Description                                           |
| :---------------------------------- | :---------- | :---------------------------------------------------- |
| **Node.js**                   | `16.15.1` | JavaScript runtime environment.                       |
| **react / react-dom**         | `^16.2.0` | Core React library for UI rendering.                  |
| **@material-ui/core**         | `^4.11.0` | Material design UI components and styling.            |
| **material-table**            | `^1.63.1` | Dynamic data table with search, sort, and pagination. |
| **formik**                    | `^2.1.4`  | Form management and input validation.                 |
| **@progress/kendo-react-pdf** | `^3.14.0` | PDF generation tool for salary slips and reports.     |
| **react-c3js**                | `^0.1.20` | Charting library for graphical data display.          |

### Other Dependency

| Other Dependency         | Version     | Description                          |
| :----------------------- | :---------- | :----------------------------------- |
| **Nginx**          | `1.18+`   | Reverse proxy web server.            |
| **Git**            | `2.25+`   | Code repository management.          |
| **Employee API**   | `v0.1.0+` | Backend service for employee data.   |
| **Attendance API** | `v0.1.0+` | Backend service for attendance data. |
| **Salary API**     | `v0.1.0+` | Backend service for payroll data.    |

---

## How to Setup/Install Frontend

Follow the 15-step installation and setup process from the PoC to configure the frontend on an Ubuntu/Linux server.

### 1. Update Package Index

```bash
sudo apt update
```

### 2. Install Node.js and npm

```bash
sudo apt install nodejs npm -y
```

### 3. Verify Node.js and npm Installation

```bash
node --version
npm --version
```

### 4. Install Nginx

```bash
sudo apt install nginx -y
sudo systemctl status nginx
```

### 5. Clone the Frontend Repository

```bash
git clone https://github.com/OT-MICROSERVICES/frontend.git
cd frontend
```

### 6. Install Project Dependencies

```bash
npm install
```

### 7. Start the Frontend Application (Testing)

Run the React application using the legacy OpenSSL provider:

```bash
export NODE_OPTIONS=--openssl-legacy-provider
npm start
```

*The app starts on port `3000`. You can test it by visiting `http://<PUBLIC-IP>:3000`.*

### 8. Configure Nginx as a Reverse Proxy

Create an Nginx configuration file to forward incoming port `80` traffic to the React application on port `3000`:

```bash
sudo nano /etc/nginx/sites-available/frontend
```

Add the following configuration:

```nginx
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:3000;

        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### 9. Enable the Nginx Configuration

Create a symbolic link in `sites-enabled` and remove the default Nginx site:

```bash
sudo ln -s /etc/nginx/sites-available/frontend /etc/nginx/sites-enabled/frontend
sudo rm /etc/nginx/sites-enabled/default
```

### 10. Validate Nginx Configuration

Test for syntax errors:

```bash
sudo nginx -t
```

*Expected output: `syntax is ok` and `test is successful`.*

### 11. Reload & Check Status of Nginx

Apply the new configuration:

```bash
sudo systemctl reload nginx
sudo systemctl status nginx
```

### 12. Validate Frontend Through Nginx

Verify that Nginx is listening on port `80` and returning content:

```bash
sudo ss -lntp | grep ':80'
curl http://127.0.0.1
```

### 13. Access Frontend Through Public IP

Open your web browser and navigate to:

```text
http://<PUBLIC-IP>
```

The OT-Microservices Frontend dashboard will load over standard port 80.

### 14. Configure Frontend as a System Service

To ensure the frontend keeps running in the background and restarts automatically after reboot, create a systemd service file:

```bash
sudo nano /etc/systemd/system/frontend.service
```

Add the following configuration (replace `ubuntu` with your username if different):

```ini
[Unit]
Description=Frontend React Service
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/frontend
Environment="NODE_OPTIONS=--openssl-legacy-provider"
ExecStart=/usr/bin/npm start
Restart=always

[Install]
WantedBy=multi-user.target
```

### 15. Reload and Start the Frontend Service

Reload systemd, enable the service on boot, and start it:

```bash
sudo systemctl daemon-reload
sudo systemctl enable frontend
sudo systemctl start frontend
sudo systemctl status frontend
```

---

## Configuration

### 1. Systemd Service Configuration

The systemd service (`/etc/systemd/system/frontend.service`) manages:

* **Working Directory**: `/home/ubuntu/frontend`
* **Environment Variable**: `NODE_OPTIONS=--openssl-legacy-provider` (resolves OpenSSL compatibility)
* **Auto-Restart**: `Restart=always` ensures automatic recovery if the process terminates.

### 2. Nginx Reverse Proxy Configuration

The Nginx configuration (`/etc/nginx/sites-available/frontend`) handles:

* Forwarding port `80` traffic to `http://127.0.0.1:3000`.
* Passing standard proxy headers (`Host`, `X-Real-IP`, `X-Forwarded-For`, `X-Forwarded-Proto`).

---

## Maintenance

Standard maintenance commands:

```bash
# ----------------------------------------------------
# 1. To Update to the latest code
# ----------------------------------------------------
cd /home/ubuntu/frontend
git pull origin master
npm install
sudo systemctl restart frontend

# ----------------------------------------------------
# 2. To Restart Services
# ----------------------------------------------------
sudo systemctl restart frontend
sudo systemctl restart nginx

# ----------------------------------------------------
# 3. To Check Service Status
# ----------------------------------------------------
sudo systemctl status frontend
sudo systemctl status nginx
```

---

## Monitoring

1. **Check if Frontend Service is Running**:
   ```bash
   sudo systemctl status frontend
   ```
2. **Check Nginx Reverse Proxy**:
   ```bash
   sudo systemctl status nginx
   sudo ss -lntp | grep ':80'
   ```
3. **Check Live Logs**:
   * **Frontend Service Logs**:
     ```bash
     journalctl -u frontend -f
     ```
   * **Nginx Access & Error Logs**:
     ```bash
     tail -f /var/log/nginx/access.log
     tail -f /var/log/nginx/error.log
     ```
4. **Health Check via Curl**:
   ```bash
   curl -I http://127.0.0.1
   ```

---

## Disaster Recovery

* **Stateless Application**: The frontend holds no database state. If the VM crashes or is corrupted, all data remains safe in the backend databases.
* **Rapid Re-deployment**:
  1. Launch a new Ubuntu VM (`t2.small`).
  2. Follow the 15-step setup or run a shell script with the same steps.
  3. Total recovery time is **under 5 minutes**.
* **Automatic Crash Recovery**: The systemd service has `Restart=always`, so any application-level crash is automatically restarted within seconds.

---

## High Availability

* **Multi-Instance Deployment**: Deploy multiple Ubuntu VMs running the frontend service.
* **Load Balancer**: Place an AWS Application Load Balancer (ALB) or cloud load balancer in front of the VMs on port `80`/`443`.
* **Health Checks**: Configure ALB health checks to ping `http://<INSTANCE-IP>/` to automatically route traffic only to healthy instances.

---

## Troubleshooting

| Problem                                                             | Root Cause                                                 | Solution                                                                                                    |
| :------------------------------------------------------------------ | :--------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------- |
| **`error:0308010C:digital envelope routines::unsupported`** | Node.js version mismatch with legacy OpenSSL hashing.      | Set`NODE_OPTIONS=--openssl-legacy-provider` in terminal or inside the systemd service file.               |
| **Port 3000 already in use (`EADDRINUSE`)**                 | An existing`npm` or `node` process is already running. | Find the process:`sudo ss -lntp \| grep :3000`, and stop it using `kill -9 <PID>`.                       |
| **502 Bad Gateway on Port 80**                                | Nginx is running, but the frontend React app is stopped.   | Check frontend service:`sudo systemctl status frontend`. Restart it: `sudo systemctl restart frontend`. |
| **Nginx Test Fails (`nginx -t`)**                           | Syntax error in`/etc/nginx/sites-available/frontend`.    | Inspect the file for missing semicolons or braces, then re-test with`sudo nginx -t`.                      |
| **Cannot access via Public IP in browser**                    | Security Group / Firewall is blocking Port 80.             | In AWS / cloud provider, ensure your Inbound Rules allow HTTP traffic on port`80` from `0.0.0.0/0`.     |

---

## FAQs

### 1. Is this application free and open-source?

Yes, it is released under the MIT / Apache 2.0 license.

### 2. Can I run the frontend without Nginx?

Yes, you can access the frontend directly on port `3000` (`http://<PUBLIC-IP>:3000`), but using Nginx on port `80` is the recommended standard for production web traffic.

### 3. Why is `NODE_OPTIONS=--openssl-legacy-provider` required?

Modern versions of Node.js enforce OpenSSL 3.0 algorithms. This environment variable allows React's build tools (Webpack) to run smoothly without cryptographic errors.

### 4. How does the frontend restart after a server reboot?

Because we configured it as a systemd service and ran `sudo systemctl enable frontend`, Linux will automatically start the service on every boot.

---

## Contact Information

| Name     | Email                                                                                |
| :------- | :----------------------------------------------------------------------------------- |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

## References

| Resource                        | Link                                                                                                                                                                                                                                                    |
| :------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Frontend Repository             | [https://github.com/OT-MICROSERVICES/frontend](https://github.com/OT-MICROSERVICES/frontend)                                                                                                                                                             |
| Node.js Documentation           | [https://nodejs.org/en/download/package-manager](https://nodejs.org/en/download/package-manager)                                                                                                                                                         |
| NPM Documentation               | [https://docs.npmjs.com/](https://docs.npmjs.com/)                                                                                                                                                                                                       |
| React Official Documentation    | [https://reactjs.org/docs/getting-started.html](https://reactjs.org/docs/getting-started.html)                                                                                                                                                           |
| Nginx Documentation             | [https://nginx.org/en/docs/](https://nginx.org/en/docs/)                                                                                                                                                                                                 |
