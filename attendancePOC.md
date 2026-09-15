
# Attendance API Setup and Execution POC 

# Document Information

| Author   | Created On | Version | L0 Reviewer   | L1 Reviewer       | L2 Reviewer     |
| :------- | :--------- | :------ | :------------ | :---------------- | :-------------- |
| Amrendra | 11-09-2026 | 1.0     | Shubham Rathi | Shreya J / Nikita | Piyush Upadhyay |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Objective](#2-objective)
3. [Prerequisites](#3-prerequisites)
4. [Project Setup](#4-project-setup)
5. [Implementation / Execution](#5-implementation--execution)
6. [Validation](#6-validation)
7. [Observations](#7-observations)
8. [Use Cases](#8-use-cases)
9. [Troubleshooting](#9-troubleshooting)
10. [Best Practices](#10-best-practices)
11. [Conclusion](#11-conclusion)
12. [Contact Information](#12-contact-information)
13. [References](#13-references)

---

# 1. Introduction

This document provides a simple, step-by-step guide for setting up the **Attendance API** on an AWS EC2 Ubuntu instance.

It explains how to install required tools, configure PostgreSQL and Redis, run database migrations with Liquibase, and run the API using Gunicorn on port **8080**. Anyone following these instructions can easily deploy and verify the application.

---

# 2. Objective

The main goals of this POC are:

- Set up a clean Ubuntu 22.04 EC2 instance.
- Open port **8080** for web traffic and port **22** for SSH.
- Install Python 3.11, OpenJDK 17, PostgreSQL, Redis, Poetry, and Liquibase.
- Create the application database and user.
- Run database migrations to create the required tables.
- Run the Attendance API as a system service using Gunicorn.
- Test that the API endpoints and Swagger UI work properly.

---

# 3. Prerequisites

| **Prerequisite** | **Details**                                                        |
| ---------------------- | ------------------------------------------------------------------------ |
| Operating System       | Ubuntu 22.04 LTS on AWS EC2                                              |
| EC2 User               | `ubuntu` with `sudo` permissions                                     |
| Project Folder         | `/home/ubuntu/attendance-api`                                          |
| Network Access         | EC2 Security Group allowing TCP port**8080** and port **22** |
| Installed Packages     | Python 3.11, OpenJDK 17, PostgreSQL 14, Redis, Poetry, Liquibase         |

### Verify Prerequisites

Run this command to check installed versions:

```bash
python3.11 --version && poetry --version && java -version && psql --version && redis-cli --version
```

Expected output:

<img width="1471" height="215" alt="image" src="https://github.com/user-attachments/assets/35658099-997b-4657-9085-6ae7c287afa0" />



---

# 4. Project Setup

## 4.1 Clone Repository

Update Ubuntu and download the code:

```bash
# Update package list
sudo apt update -y && sudo apt upgrade -y

# Clone code into home folder
cd /home/ubuntu
git clone https://github.com/OT-MICROSERVICES/attendance-api.git
cd /home/ubuntu/attendance-api
```

<img width="1575" height="122" alt="image" src="https://github.com/user-attachments/assets/2c51425e-17e8-4294-bd46-822e4a6426aa" />


---

## 4.2 Install Dependencies

Install all required system packages and tools:

```bash
# Install system packages, compilers, database, and Java
sudo apt install -y git curl build-essential libpq-dev postgresql postgresql-contrib redis-server openjdk-17-jdk libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev

# Install Python 3.11 without changing system default Python
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update -y
sudo apt install -y python3.11 python3.11-dev python3.11-venv

# Install Poetry package manager
curl -sSL https://install.python-poetry.org | python3 -
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

### Install Application Packages

Set up the Python 3.11 environment and install dependencies:

```bash
cd /home/ubuntu/attendance-api
poetry env use python3.11
poetry install
poetry add gunicorn

# Verify setup
poetry run python --version
poetry run python -c "from app import app; print(app)"
```

<img width="889" height="134" alt="image" src="https://github.com/user-attachments/assets/3a118016-d2f8-4b21-9d73-307e24b40eb1" />

---

## 4.3 Configuration

### Start Database and Cache Services

Start PostgreSQL and Redis:

```bash
# Enable and start services
sudo systemctl enable --now postgresql
sudo systemctl enable --now redis-server

# Test Redis
redis-cli ping
# Expected: PONG
```

### Create Database and User

Create `attendance_user` and `attendance_db`:

```bash
sudo -u postgres psql << 'EOF'
CREATE USER attendance_user WITH PASSWORD 'attendance_password';
CREATE DATABASE attendance_db OWNER attendance_user;
GRANT ALL PRIVILEGES ON DATABASE attendance_db TO attendance_user;
\q
EOF
```

### Create Application Configuration (`config.yaml`)

Create `config.yaml` inside `/home/ubuntu/attendance-api`:

```bash
cat > /home/ubuntu/attendance-api/config.yaml << 'EOF'
postgres:
  database: attendance_db
  host: localhost
  port: 5432
  user: attendance_user
  password: attendance_password
redis:
  host: localhost
  port: 6379
  password: ""
EOF
```

---

# 5. Implementation / Execution

## 5.1 Install Liquibase (v4.33.0)

Download and install Liquibase globally:

```bash
cd /tmp
wget https://github.com/liquibase/liquibase/releases/download/v4.33.0/liquibase-4.33.0.tar.gz
sudo mkdir -p /opt/liquibase
sudo tar -xzf liquibase-4.33.0.tar.gz -C /opt/liquibase
sudo ln -sf /opt/liquibase/liquibase /usr/local/bin/liquibase

# Verify installation
liquibase --version
```
<img width="1134" height="738" alt="image" src="https://github.com/user-attachments/assets/0d9066e3-77ad-4d61-a472-c3c0eb2e4ed7" />


---

## 5.2 Run Database Migrations

Create the Liquibase settings file and run migrations:

```bash
cd /home/ubuntu/attendance-api

cat > liquibase.properties << 'EOF'
url=jdbc:postgresql://localhost:5432/attendance_db
driver=org.postgresql.Driver
username=attendance_user
password=attendance_password
changeLogFile=migration/db.changelog-master.xml
EOF

# Run migrations
liquibase --defaultsFile=liquibase.properties update
liquibase --defaultsFile=liquibase.properties status
```

Expected output:

```text
Liquibase command 'update' was successful.
Database is up to date!
```

Check created tables:

```bash
psql -h localhost -U attendance_user -d attendance_db -c '\dt'
```
<img width="1097" height="268" alt="image" src="https://github.com/user-attachments/assets/88f2a4fe-6349-4cf8-a305-af4f496f4432" />

---

## 5.3 Test Application Manually

Test running the app in the terminal before making it a background service:

```bash
cd /home/ubuntu/attendance-api
poetry run gunicorn app:app --log-config log.conf -b 0.0.0.0:8080
```

Open a second terminal window and test the health check:

```bash
curl http://localhost:8080/api/v1/attendance/health
```

Expected response: `{"message": "Application is healthy"}`.
Press `Ctrl+C` in the first terminal to stop the test.

<img width="1446" height="277" alt="health" src="https://github.com/user-attachments/assets/445a3e7e-7257-4c43-868d-c9f3fc381b9e" />


---

## 5.4 Set Up Systemd Service

Create a system service so the app runs in the background and restarts automatically:

```bash
# Find exact gunicorn path
GUNICORN_PATH=$(cd /home/ubuntu/attendance-api && poetry run which gunicorn)

# Create service file
sudo tee /etc/systemd/system/attendance-api.service > /dev/null << EOF
[Unit]
Description=Attendance API Gunicorn Service
After=network.target postgresql.service redis-server.service
Wants=postgresql.service redis-server.service

[Service]
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu/attendance-api

ExecStart=${GUNICORN_PATH} \\
    app:app \\
    --log-config /home/ubuntu/attendance-api/log.conf \\
    --bind 0.0.0.0:8080

Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

# Start and enable the service
sudo systemctl daemon-reload
sudo systemctl start attendance-api
sudo systemctl enable attendance-api
```

---

# 6. Validation

## 6.1 Check Service Status and Port

Make sure the service is active and listening on port 8080:

```bash
sudo systemctl status attendance-api --no-pager
sudo ss -lntp | grep 8080
```

Expected output:

<img width="1818" height="715" alt="image" src="https://github.com/user-attachments/assets/c8a5b70b-9b5a-4abe-9616-c6ddb7643350" />


---

## 6.2 Test API Health and Swagger UI

Test the health endpoint:

```bash
curl -i http://localhost:8080/api/v1/attendance/health
```

Expected output:

<img width="1017" height="228" alt="image" src="https://github.com/user-attachments/assets/43db2883-3f7e-4946-b950-99b3972ef8cf" />

Open the Swagger documentation in your browser:

```text
http://<YOUR-EC2-PUBLIC-IP>:8080/apidocs/
```
<img width="1892" height="971" alt="swaggerui" src="https://github.com/user-attachments/assets/cf02d6f8-2c9f-4cb7-ae5d-86274cf04728" />

---

## 6.3 Test Database and Redis Caching

Check stored records in PostgreSQL:

```bash
psql -h localhost -U attendance_user -d attendance_db -c "SELECT * FROM records;"
```
<img width="1548" height="175" alt="image" src="https://github.com/user-attachments/assets/afbea928-5428-41d8-a501-36ea08909d67" />

Watch Redis caching in real time:

```bash
# Run monitor in terminal
redis-cli MONITOR

# Send a search request from Swagger or curl
# Terminal displays SETEX command showing key was cached for 20 seconds
```
<img width="1702" height="348" alt="Redis-cache" src="https://github.com/user-attachments/assets/2bfebcd4-3fb5-40ab-9fd9-66570537e6cb" />

---
## 6.4 Validation Checklist

| **Check**    | **Expected Result**                                 |
| ------------------ | --------------------------------------------------------- |
| System Packages    | Python 3.11, Java 17, and build tools installed           |
| PostgreSQL         | `attendance_user` can connect to `attendance_db`      |
| Redis              | `redis-cli ping` returns `PONG`                       |
| Liquibase          | Tables created successfully in database                   |
| Port 8080          | Port is open and listening                                |
| Health Check       | `GET /api/v1/attendance/health` returns HTTP 200        |
| Swagger UI         | Page opens in browser at`/apidocs/`                     |
| Background Service | `attendance-api` service status is `active (running)` |

---

# 7. Observations

## 7.1 Successfully Executed Components

| **Component**          | **Status** |
| ---------------------------- | ---------------- |
| Ubuntu System Packages       | PASS             |
| Python 3.11 & Poetry         | PASS             |
| PostgreSQL & Redis Services  | PASS             |
| Liquibase 4.33.0 Migrations  | PASS             |
| Gunicorn Daemon on Port 8080 | PASS             |
| Health Check & Swagger UI    | PASS             |

---

## 7.2 Issues Encountered and Fixed

| **Issue**                       | **How It Was Solved**                                                         |
| ------------------------------------- | ----------------------------------------------------------------------------------- |
| Ubuntu has newer default Python       | Installed Python 3.11 using deadsnakes PPA without replacing system Python.         |
| Liquibase command not found           | Extracted Liquibase to`/opt/liquibase` and created symlink in `/usr/local/bin`. |
| Gunicorn path changed per environment | Used`poetry run which gunicorn` to get the exact executable path for systemd.     |

---

## 7.3 Key Findings

| **Key Finding** | **Observation** |
| --------------- | --------------- |
| **Clean Setup** | Poetry keeps all Python dependencies in their own isolated environment. |
| **Easy Migrations** | Liquibase runs database schema updates automatically without writing manual SQL. |
| **Fast Responses** | Redis caches search results for 20 seconds to serve queries in under 2ms. |
| **Auto-Recovery** | Systemd automatically restarts the application within 5 seconds if it fails. |

---

# 8. Use Cases

| **Task**                | **Command**                                                                     |
| ----------------------------- | ------------------------------------------------------------------------------------- |
| View live logs                | `sudo journalctl -u attendance-api -f`                                              |
| View last 50 log lines        | `sudo journalctl -u attendance-api -n 50`                                           |
| Restart API service           | `sudo systemctl restart attendance-api`                                             |
| Check service status          | `sudo systemctl status attendance-api`                                              |
| Check port 8080               | `sudo ss -lntp \| grep 8080`                                                         |
| Check database records        | `psql -h localhost -U attendance_user -d attendance_db -c "SELECT * FROM records;"` |
| Update code after git changes | `git pull && sudo systemctl restart attendance-api`                                 |

---

# 9. Troubleshooting

| **Problem**                    | **Probable Cause**         | **Solution**                                                                                             |
| ------------------------------------ | -------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Service fails to start               | Syntax or config error           | Check logs:`sudo journalctl -u attendance-api -n 100 --no-pager`.                                            |
| Gunicorn not found                   | Wrong path in service file       | Run`cd ~/attendance-api && poetry run which gunicorn` and update service file.                               |
| Cannot connect to PostgreSQL         | PostgreSQL stopped               | Run`sudo systemctl start postgresql`.                                                                        |
| Database password error              | Wrong password in`config.yaml` | Reset password:`sudo -u postgres psql -c "ALTER USER attendance_user WITH PASSWORD 'attendance_password';"`. |
| Cannot connect to Redis              | Redis stopped                    | Run`sudo systemctl start redis-server`.                                                                      |
| Port 8080 not reachable from browser | Security Group blocked           | Allow TCP port 8080 in AWS EC2 Security Group.                                                                 |

---
# 10. Best Practices

| **Best Practice** | **Description** |
| ----------------- | --------------- |
| **Keep System Python Clean** | Always install Python 3.11 side-by-side using deadsnakes PPA without modifying Ubuntu's system Python. |
| **Use Dedicated Database User** | Use `attendance_user` instead of the default `postgres` superuser for better security. |
| **Manage Services with Systemd** | Run web applications as a systemd service with `Restart=always` for automatic recovery. |
| **Automate Database Migrations** | Use Liquibase changelogs to track and apply database changes automatically instead of manual SQL. |
| **Verify AWS Security Groups** | Ensure inbound TCP port 8080 is allowed in EC2 Security Groups before opening browser endpoints. |


---

# 11. Conclusion

This POC successfully demonstrates how to deploy the **Attendance API** on AWS EC2 Ubuntu.

All steps—including package installation, database setup, Liquibase migrations, and running Gunicorn on port 8080—have been completed and tested. The service is stable, healthy, and ready for review.

---

# 12. Contact Information

| **Name** | **Email**                                                                      |
| -------------- | ------------------------------------------------------------------------------------ |
| Amrendra       | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

# 13. References

| **Resource**          | **Link**                                                                                          |
| --------------------------- | ------------------------------------------------------------------------------------------------------- |
| Attendance API Repository   | [https://github.com/OT-MICROSERVICES/attendance-api](https://github.com/OT-MICROSERVICES/attendance-api) |
| Liquibase Official Releases | [https://github.com/liquibase/liquibase/releases](https://github.com/liquibase/liquibase/releases)       |
| Poetry Documentation        | [https://python-poetry.org/docs/](https://python-poetry.org/docs/)                                       |
| PostgreSQL Documentation    | [https://www.postgresql.org/docs/14/](https://www.postgresql.org/docs/14/)                               |
| Gunicorn Documentation      | [https://docs.gunicorn.org/](https://docs.gunicorn.org/)                                                 |
