<p align="Left">
  <img width="480" height="360" alt="image" src="C:/Users/Anurag/.gemini/antigravity/brain/a1cf814c-8145-4526-a22f-2b2e0309d6fb/.user_uploaded/media_1787644423864.png" />
</p>

# SOP for Maven

---

# Author Table

| **Author** | **Created On** | **Version** | **Last Updated By** | **Last Edited On** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------- | -------------- | ----------- | ------------------- | ------------------ | --------------- | --------------- | --------------- |
| Amrendra   | 27-08-2026     | 1.0         | Amrendra            | 27-08-2026         |  Shubham Rathi  | Shreya J/Nikita | Piyush Upadhyay |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Purpose](#2-purpose)
3. [Prerequisites](#3-prerequisites)
4. [Installation & Setup](#4-installation--setup)
5. [Configuration & Lifecycle Management](#5-configuration--lifecycle-management)
6. [Project Lifecycle Execution](#6-project-lifecycle-execution)
7. [Validation](#7-validation)
8. [Use Cases](#8-use-cases)
9. [Troubleshooting](#9-troubleshooting)
10. [Best Practices](#10-best-practices)
11. [Conclusion](#11-conclusion)
12. [Contact Information](#12-contact-information)
13. [References](#13-references)

---

# 1. Introduction

This SOP provides a structured guide to **installing, configuring, running, and debugging Apache Maven** in **Ubuntu Linux environment**.

It covers the required configuration, verification, monitoring, validation, and troubleshooting steps.

---

# 2. Purpose

The purpose of this SOP is to provide a standardized procedure for:

- Installing Apache Maven via package managers and manual setups.
- Managing Maven's repository configuration (`settings.xml`).
- Executing standard build lifecycle phases safely.
- Resolving and troubleshooting dependency conflicts and plugin failures.

These procedures help maintain **system stability, reliability, performance, and operational consistency**.

---

# 3. Prerequisites

| **Prerequisite** | **Details** |
| ---------------- | ----------- |
| OS & Access | Ubuntu 22.04+ LTS with SSH/terminal access |
| Required Packages | `openjdk-25-jdk`, `curl`, `wget` |
| Required Commands | `java`, `javac`, `apt` |
| Permissions | `sudo` or root privileges for installation |
| Network | Outbound internet access to reach Maven Central and repositories |
| Configuration | Valid `JAVA_HOME` environment variable configured |

---

# 4. Installation & Setup

## Step 1: Install Apache Maven

Update local repository definitions and install Maven using the APT package manager.

```bash
sudo apt update
sudo apt install -y maven
```

Expected output:

```text
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
...
Setting up maven (3.8.7-1) ...
```

<details>
<summary>📸 <strong>Screenshot - Package Installation Success</strong></summary>

<img width="480" height="360" alt="image" src="C:/Users/Anurag/.gemini/antigravity/brain/a1cf814c-8145-4526-a22f-2b2e0309d6fb/.user_uploaded/media_1787644423864.png" />

</details>

---

## Step 2: Environment Variables Configuration

Ensure `MAVEN_HOME` and execution paths are loaded into the user shell profile.

```bash
echo 'export MAVEN_HOME=/usr/share/maven' >> ~/.bashrc
echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

---

# 5. Configuration & Lifecycle Management

## Step 1: Manage Maven Configuration Files

Configure system-wide or user-specific mirrors and repositories.

```bash
mkdir -p ~/.m2
cp /etc/maven/settings.xml ~/.m2/settings.xml
```

### Configuration

The `~/.m2/settings.xml` file configures local repository paths, proxy settings, and mirrors:

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd">
  <localRepository>${user.home}/.m2/repository</localRepository>
  <interactiveMode>true</interactiveMode>
  <offline>false</offline>
</settings>
```

### Verification

Verify Maven is utilizing the configured path and system settings.

```bash
mvn help:effective-settings
```

Expected:

```text
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" ...>
  <localRepository>/home/ubuntu/.m2/repository</localRepository>
</settings>
```

---

# 6. Project Lifecycle Execution

## Step 1: Project Generation

Generate a standard Java application project template using Maven archetypes.

```bash
mvn archetype:generate -DgroupId=com.mygurukulam -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

## Step 2: Standard Build Process

Compile the code, run tests, and package the application into a JAR/WAR file.

```bash
cd my-app
mvn clean package
```

> [!NOTE]
> The `clean` phase deletes the `target` directory, ensuring all compiled files are built from scratch.

---

# 7. Validation

### Validate Maven Environment

Verify that the installed Maven executable is properly pointing to the active Java SDK.

```bash
mvn -version
```

**Expected:**

```text
Apache Maven 3.8.7
Maven home: /usr/share/maven
Java version: 25.0.4.1, vendor: Oracle Corporation, runtime: /usr/lib/jvm/java-25-openjdk-amd64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "6.8.0-1011-aws", arch: "amd64", family: "unix"
```

### Validate Project Compilation

Verify that the local project build produces the target executable artifact successfully.

```bash
mvn compile
```

**Expected:**

```text
[INFO] Scanning for projects...
[INFO] Building my-app 1.0-SNAPSHOT
[INFO] --- maven-resources-plugin:3.3.0:resources (default-resources) ---
[INFO] --- maven-compiler-plugin:3.10.1:compile (default-compile) ---
[INFO] Compiling 1 source file to /home/ubuntu/my-app/target/classes
[INFO] BUILD SUCCESS
```

### Final Validation Checklist

| **Validation** | **Expected Result** |
| -------------- | ------------------- |
| `mvn -version` execution | Reports Apache Maven version 3.8.x and Java 25.x |
| Compilation status check | Build finishes with status `BUILD SUCCESS` |
| Target artifact verification | The JAR file is generated inside the `target/` directory |
| Local repository check | Dependencies cached under `~/.m2/repository/` |

---

# 8. Use Cases

| **Scenario** | **Commands / Actions** |
| ------------ | ---------------------- |
| Force update dependencies | `mvn clean install -U` |
| Package without running unit tests | `mvn clean package -DskipTests` |
| Run a specific test class | `mvn test -Dtest=AppTest` |
| Build application in offline mode | `mvn clean package -o` |
| Trace dependency hierarchy | `mvn dependency:tree` |
| Clean compile and build | `mvn clean compile` |

---

# 9. Troubleshooting

| **Issue** | **Cause** | **Solution** |
| --------- | --------- | ------------ |
| `JAVA_HOME is not defined correctly` | Environmental path variable pointing to non-existent JDK directory | Update shell configuration `~/.bashrc` to point to `/usr/lib/jvm/java-25-openjdk-amd64` |
| `Failed to collect dependencies` | Inability to resolve repository URLs due to networking or proxy config | Define proxy rules in `~/.m2/settings.xml` or run in offline mode using `-o` |
| `OutOfMemoryError` | Default JVM heap space allocated to Maven builder is insufficient | Set environment variable: `export MAVEN_OPTS="-Xmx1024m -XX:MaxMetaspaceSize=512m"` |
| Plugin execution error | Corrupt plugin artifact cached in local repository | Delete corresponding directories under `~/.m2/repository/` and rerun with `-U` |

---

# 10. Best Practices

| **Best Practice** | **Description** |
| ----------------- | --------------- |
| Use `dependencyManagement` | Manage common dependency versions in parent POM file for multi-module projects |
| Keep plugins versioned | Explicitly define plugin versions in POM files to guarantee build repeatability |
| Clean before building | Always include `clean` lifecycle command (`mvn clean package`) for production/CI releases |
| Configure Enterprise Mirrors | Route dependency requests through secure internal mirrors (e.g., Nexus or Artifactory) |
| Minimize Snapshot Dependencies | Avoid release builds depending on `-SNAPSHOT` versions to ensure version immutability |

---

# 11. Conclusion

This SOP provides a standardized approach to **Apache Maven build system** in **Ubuntu Linux environment**.

Following these procedures helps administrators maintain **reliability, performance, security, and operational stability** while providing a consistent approach to configuration, validation, and troubleshooting.

---

# 12. Contact Information

| **Name** | **Email** |
| -------- | --------- |
| Amrendra | [amrendra@mygurukulam.co](mailto:amrendra@mygurukulam.co) |

---

# 13. References

| **Topic** | **Description** |
| --------- | --------------- |
| [Official Documentation](https://maven.apache.org/guides/index.html) | Official guide and references for Apache Maven. |
| [Linux Documentation](https://linux.die.net/) | Linux administration and command reference guide. |
| [Ubuntu Documentation](https://help.ubuntu.com/) | Ubuntu community and official system documentation. |
