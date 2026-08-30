# Java  Installation Guide Documentation

---

# Document Information

| **Author** | **Created On** | **Version** | **L0 Reviewer**           | **L1 Reviewer**             | **L2 Reviewer**             |
| ---------------- | -------------------- | ----------------- | ------------------------------- | --------------------------------- | --------------------------------- |
| Amrendra         | 25-08-2026           | 1.0               | Shubham Rathi<L0 Reviewer></l0> | Shreya J/Nikita<L1 Reviewer></l1> | Piyush Upadhyay<L2 Reviewer></l2> |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [What is Java](#2-what-is-java)
3. [What is Java Installation](#3-what-is-java-installation)
4. [Why Java Installation is Required](#4-why-java-installation-is-required)
5. [Java Installation Guide Workflow](#5-java-installation-guide-workflow)
   - [5.1 Workflow Diagram](#51-workflow-diagram)
6. [Different Tools for Java Installation](#6-different-tools-for-java-installation)
7. [Best Practices](#7-best-practices)
8. [Recommendation / Conclusion](#8-recommendation--conclusion)
9. [Contact Information](#9-contact-information)
10. [References](#10-references)

---

# 1. Introduction

This document serves as a step-by-step setup guide for installing and configuring the Java Development Kit (JDK) on Windows and Ubuntu/Linux systems. It provides standard procedures to install JDK 25, configure environment variables, verify installations, and troubleshoot common setup issues.

---

# 2. What is Java

Java is a popular, object-oriented programming language used for building web, mobile, and enterprise applications. It runs on any device using the Java Virtual Machine (JVM). This guide uses Java JDK 25 LTS (version 25.0.4.1).

---

# 3. What is Java Installation

Java installation is the process of setting up the Java runtime environment and development tools on Windows or Ubuntu/Linux systems. Before installing Java, make sure you have:

* A computer with Windows or Linux.
* Administrator/sudo access.
* An active internet connection.
* Sufficient disk space for the JDK installation.

### JDK vs JRE vs JVM

| Component     | Description                                                                       |
| ------------- | --------------------------------------------------------------------------------- |
| **JDK** | Java Development Kit. Used to develop, compile, debug, and run Java applications. |
| **JRE** | Java Runtime Environment. Used to run Java applications.                          |
| **JVM** | Java Virtual Machine. Executes Java bytecode                                      |

---

# 4. Why Java Installation is Required

Configuring the Java JDK environment is essential for several reasons:

- **Development Capabilities:** The JDK provides the compiler (`javac`) and other development tools required to convert human-readable source code into machine-executable bytecode.
- **Application Execution:** Running modern enterprise services, CI/CD utilities (such as Jenkins runner nodes), and server platforms requires a stable Java Virtual Machine (JVM).
- **Tool Integration:** Build systems like Maven or Gradle and code checkers rely on the `JAVA_HOME` environment variable to locate standard libraries and compiler tools.

---

# 5. Java Installation Guide Workflow

The installation workflow varies between operating systems. Below is a unified workflow covering both Windows and Linux installations.

### Windows Installation Workflow:

1. **Download:** Download the Windows x64 Installer (.exe) from Oracle.
2. **Execute:** Run the installer and complete the installation wizard.
3. **Environment Setup:** Configure the `JAVA_HOME` system variable and edit the system `PATH` variable.
4. **Verification:** Validate the setup using version and location checks.

### Ubuntu/Linux Installation Workflow:

1. **Repository Sync:** Update local repository information.
2. **Package Install:** Install OpenJDK 25 using `apt`.
3. **Paths configuration:** Configure `JAVA_HOME` and update the shell profile (`.bashrc`).
4. **Alternatives Config:** Manage multiple runtime targets via `update-alternatives`.

## 5.1 Workflow Diagram

```mermaid
graph TD
    Start([Start]) --> OSCheck{Operating System?}
  
    %% Windows Flow
    OSCheck -- Windows --> WinDown[Download Windows x64 Installer .exe]
    WinDown --> WinRun[Run Installer & Install to default folder]
    WinRun --> WinHome[Configure JAVA_HOME in System Variables]
    WinHome --> WinPath[Add %JAVA_HOME%\bin to Path]
    WinPath --> WinVerify[Verify: java -version & javac -version]
  
    %% Linux Flow
    OSCheck -- Ubuntu/Linux --> LinUpdate[Run: sudo apt update]
    LinUpdate --> LinInstall[Install OpenJDK: sudo apt install openjdk-25-jdk]
    LinInstall --> LinHome[Append JAVA_HOME & PATH in ~/.bashrc]
    LinHome --> LinReload[Reload environment: source ~/.bashrc]
    LinReload --> LinVerify[Verify: java -version & javac -version]
  
    WinVerify --> End([End: Environment Setup Completed])
    LinVerify --> End
```

</details>

---

# 6. Different Tools for Java Installation

| **Tool**                      | **Description**                                                                                   |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Oracle Installer (.exe)**   | The official executable installer package distributed by Oracle for Windows systems.                    |
| **APT Package Manager**       | Command-line utility on Ubuntu/Debian used to install OpenJDK packages from official repositories.      |
| **Manual Tarball Extraction** | Extracting archive formats directly to a chosen location and manual management of runtime environments. |

---

# 7. Best Practices

Here are step-by-step procedures, validation methods, troubleshooting guides, and useful command references for setting up JDK 25.

### 7.1 Detailed Windows Setup & Verification

1. **Download & Run Installer:**
   * Download the **Windows x64 Installer (.exe)** from the [Oracle Java Downloads](https://www.oracle.com/in/java/technologies/?utm_source=chatgpt.com) page.
   * Run the `.exe` file, grant permission, and keep the default installation location (`C:\Program Files\Java\`).
2. **Configure `JAVA_HOME`:**
   * Open Environment Variables (Press `Windows + R`, type `sysdm.cpl`, go to the *Advanced* tab, and click *Environment Variables*).
   * Under *System variables*, click **New**. Set Variable name: `JAVA_HOME` and Variable value: `C:\Program Files\Java\jdk-25`.
3. **Configure `PATH`:**
   * Select **Path** in *System variables*, click **Edit**, then **New**.
   * Add `%JAVA_HOME%\bin` and click **OK**. Open a new Command Prompt.
4. **Verification:**
   * Run `java -version` (Expected output: `java version "25.0.4.1"`).
   * Run `javac -version` (Expected output: `javac 25.0.4.1`).
   * Run `where java` and `where javac` to verify the execution paths.
   * Run `echo %JAVA_HOME%` to verify the environment path variable.

### 7.2 Detailed Ubuntu/Linux Setup & Verification

1. **Install OpenJDK:**
   * Update packages and install OpenJDK 25:
     ```bash
     sudo apt update
     sudo apt install openjdk-25-jdk
     ```
2. **Determine Path:**
   * Find the path: `readlink -f $(which java)` (e.g. `/usr/lib/jvm/java-25-openjdk-amd64/bin/java`).
3. **Set `JAVA_HOME`:**
   * Open `~/.bashrc` (e.g. using `nano ~/.bashrc`) and append:
     ```bash
     export JAVA_HOME=/usr/lib/jvm/java-25-openjdk-amd64
     export PATH=$JAVA_HOME/bin:$PATH
     ```
   * Reload configuration: `source ~/.bashrc`. Verify with `echo $JAVA_HOME`.
4. **Manage Multiple Versions:**
   * Run `update-java-alternatives --list` to check available versions.
   * Run `sudo update-alternatives --config java` (and `javac`) to choose default versions interactively.

### 7.3 Troubleshooting Guidelines

> [!WARNING]
> **Problem 1: 'java' is not recognized**
>
> * *Cause:* Java is not installed, or not included in PATH, or the terminal window was opened before path updates.
> * *Solution:* Run `echo %JAVA_HOME%` or `where java` to check configuration, and add `%JAVA_HOME%\bin` to the Path variables.

> [!IMPORTANT]
> **Problem 2: 'javac' is not recognized**
>
> * *Cause:* You may have installed JRE only, or compilation bin routes are missing.
> * *Solution:* Install the full JDK and ensure `%JAVA_HOME%\bin` is added to the Path variables.

> [!NOTE]
> **Problem 3: Wrong Java Version**
>
> * *Solution:* Use `sudo update-alternatives --config java` on Linux, or check `where java` and rearrange Path items on Windows.

### 7.4 Useful Commands Reference

| Purpose                            | Windows              | Linux               |
| ---------------------------------- | -------------------- | ------------------- |
| **Check Java version**       | `java -version`    | `java -version`   |
| **Check compiler version**   | `javac -version`   | `javac -version`  |
| **Find Java executable**     | `where java`       | `which java`      |
| **Find compiler executable** | `where javac`      | `which javac`     |
| **Check `JAVA_HOME`**      | `echo %JAVA_HOME%` | `echo $JAVA_HOME` |
| **Compile Java file**        | `javac File.java`  | `javac File.java` |
| **Run Java class**           | `java ClassName`   | `java ClassName`  |

---

# 8. Recommendation / Conclusion

Java installation is complete when `java -version` and `javac -version` execute successfully on the terminal. For standard environments, deploying **OpenJDK 25 (LTS)** (specifically version **25.0.4.1**) using package managers (APT on Ubuntu) or standard setup binaries (on Windows) is recommended. Setting the system environment variable `JAVA_HOME` and updating `PATH` completes the configuration, leaving the system fully ready for Java application development.

---

# 9. Contact Information

| **Name** | **Email**                                                                      |
| -------------- | ------------------------------------------------------------------------------------ |
| Amrendra       | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

# 10. References

| **Topic**                                                                                              | **Description**                                       |
| ------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------- |
| [Oracle Java Technologies](https://www.oracle.com/in/java/technologies/?utm_source=chatgpt.com)               | Home page for Java developer tools.                         |
| [Oracle JDK 25 Installation Guide](https://docs.oracle.com/en/java/javase/25/install/?utm_source=chatgpt.com) | Step-by-step setup guides for JDK 25.                       |
| [Oracle JDK 25 Documentation](https://docs.oracle.com/en/java/javase/25/?utm_source=chatgpt.com)              | Official JDK 25 releases, specs, and modules documentation. |
