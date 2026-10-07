# VCS Setup
<p align="center"><img width="204" height="202" alt="GitFlow" src="https://git-scm.com/images/logos/downloads/Git-Icon-1788C.png" /></p>

---

## Document Information

| Author   | Created On | Version | L0 Reviewer           | L1 Reviewer         | L2 Reviewer     |
| :------- | :--------- | :------ | :-------------------- | :------------------ | :-------------- |
| Amrendra | 27-09-2026 | 1.0     | Shubham Rathi / Sunny | Shreya J / Nikita   | Piyush Upadhyay |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [SaaS vs On-Premise Comparison](#2-saas-vs-on-premise-comparison)
3. [VCS Setup Prerequisites](#3-vcs-setup-prerequisites)
4. [VCS Setup Steps](#4-vcs-setup-steps)
5. [Proof of Concept (POC)](#5-proof-of-concept-poc)
6. [Best Practices](#6-best-practices)
7. [Conclusion](#7-conclusion)
8. [Contact Information](#8-contact-information)
9. [References](#9-references)

---

# 1. Introduction

This document provides a guide for setting up and configuring the Version Control System (VCS) for our project.  
It aims to help team members understand our GitHub setup and manage repository access easily and securely.

---

# 2. SaaS vs On-Premise Comparison

* **SaaS (GitHub.com):** Hosted and managed by GitHub on the cloud.
* **On-Premise (GitHub Enterprise Server):** Hosted and managed by our own team on our own servers.

| Feature | GitHub SaaS | Local / On-Premise | Recommendation |
| :--- | :--- | :--- | :--- |
| **Hosting** | Managed by GitHub | Managed by our company | **SaaS** |
| **Server Setup** | No servers needed | Physical or cloud servers needed | **SaaS** |
| **Maintenance** | Done automatically by GitHub | Done manually by our DevOps team | **SaaS** |
| **Access** | Accessible over the internet | Usually needs VPN or office network | **SaaS** |
| **Backups** | Taken care of by GitHub | Our team must schedule backups | **SaaS** |
| **Setup Time** | Ready in less than 15 minutes | Takes 1 to 3 days to install | **SaaS** |
| **Cost (< 100 Devs)** | Lower (simple monthly subscription) | Higher (server cost + admin effort) | **SaaS** |
| **Control** | Standard cloud settings | Full control over servers | **On-Premise** |

**Summary:** GitHub SaaS is much faster to set up and needs zero maintenance, making it the best choice for our team.

---

# 3. VCS Setup Prerequisites

Before starting the setup, ensure the following requirements are met:

| Requirement | Purpose |
| :--- | :--- |
| **GitHub Account** | Required to create and manage the Organization and repositories. |
| **Organization Plan** | Free or Team plan on GitHub SaaS. |
| **Team Member Email List** | Corporate email addresses (`@mygurukulam.co`) to invite users to the Organization. |
| **Defined Team Structure** | List of functional groups (e.g., Developers, QA, DevOps) for role mapping. |

---

# 4. VCS Setup Steps

We manage all our code and team members under one central **GitHub Organization**.

| Step | Action | How to do it | Why it is needed |
| :--- | :--- | :--- | :--- |
| **1. Create Organization** | Create a new GitHub Organization | Click profile icon $\rightarrow$ *Your organizations* $\rightarrow$ *New organization* | Creates a shared space for all company projects and teams. |
| **2. Create Repository** | Create a project repository | Inside Organization $\rightarrow$ Click *Repositories* $\rightarrow$ *New repository* | Stores our project source code in one central place. |
| **3. Add Members** | Invite team members | Go to *People* $\rightarrow$ Click *Invite member* $\rightarrow$ Enter email | Gives team members access to the Organization. |
| **4. Create Teams** | Group members into teams | Go to *Teams* $\rightarrow$ Click *New team* | Lets us give permissions to a whole group instead of one person at a time. |
| **5. Add Team to Repository** | Connect the team to the project | Repo *Settings* $\rightarrow$ *Collaborators and teams* $\rightarrow$ *Add teams* | Gives the team access to that specific repository. |
| **6. Select Team Role** | Choose access permission | Select role: `Read`, `Triage`, `Write`, `Maintain`, or `Admin` | Makes sure members only have the permissions they need (e.g., `Write` for Developers). |

> **Tip:** Giving permissions to **Teams** instead of individual people makes managing access much easier.

---

# 5. Proof of Concept (POC)

Here are the screenshots showing each step of the setup:

### Step 1: Create Organization
Create the organization to hold all projects and teams.
<img width="1916" height="973" alt="1" src="https://github.com/user-attachments/assets/7df18dc7-50da-411a-a341-ef696e9f2aa6" />


---

### Step 2: Create Repository in Organization
Create the project repository inside the organization.
<img width="1908" height="977" alt="image" src="https://github.com/user-attachments/assets/54c51050-38e1-46fb-8390-30c79c93388c" />


---

### Step 3: Add Member to Organization
Invite teammates using their email address.
<img width="1898" height="987" alt="image" src="https://github.com/user-attachments/assets/2dffac95-d602-42a8-ac63-53332718862d" />


---

### Step 4: Add Teams
Create teams like Developers, QA, and DevOps.
<img width="1881" height="922" alt="image" src="https://github.com/user-attachments/assets/72c1cf60-4011-4c83-a0eb-ff9dca2c6a53" />

---

### Step 5: Add Team into Repository
Link the team to the project repository.
<img width="1892" height="916" alt="image" src="https://github.com/user-attachments/assets/0be01137-cd69-49ae-aace-1ae9e7d73225" />


---

### Step 6: Select Team Role
Assign the right permission level (`Write`, `Maintain`, etc.) to the team.
<img width="1920" height="933" alt="image" src="https://github.com/user-attachments/assets/ed55dacd-3278-49da-a4d2-cf7c67b3c5fb" />


---

# 6. Best Practices

* **Use Teams for Access:** Always give permissions to Teams, never to individual users.
* **Protect the Main Branch:** Don't allow direct pushes to `main`. Require code reviews first.
* **Enable Two-Factor Authentication (2FA):** Make 2FA mandatory for all organization members.
* **Follow Least Privilege:** Give developers `Write` access and keep `Admin` access only for team leads.
* **Keep Secrets Safe:** Never commit passwords, API keys, or private tokens to the repository.

---

# 7. Conclusion

We selected **GitHub SaaS** because it is quick to set up, requires no server maintenance, and makes collaboration simple. The setup was tested successfully: the Organization, Repository, Teams, and Roles are all configured and ready for the team to start development.

---

# 8. Contact Information

| Name | Email Address |
| :--- | :--- |
| **Amrendra** | [amrendra.yadav.snaatak@mygurukulam.co](mailto:amrendra.yadav.snaatak@mygurukulam.co) |

---

# 9. References

| Resource | Description / Link |
| :--- | :--- |
| **GitHub Documentation** | [https://docs.github.com/](https://docs.github.com/) |
| **GitHub Organizations & Teams** | [https://docs.github.com/en/organizations](https://docs.github.com/en/organizations) |
| **Detailed VCS Documentation** | [Detailed VCS Features Link](https://github.com/SnaatakKubeClan/Sprint-1/blob/SCRUM-85-PALAK/Documentation/VCS_Design/Features_Of_VCS/DOC/README.md) |
