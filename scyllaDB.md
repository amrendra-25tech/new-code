## ScyllaDB setup POC
<p align="center">
  <img width="128" height="128" alt="ScyllaDB Icon" src="https://github.com/user-attachments/assets/3aee4f01-f9f5-49ea-b288-a6d4004d456c" />
</p>

---

## DOCUMENT INFORMATION

| Author   | Created On | Version | L0 Reviewer   | L1 Reviewer       | L2 Reviewer     |
| :------- | :--------- | :------ | :------------ | :---------------- | :-------------- |
| Amrendra | 27-08-2026 | 1.0     | Shubham Rathi | Shreya J / Nikita | Piyush Upadhyay |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Objective](#2-objective)
3. [Pre-requisites](#3-pre-requisites)
4. [Project Setup](#4-project-setup)
5. [Implementation / Execution](#5-implementation--execution)
6. [Validation](#6-validation)
7. [Observations](#7-observations)
8. [Troubleshooting](#8-troubleshooting)
9. [Best Practices](#9-best-practices)
10. [Conclusion](#10-conclusion)
11. [Contact Information](#11-contact-information)
12. [References](#12-references)

---

# 1. Introduction

This Proof of Concept (POC) demonstrates installing, configuring, and testing **ScyllaDB** on an AWS EC2 instance. ScyllaDB is a high-performance, open-source NoSQL database built in C++ that is 100% compatible with Apache Cassandra.

---

# 2. Objective

The objective of this POC is to:

- Install ScyllaDB on AWS EC2.
- Configure and start the database service.
- Verify cluster node health using `nodetool`.
- Test data creation, insertion, and querying using `cqlsh`.
- Define the roadmap for High Availability (HA) multi-node clustering.

---

# 3. Pre-requisites

| **Pre-requisite**    | **Details**                                                  |
| :------------------------- | :----------------------------------------------------------------- |
| **Operating System** | Ubuntu Linux (AWS EC2)                                             |
| **Private IP**       | `172.31.3.157`                                                   |
| **Required Ports**   | `9042` (Client queries via `cqlsh`), `7000` (Cluster gossip) |
| **Required Tools**   | `curl`, `gnupg`, `python3` (needed for `cqlsh` shell)      |
| **Permissions**      | `sudo` administrative privileges                                 |

---

# 4. Project Setup

### 4.1 Clean Existing Repositories

Remove any old or corrupted repository lists:

```bash
sudo rm -f /etc/apt/sources.list.d/scylla*
sudo apt-get update
```

### 4.2 Install Essential Tools

Install download and key management packages:

```bash
sudo apt-get install -y curl gnupg python3
```

---

# 5. Implementation / Execution

Follow these simple steps to install and start ScyllaDB:

### Step 1: Run the Official ScyllaDB Installer

```bash
curl -sSf https://get.scylladb.com/server | sudo bash
```

### Step 2: Fix GPG Keyring Permissions

Export the signing key and set readable permissions so Ubuntu's package manager can verify packages:

```bash
sudo gpg --homedir /tmp --no-default-keyring --keyring /tmp/temp.gpg --export C503C686B007F39E | sudo tee /etc/apt/keyrings/scylladb.gpg > /dev/null
sudo cp /etc/apt/keyrings/scylladb.gpg /etc/apt/trusted.gpg.d/scylladb.gpg
sudo chmod 644 /etc/apt/keyrings/scylladb.gpg /etc/apt/trusted.gpg.d/scylladb.gpg
```

### Step 3: Install ScyllaDB Packages

```bash
sudo apt-get update
sudo apt-get install -y scylla
```

### Step 4: Configure Developer Mode & CPU Resources

Enable developer mode to allow ScyllaDB to run smoothly on cloud VMs, and limit CPU to 1 core so available memory is not over-divided:

```bash
sudo scylla_dev_mode_setup --developer-mode 1
echo 'CPUSET="--smp 1"' | sudo tee /etc/scylla.d/cpuset.conf
```

### Step 5: Start the ScyllaDB Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable scylla-server
sudo systemctl start scylla-server
```

---

# 6. Validation

### 6.1 Check Service Status

Verify that ScyllaDB is active and running:

```bash
sudo systemctl status scylla-server --no-pager
```

<img width="1628" height="555" alt="image" src="https://github.com/user-attachments/assets/d492f2f7-d701-4924-ad6f-bdc7544316cd" />


---

### 6.2 Check Node Health via `nodetool`

```bash
nodetool status
```

<img width="1280" height="235" alt="image" src="https://github.com/user-attachments/assets/aad04c79-e8fd-4740-a06b-b362707229ef" />


---

### 6.3 Test Database Queries via `cqlsh`

Connect to the database shell:

```bash
cqlsh localhost 9042
```

Run test queries inside `cqlsh`:

```sql
-- 1. Create Keyspace
CREATE KEYSPACE poc_keyspace 
WITH replication = {'class': 'NetworkTopologyStrategy', 'datacenter1': 1};

-- 2. Create Table
CREATE TABLE poc_keyspace.audit_log (
    event_id uuid PRIMARY KEY,
    service_name text,
    status text,
    created_at timestamp
);

-- 3. Insert Record
INSERT INTO poc_keyspace.audit_log (event_id, service_name, status, created_at)
VALUES (uuid(), 'user-auth-service', 'SUCCESS', toTimestamp(now()));

-- 4. Query Data
SELECT * FROM poc_keyspace.audit_log;
```

**Verified Output:**
<img width="995" height="214" alt="image" src="https://github.com/user-attachments/assets/194de8b5-1349-4827-ad1a-8a3e8e34a4e4" />



---

### 6.4 High Availability (HA) Multi-Node Note

* In this POC, **1 EC2 instance** was used with `replication_factor: 1`.
* In staging/production, when 2 additional EC2 instances join the cluster, scale to full High Availability (3 copies of data) by running:
  ```sql
  ALTER KEYSPACE poc_keyspace WITH replication = {'class': 'NetworkTopologyStrategy', 'datacenter1': 3};
  ```

---

# 7. Observations



| **Component**            | **Status** | **Result**                     |
| :----------------------------- | :--------------: | :----------------------------------- |
| **Package Installation** |       PASS       | ScyllaDB installed successfully      |
| **Service Daemon**       |       PASS       | Systemd auto-starts service          |
| **Node Ring State**      |       PASS       | `nodetool status` shows `UN`     |
| **Data CRUD Operations** |       PASS       | Records written and read in`cqlsh` |



---

# 8. Troubleshooting

| **Issue**                  | **Cause**                            | **Quick Fix**                                                 |
| :------------------------------- | :----------------------------------------- | :------------------------------------------------------------------ |
| `NO_PUBKEY ...`                | APT cannot read key file                   | Run`sudo chmod 644 /etc/apt/keyrings/scylladb.gpg`                |
| `memory per shard too low`     | RAM divided by too many cores              | Run`echo 'CPUSET="--smp 1"' \| sudo tee /etc/scylla.d/cpuset.conf` |
| `SimpleStrategy not supported` | Modern ScyllaDB requires topology strategy | Use`{'class': 'NetworkTopologyStrategy', 'datacenter1': 1}`       |

---

# 9. Best Practices

| **Best Practice**               | **Description**                                                                                           |
| :------------------------------------ | :-------------------------------------------------------------------------------------------------------------- |
| **Use Private IPs**             | Bind database communications to EC2 Private IPs (`172.31.x.x`) for free, secure, high-speed internal traffic. |
| **Configure Security Groups**   | Open port`9042` for application clients and restrict port `7000` strictly to internal cluster nodes.        |
| **Use NetworkTopologyStrategy** | Always use`NetworkTopologyStrategy` to ensure compatibility with modern ScyllaDB tablet replication.          |
| **Automate Periodic Backups**   | Schedule regular database snapshots using`nodetool snapshot` and archive SSTables to AWS S3.                  |

---

# 10. Conclusion

This POC successfully validates that ScyllaDB runs smoothly on AWS EC2. The service is active, the node status is healthy (`UN`), and live data write/read operations were verified via `cqlsh`. 
The setup is reliable and ready to be scaled into a multi-node High Availability cluster.

Based on the setup and findings of this POC, the comprehensive detailed documentation (covering complete configuration breakdowns, architecture, and production runbooks) can be accessed here:

**Detailed Documentation (Based on POC):** https://github.com/SnaatakAllStars/Sprint-1/blob/SCRUM-81-RITU/Documentation/OT_MS_Understanding/ScyllaDB/DOC/README.md

---

# 11. Contact Information

| Name     | Email                                                                                |
| :------- | :----------------------------------------------------------------------------------- |
| Amrendra | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

# 12. References

| **Resource**              | **Link**                                                                                                                                                                                            |
| :------------------------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Official ScyllaDB Documentation | [https://docs.scylladb.com/stable/](https://docs.scylladb.com/stable/)                                                                                                                                     |
| ScyllaDB on AWS EC2 Guide       | [https://docs.scylladb.com/stable/operating-scylla/procedures/tips/best-practices-scylla-on-ec2.html](https://docs.scylladb.com/stable/operating-scylla/procedures/tips/best-practices-scylla-on-ec2.html) |
| Cassandra Query Language (CQL)  | [https://cassandra.apache.org/doc/latest/cassandra/cql/](https://cassandra.apache.org/doc/latest/cassandra/cql/)                                                                                           |
