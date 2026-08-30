# SOP for Maven

---

# DOCUMENT INFORMATION

| **Author** | **Created On** | **Version** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | --------------------- | --------------------- | --------------------- |
| Amrendra         | 27-08-2026           | 1.0               | Shubham Rathi         | Shreya J / Nikita     | Piyush Upadhyay       |

---

# Table of Contents

1. [Purpose](#1-purpose)
2. [Commonly Used Commands](#2-commonly-used-commands)
3. [Debugging & Troubleshooting Commands](#3-debugging--troubleshooting-commands)
4. [Validation](#4-validation)
5. [Contact Information](#5-contact-information)
6. [References](#6-references)

---

# 1. Purpose

The purpose of this SOP is to provide a standardized reference guide focusing exclusively on the execution of commonly used Apache Maven commands and debugging/troubleshooting techniques in Ubuntu Linux environments.

These procedures help maintain build efficiency, resolve dependency conflicts, trace errors, and ensure system operational consistency.

---

# 2. Commonly Used Commands

Execute these standard commands during routine development, compiling, and testing workflows:

### Standard Build Phases
* **Clean Project (Deletes target directory):**
  ```bash
  mvn clean

<img width="1818" height="481" alt="mvn clean" src="https://github.com/user-attachments/assets/b9f8b894-73b8-43f6-8b77-bf3bf1c1da17" />

* **Compile Source Code:**
  ```bash
  mvn compile

 <img width="1712" height="550" alt="mvn-compile" src="https://github.com/user-attachments/assets/54d1aee6-c46d-474e-9b64-47727f4fcf5f" />

  ```
* **Run Unit Tests:**
  ```bash
  mvn test

<img width="1818" height="481" alt="mvn test" src="https://github.com/user-attachments/assets/39aba489-059a-48e3-aa42-72535f208f50" />


* **Package Application (Produces JAR/WAR inside target/):**
  ```bash
  mvn package

<img width="1302" height="257" alt="mvn package" src="https://github.com/user-attachments/assets/0b615f5c-006e-4739-a997-7be03d11271a" />


* **Install to Local Repository (~/.m2/repository):**
  ```bash
  mvn install

<img width="1831" height="633" alt="install" src="https://github.com/user-attachments/assets/321b42dd-826f-4f0a-8ade-c744957941a3" />



### Build Customizations
* **Skip Unit Tests during compilation or installation:**
  ```bash
  mvn clean install -DskipTests
<img width="1678" height="370" alt="skiptest" src="https://github.com/user-attachments/assets/cc076588-fd05-4cbc-b773-f230f2e584f9" />


  ```
* **Run Specific Unit Test Class:**
  ```bash
  mvn -Dtest=TestClassName test
  ```
* **Trace Dependency Tree / Hierarchy:**
  ```bash
  mvn dependency:tree
  ```
* **Download Dependencies Only (Without building):**
  ```bash
  mvn dependency:resolve
  ```
* **Run Spring Boot Application directly:**
  ```bash
  mvn spring-boot:run
  ```

---

# 3. Debugging & Troubleshooting Commands

Use these commands to diagnose compilation failures, dependency conflicts, environment properties, and cache corruption:

### Diagnostic Execution
* **Enable Debug Logging (Verbose output):**
  ```bash
  mvn clean install -X
  ```
* **Show Full Error Stack Trace:**
  ```bash
  mvn clean install -e
  ```
* **Force Update Dependencies and Plugins (Bypasses local cache):**
  ```bash
  mvn clean install -U
  ```

### Configuration Diagnostics
* **Check Effective POM Configuration (Merged configuration):**
  ```bash
  mvn help:effective-pom
  ```
* **Check System Environment and Java Info:**
  ```bash
  mvn help:system
  ```
* **Trace Dependency Conflicts in Detail:**
  ```bash
  mvn dependency:tree -Dverbose
  ```
* **Clear Local Repository Cache (Force re-downloads):**
  ```bash
  rm -rf ~/.m2/repository
  ```

### Useful Maven Execution Options
| Option | Meaning | Use Case |
| ------ | ------- | -------- |
| `-X` | Debug mode | Diagnostic and verbose logging output |
| `-q` | Quiet mode | Minimize output logs (errors only) |
| `-e` | Show errors | Produce complete error stack traces |
| `-D` | Define property | Pass system properties (e.g. `-DskipTests`) |
| `-o` | Offline mode | Execute builds without internet connection |

---

# 4. Validation

### Validate Maven Version and Java SDK Link
Ensure that the Maven installation is pointing to the correct active JDK runtime:
```bash
mvn -version
```
<img width="1371" height="512" alt="version" src="https://github.com/user-attachments/assets/7e2dc107-7a8a-4c32-ae56-a3c262f70e51" />

```

### Validate Local Dependency Resolution
Verify Maven can scan project files and output dependency maps:
```bash
mvn dependency:tree
```
**Expected Output:**
```text
[INFO] Scanning for projects...
[INFO] BUILD SUCCESS
```

### Final Validation Checklist
| **Validation** | **Expected Result** |
| -------------- | ------------------- |
| Version output test | `mvn -version` executes and outputs Java version 25.x |
| Compilation status check | `mvn compile` runs to completion and yields `BUILD SUCCESS` |
| Local cache validation | Local artifact cache is updated in `~/.m2/repository` |

---

# 5. Contact Information

| **Name** | **Email** |
| -------- | --------- |
| Amrendra | [amrendra.yadav.snaatak.@mygurukulam.co](mailto:amrendra.yadav.snaatak.@mygurukulam.co) |

---

# 6. References

| **Topic** | **Description** |
| --------- | --------------- |
| [Official Documentation](https://maven.apache.org/guides/index.html) | Official guide and references for Apache Maven. |
| [Linux Documentation](https://linux.die.net/) | Linux administration and command reference guide. |
| [Ubuntu Documentation](https://help.ubuntu.com/) | Ubuntu-specific administration and system documentation. |
