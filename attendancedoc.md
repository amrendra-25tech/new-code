
<p align="center">
<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/63359ecd-3412-4d20-8cd4-3d19bf4ac33d" />
  
</p>

---

<h1 align="left"> Attendance | Detailed documentation</h1>

---

## Author Information

| **Author**  | **Created on** | **Version** |  **Last edited on** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ----------- | -------------- | ------------------- | ------------------ | --------------- | --------------- | --------------- |
| Riya Chauhan | 14-09-26 | v1.0 | 14-09-26 | Deepak Kushwaha | Faisal/Mohit Kumar | Mahesh kumar/Varun |
---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Purpose](#2-purpose)
3. [Key Objectives](#3-key-objectives)
4. [Pre-Requisites](#4-pre-requisites)
   * [4.1 System Requirements](#-41-system-requirements)
   * [4.2 Dependencies](#-42-dependencies)
      * [4.2.1 Build Time Dependencies](#-421-build-time-dependencies)
      * [4.2.2 Run Time Dependencies](#-422-run-time-dependencies)
      * [4.2.3 Other Dependencies](#-423-other-dependencies)
   * [4.3 Important Ports](#-43-important-ports)
      * [4.3.1 Inbound Traffic](#-431-inbound-traffic)
      * [4.3.2 Outbound Traffic](#-432-outbound-traffic)
5. [Architecture](#5-architecture)
   * [5.1 Architecture Overview](#-51-architecture-overview)
   * [5.2 Core Components](#-52-core-components)
   * [5.3 API Request Flow](#-53-api-request-flow)
   * [5.4 Caching Mechanism](#-54-caching-mechanism)
   * [5.5 Database Layer](#-55-database-layer)
   * [5.6 Monitoring and Metrics](#-56-monitoring-and-metrics)
6. [Application Startup Workflow](#6-application-startup-workflow)
7. [Health Check](#7-health-check)
8. [Logging and Monitoring](#8-logging-and-monitoring)
   * [8.1 Application Logs](#-81-application-logs)
   * [8.2 Health Monitoring](#-82-health-monitoring)
   * [8.3 Metrics Monitoring](#-83-metrics-monitoring)
9. [Troubleshooting](#9-troubleshooting)
10. [FAQs](#10-faqs)
11. [How to Bring Up the Attendance API](#11-how-to-bring-up-the-attendance-api)
12. [Contact Information](#12-contact-information)
13. [References](#13-references)

---

# 1. Introduction

The **Attendance API** is a Python Flask microservice. It manages employee attendance records. It uses Python 3.11, Gunicorn, PostgreSQL, Redis, and Liquibase for fast and reliable service.

---

# 2. Purpose

The purpose of the Attendance API is to track employee attendance records efficiently. It provides fast read access using Redis cache, safe data storage in PostgreSQL, and automated database migrations using Liquibase.

---

# 3. Key Objectives

| Objective | Description |
|---|---|
| Centralized Tracking | Track employee attendance (present, absent, leave) in one place. |
| Independent Service | Deploy and update the attendance service independently. |
| Fast Performance | Use Redis caching to respond to search queries in under 2ms. |
| Reliable Storage | Store records safely using PostgreSQL with ACID compliance. |
| Automated Migrations | Apply database schema changes automatically using Liquibase. |
| Fault Tolerance | Fall back to PostgreSQL if Redis cache is temporarily down. |
| Easy Observability | Monitor service health, systemd logs, and Prometheus metrics. |

---

# 4. Pre-Requisites

Ensure the following requirements are met before running the Attendance API.

---

## &nbsp;&nbsp;&nbsp;&nbsp; 4.1 System Requirements

### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hardware Specifications

| Hardware | Recommendation |
|---|---|
| Cloud Platform | AWS |
| Service | Amazon EC2 |
| Operating System | Ubuntu 22.04 LTS (x86_64) |
| Instance Type | t3.medium (2 vCPU, 4 GB RAM) |
| Storage | 20 GB gp3 SSD |

---

## &nbsp;&nbsp;&nbsp;&nbsp; 4.2 Dependencies

### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.2.1 Build Time Dependencies

| Name | Version | Description |
|---|---|---|
| Python | 3.11 | Programming language |
| Poetry | 1.8+ | Dependency and environment manager |
| build-essential | Latest | Compiler toolchain (gcc, make) |
| libpq-dev | 14+ | PostgreSQL header files for `psycopg2` |
| OpenJDK | 17-jdk | Java runtime for Liquibase |

---

### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.2.2 Run Time Dependencies

| Name | Version | Description |
|---|---|---|
| Python 3.11 | 3.11 | Application runtime environment |
| Gunicorn | 21.0+ | WSGI web server for Flask |
| PostgreSQL | 14+ | Relational database (`attendance_db`) |
| Redis | 6.0+ | In-memory key-value cache |
| Liquibase | 4.33.0 | Schema migration tool |
| PostgreSQL JDBC | 42.7.2 | Database driver jar for Liquibase |

---

### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.2.3 Other Dependencies

| Name | Version | Description |
|---|---|---|
| Prometheus Exporter | Bundled (`/metrics`) | Metrics collection |
| Swagger UI | Bundled (`/apidocs/`) | Interactive API test documentation |
| Git | 2.34+ | Version control tool to clone code |

---

## &nbsp;&nbsp;&nbsp;&nbsp; 4.3 Important Ports

### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.3.1 Inbound Traffic

| Port | Protocol | Description |
|---|---|---|
| 22 | TCP | SSH remote terminal access |
| 8080 | TCP | HTTP traffic to Attendance API |

---

### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.3.2 Outbound Traffic

| Port | Protocol | Description |
|---|---|---|
| 5432 | TCP | Connection to PostgreSQL database |
| 6379 | TCP | Connection to Redis cache |

---

# 5. Architecture

## &nbsp;&nbsp;&nbsp;&nbsp; 5.1 Architecture Overview

The Attendance API follows a microservices architecture. It handles attendance operations independently. It connects to Redis for caching and PostgreSQL for persistent data storage.

Key benefits:
* Independent deployment
* Fast API response times
* High reliability and fault isolation
* Simple maintenance

---

## &nbsp;&nbsp;&nbsp;&nbsp; 5.2 Core Components

| Component | Description |
|---|---|
| Client | Sends HTTP requests to the API. |
| Gunicorn | Production WSGI server managing application workers. |
| Flask API | Application handling business logic and routes. |
| Redis | In-memory cache for fast search queries. |
| PostgreSQL | Relational database storing employee records. |
| Liquibase | Database tool for managing schema changes. |

---

## &nbsp;&nbsp;&nbsp;&nbsp; 5.3 API Request Flow

1. **Client Request**: Client sends an HTTP request to port `8080`.
2. **Gunicorn WSGI**: Receives request and sends it to a Flask worker.
3. **Write Flow (`POST /attendance/create`)**:
   - Flask validates the request payload.
   - Record is saved directly into PostgreSQL.
4. **Read Flow (`GET /api/v1/attendance/search?id=...`)**:
   - First, the API checks Redis cache.
   - **Cache Hit**: Returns data immediately (< 2ms).
   - **Cache Miss**: Reads data from PostgreSQL, caches it in Redis for 20 seconds, and returns it.

---

## &nbsp;&nbsp;&nbsp;&nbsp; 5.4 Caching Mechanism

Redis stores frequently accessed search queries in memory using the Cache-Aside pattern.

* **Cache TTL**: 20 seconds.
* **Speed**: Responses return in under 2ms on cache hit.
* **Graceful Fallback**: If Redis is offline, the API queries PostgreSQL directly.

---

## &nbsp;&nbsp;&nbsp;&nbsp; 5.5 Database Layer

PostgreSQL 14 stores attendance records safely and durably.

* Uses Peewee ORM and `psycopg2` driver.
* Liquibase automatically manages schema changes via `db.changelog-master.xml`.
* Guarantees data consistency with ACID compliance.

---

## &nbsp;&nbsp;&nbsp;&nbsp; 5.6 Monitoring and Metrics

The Attendance API exposes built-in observability endpoints:

* **Health Endpoint**: Checks application readiness and dependencies.
* **Metrics Endpoint**: Exposes Prometheus-compatible operational metrics.

---

# 6. Application Startup Workflow

1. Systemd starts `attendance-api.service`.
2. Gunicorn starts on port `8080` using Python 3.11.
3. Flask loads configuration from `config.yaml`.
4. Database and Redis connections are established.
5. API endpoints and Swagger documentation (`/apidocs/`) become active.
6. The service is ready to handle traffic.

---

# 7. Health Check

Verify application health using `curl`:

```bash
curl http://localhost:8080/api/v1/attendance/health
```

### Expected Output
```json
{"message": "Application is healthy"}
```

Run detailed health check (tests database and Redis):

```bash
curl http://localhost:8080/attendance/health/detail
```

### Expected Output
```json
{"message": "Application is healthy", "postgresql": "healthy", "redis": "healthy", "status": "UP"}
```

---

# 8. Logging and Monitoring

## &nbsp;&nbsp;&nbsp;&nbsp; 8.1 Application Logs

Logs record application activity, incoming requests, and errors. They help identify startup failures and database issues quickly.

```bash
# View live service logs
sudo journalctl -u attendance-api -f

# View file logs
tail -f /home/ubuntu/attendance-api/app.log
```

---

## &nbsp;&nbsp;&nbsp;&nbsp; 8.2 Health Monitoring

Health monitoring checks if the application and its dependencies are operational. Load balancers and orchestrators use these checks to route traffic only to healthy instances.

### Health Endpoints

| Endpoint | Type | Target Component | Description | Expected Status |
|---|---|---|---|---|
| `/api/v1/attendance/health` | Liveness | Flask API | Checks if the application process is running and accepting traffic | `{"message": "Application is healthy"}` |
| `/attendance/health/detail` | Readiness | PostgreSQL & Redis | Checks if database and cache connections are active | `{"postgresql": "healthy", "redis": "healthy", "status": "UP"}` |

### Health Check Commands

```bash
# Check basic application health
curl http://localhost:8080/api/v1/attendance/health

# Check detailed database and cache health
curl http://localhost:8080/attendance/health/detail
```

---

## &nbsp;&nbsp;&nbsp;&nbsp; 8.3 Metrics Monitoring

The Attendance API exports operational metrics at `/metrics`. Prometheus scrapes this endpoint at regular intervals to monitor real-time performance and trigger alerts.

### Key Metrics

| Metric Name | Type | Description | Target / Purpose |
|---|---|---|---|
| `flask_http_request_total` | Counter | Total HTTP requests by method, route, and status | Tracks traffic volume and error rates (4xx, 5xx) |
| `flask_http_request_duration_seconds` | Histogram | Request processing time and latency | Ensures search queries complete in under 2ms |
| `process_cpu_seconds_total` | Counter | Total CPU time spent by Gunicorn worker processes | Detects CPU spikes and processing bottlenecks |
| `process_resident_memory_bytes` | Gauge | Physical memory used by the application in bytes | Monitors memory usage and prevents memory leaks |

### Metrics Commands

```bash
# View HTTP request metrics
curl -s http://localhost:8080/metrics | grep flask_http_request_total

# View application memory usage
curl -s http://localhost:8080/metrics | grep process_resident_memory_bytes
```

---

# 9. Troubleshooting

| Problem | Cause | Quick Fix / Command |
|---|---|---|
| Service fails to start | Missing dependencies or wrong path | Check service logs:<br>`sudo journalctl -u attendance-api -n 20` |
| Database connection error | PostgreSQL stopped or wrong credentials | Check service status:<br>`sudo systemctl status postgresql`<br>Verify password in `config.yaml` |
| Liquibase migration failure | Wrong DB URL or driver missing | Check migration status:<br>`liquibase --defaultsFile=liquibase.properties status` |
| Redis connection error | Redis service is not running | Restart Redis:<br>`sudo systemctl restart redis-server` |
| Port 8080 in use | Another process is using port 8080 | Find process:<br>`sudo ss -ltnp \| grep 8080` |
| Cannot access API from outside | Security Group blocking port 8080 | Allow inbound TCP port 8080 in AWS Security Group |
| Python build error | Missing C compiler or headers | Install headers:<br>`sudo apt install -y gcc libpq-dev build-essential` |

---

# 10. FAQs

**Question:** Is this application free?  
**Answer:** Yes, it is open-source under the Apache 2.0 license.

**Question:** Can it be deployed on all cloud platforms?  
**Answer:** Yes, it can be deployed on AWS, Azure, GCP, or on-premises servers.

**Question:** Is an enterprise version required?  
**Answer:** No, only the open-source microservice version is required.

---

# 11. How to Bring Up the Attendance API

To set up and run this application, refer to the official repository documentation:

👉 [Attendance POC Documentation](https://faisalakhan98.atlassian.net/browse/SCRUM-68)

---

# 12. Contact Information

| Name | Email Address |
|---|---|
| Riya Chauhan | [riya.chauhan.snaatak@mygurukulam.co](mailto:riya.chauhan.snaatak@mygurukulam.co) |

---

# 13. References

| Topic | Description |
|---|---|
| [Attendance API Repository](https://github.com/OT-MICROSERVICES/attendance-api) | Official application source code, Makefile, and migration changelogs |
| [Liquibase Documentation](https://docs.liquibase.com/) | Liquibase installation and schema migration guide |
| [Gunicorn WSGI Documentation](https://docs.gunicorn.org/) | Gunicorn configuration and worker guide |
| [PostgreSQL Documentation](https://www.postgresql.org/docs/14/) | PostgreSQL setup and administration guide |
| [Redis Documentation](https://redis.io/documentation) | Redis caching and CLI reference |
