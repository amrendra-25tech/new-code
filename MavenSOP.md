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
Clean Project (Deletes target directory):**
 
  mvn clean

<img width="1818" height="481" alt="mvn clean" src="https://github.com/user-attachments/assets/b9f8b894-73b8-43f6-8b77-bf3bf1c1da17" />

Compile Source Code:**
  
  mvn compile

 <img width="1712" height="550" alt="mvn-compile" src="https://github.com/user-attachments/assets/54d1aee6-c46d-474e-9b64-47727f4fcf5f" />


Run Unit Tests:**
 
  mvn test

<img width="1678" height="370" alt="skiptest" src="https://github.com/user-attachments/assets/afb6314b-b712-4013-9d54-d40d08dd6d6b" />


Package Application (Produces JAR/WAR inside target/):**

  mvn package
  
<img width="1302" height="257" alt="mvn package" src="https://github.com/user-attachments/assets/4e03ba0a-c6a5-4072-9e2c-739403bb68a4" />


Install to Local Repository (~/.m2/repository):**
 
  mvn install

  <img width="1831" height="633" alt="install" src="https://github.com/user-attachments/assets/42cca481-fb13-4e45-81f3-55653d8c9820" />


### Build Customizations
* **Skip Unit Tests during compilation or installation:**

  mvn clean install -DskipTests

<img width="1678" height="370" alt="skiptest" src="https://github.com/user-attachments/assets/afb6314b-b712-4013-9d54-d40d08dd6d6b" />


* **Download Dependencies Only (Without building):**
 
  mvn dependency:resolve
  
 <img width="1563" height="502" alt="dependency resolve" src="https://github.com/user-attachments/assets/00449e15-df0a-4473-bd83-3e03ec0794b9" />



# 3. Debugging & Troubleshooting Commands

Use these commands to diagnose compilation failures, dependency conflicts, environment properties, and cache corruption:

### Diagnostic Execution
* **Enable Debug Logging (Verbose output):**
 
  mvn clean install -X

  <img width="1662" height="617" alt="cleaninstall -x" src="https://github.com/user-attachments/assets/4ce40a6a-6c8b-4f8d-a1ae-57df772484a4" />

* **Show Full Error Stack Trace:**
 
  mvn clean install -e

  <img width="1685" height="568" alt="image" src="https://github.com/user-attachments/assets/e508c234-e0e5-4eb0-b8b1-b1ca000ec596" />

* **Force Update Dependencies and Plugins (Bypasses local cache):**
 
  mvn clean install -U
 <img width="1774" height="575" alt="image" src="https://github.com/user-attachments/assets/d33fa725-7929-463a-9730-39c95da7a592" />


### Configuration Diagnostics

* **Check System Environment and Java Info:**
 
  mvn help:system

  <img width="1853" height="909" alt="image" src="https://github.com/user-attachments/assets/c2b0c7fd-b064-45fe-a161-c114d335fe62" />


  
* **Clear Local Repository Cache (Force re-downloads):**
  
  rm -rf ~/.m2/repository
  
<img width="1285" height="131" alt="image" src="https://github.com/user-attachments/assets/82c3bc88-3d60-4f28-a412-6d2c87966e7a" />

  

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
