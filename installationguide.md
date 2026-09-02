# Java  Installation Guide Documentation
<p align="center">
<img width="200" height="150" alt="java-logo-png_seeklogo-158094" src="https://github.com/user-attachments/assets/414ae687-38e1-4b99-931a-73de840c9d70" />

</p>

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
   - [7.1 Detailed Windows Setup & Verification](#71-detailed-windows-setup--verification)
   - [7.2 Detailed Ubuntu/Linux Setup & Verification](#72-detailed-ubuntulinux-setup--verification)
   - [7.3 Troubleshooting Guidelines](#73-troubleshooting-guidelines)
   - [7.4 Useful Commands Reference](#74-useful-commands-reference)
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

<details>
<summary>Click to Expand Java Installation Guide Workflow Diagram</summary>

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

| **Best Practice** | **Description** |
| ----------------- | --------------- |
| **Use LTS Versions** | Choose LTS releases (like JDK 25) for stability and extended support. |
| **Set JAVA_HOME** | Configure `JAVA_HOME` permanently in system variables or `~/.bashrc`. |
| **Update System PATH** | Add `%JAVA_HOME%\bin` or `$JAVA_HOME/bin` to `PATH` for global command access. |
| **Use Package Managers** | Use `apt` on Linux for automated dependencies and security patches. |
| **Manage Multiple Versions** | Use `update-alternatives` (Linux) or path priority (Windows) to switch JDKs. |
| **Verify Full JDK** | Check both `java -version` and `javac -version` to confirm complete JDK setup. |

### 7.1 Detailed Windows Setup & Verification

| **Step** | **Task** | **Instructions** | **Commands** |
| :---: | :--- | :--- | :--- |
| **1** | **Download & Install** | Download the Windows x64 Installer (.exe) from Oracle and install using default path (`C:\Program Files\Java\`). | — |
| **2** | **Set `JAVA_HOME`** | Open System Properties > Advanced > Environment Variables. Add `JAVA_HOME` under System variables. | `sysdm.cpl`<br>Name: `JAVA_HOME`<br>Value: `C:\Program Files\Java\jdk-25` |
| **3** | **Update `PATH`** | Edit `Path` under System variables and append the JDK `bin` folder. | `%JAVA_HOME%\bin` |
| **4** | **Verification** | Open a new Command Prompt and verify runtime, compiler, paths, and environment variable. | `java -version`<br>`javac -version`<br>`where java`<br>`where javac`<br>`echo %JAVA_HOME%` |

### 7.2 Detailed Ubuntu/Linux Setup & Verification

| **Step** | **Task** | **Instructions** | **Commands** |
| :---: | :--- | :--- | :--- |
| **1** | **Install OpenJDK** | Update package cache and install OpenJDK 25. | `sudo apt update`<br>`sudo apt install -y openjdk-25-jdk` |
| **2** | **Find Install Path** | Locate the absolute path of the Java binary. | `readlink -f $(which java)` |
| **3** | **Set `JAVA_HOME`** | Append environment variables to `~/.bashrc` and reload the shell profile. | `export JAVA_HOME=/usr/lib/jvm/java-25-openjdk-amd64`<br>`export PATH=$JAVA_HOME/bin:$PATH`<br>`source ~/.bashrc`<br>`echo $JAVA_HOME` |
| **4** | **Manage Versions** | List installed versions and select the active runtime or compiler. | `update-java-alternatives --list`<br>`sudo update-alternatives --config java`<br>`sudo update-alternatives --config javac` |

### 7.3 Troubleshooting Guidelines

| **Problem** | **Possible Cause** | **Solution** |
| ----------- | ------------------ | ------------ |
| **'java' is not recognized** | Java is not installed, not included in PATH, or the terminal was opened before path updates. | Check `echo %JAVA_HOME%` or `where java`. Add `%JAVA_HOME%\bin` to the Path variables and restart the terminal. |
| **'javac' is not recognized** | You may have installed JRE only, or compilation bin routes are missing. | Install the full JDK and ensure `%JAVA_HOME%\bin` (Windows) or `$JAVA_HOME/bin` (Linux) is added to the Path variables. |
| **Wrong Java Version** | Multiple Java versions are present and an unintended path takes precedence. | **Windows:** Run `where java` and adjust path priorities in `Path`.<br>**Linux:** Use `sudo update-alternatives --config java` (and `javac`) to choose the active version. |

### 7.4 Useful Commands Reference

| Purpose | Windows | Linux |
| :--- | :--- | :--- |
| **Check version** | `java -version` | `java -version` |
| **Check compiler** | `javac -version` | `javac -version` |
| **Find java** | `where java` | `which java` |
| **Find javac** | `where javac` | `which javac` |
| **Check JAVA_HOME** | `echo %JAVA_HOME%` | `echo $JAVA_HOME` |
| **Compile** | `javac File.java` | `javac File.java` |
| **Run** | `java ClassName` | `java ClassName` |

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
