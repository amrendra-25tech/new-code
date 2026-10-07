# SaaS vs On-Premise And Setup VCS Documentation
<p>
  <img src="https://img.shields.io/badge/SaaS%20VS%20On--Premise-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/VCS-Documentation-blue?style=for-the-badge" />
</p>

# Author Table

| **Author**    | **Created On** | **Version** | **Last Updated By** | **Last Edited On** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ------------- | -------------- | ----------- | ------------------- | ------------------ | --------------- | --------------- | --------------- |
| Maqbool Alam | 23-09-2026   | 1.0   | Maqbool Alam      | 23-09-2026    | Rajnish/Asma   | Pritam/Komal   | Abhishek/Manish Nautiyal  |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [VCS Setup](#2-vcs-setup)
3. [SaaS vs On-Premise](#3-saas-vs-on-premise)
4. [VCS Workflow](#4-vcs-workflow)
5. [Recommendation / Conclusion](#5-recommendation--conclusion)
6. [Proof of Concept (POC)](#6-proof-of-concept-poc)
7. [Contact Information](#7-contact-information)
8. [References](#8-references)

---

# 1. Introduction

A Version Control System (VCS) tracks changes to source code, keeps project history, and lets developers work together safely.

As recommended in the previous sprint, **GitHub** is used as the VCS. This document explains the setup, compares SaaS with On-Premise, and shows the workflow and POC.

---

# 2. VCS Setup

GitHub is used as a **SaaS** solution. All repositories, members, and teams are managed under one GitHub **Organization**.

**Setup steps**

1. Create an Organization
2. Create a repository in the Organization
3. Add members to the Organization
4. Create teams
5. Add the team to the repository
6. Select the team role (Read, Triage, Write, Maintain, or Admin)

Access is given to teams instead of individual users, which makes it easier to manage.

Screenshots for each step are in the [POC](#6-proof-of-concept-poc) section.

**[Detailed VCS Documentation](https://github.com/SnaatakKubeClan/Sprint-1/blob/SCRUM-85-PALAK/Documentation/VCS_Design/Features_Of_VCS/DOC/README.md)**

---

# 3. SaaS vs On-Premise

**SaaS** = hosted by GitHub (github.com).
**On-Premise** = self-hosted by the organization (GitHub Enterprise Server).

| **Criteria**     | **GitHub SaaS**                   | **Local / On-Premise**              |
| ---------------- | --------------------------------- | ----------------------------------- |
| Hosting          | Managed by GitHub                 | Managed by organization             |
| Infrastructure   | Not required                      | Servers required                    |
| Maintenance & Updates | Done by provider             | Done by organization                |
| Accessibility    | Internet-based access             | Usually internal network / VPN      |
| Backup           | Provider-managed                  | Organization responsibility         |
| Cost             | Subscription, no hardware cost    | Hardware plus operations cost       |
| Setup            | Quick and easy                    | More complex                        |
| Control          | Less infrastructure control       | More infrastructure control         |

**In short:** SaaS is easier and faster to adopt. On-Premise gives more control but needs more effort.

---

# 4. VCS Workflow

><img width="802" height="412" alt="image" src="https://github.com/user-attachments/assets/9a46bdc1-7460-434c-aec5-5156d531f16c" />

Every change is reviewed before it reaches the main branch, so the main branch stays stable.

---

# 5. Recommendation / Conclusion

**GitHub SaaS** is used for the VCS implementation because:

* No servers to set up or maintain
* Quick setup (as shown in the POC)
* Easy collaboration with built-in Pull Requests and code review
* Simple, team-based access control

If strict data-residency or compliance needs come up later, On-Premise (GitHub Enterprise Server) can be reviewed again.

---

# 6. Proof of Concept (POC)

**Create Organization**
><img width="1266" height="951" alt="image" src="https://github.com/user-attachments/assets/6dd0f0b9-917d-48c4-82e6-a65504967978" />

**Create repository in Organization**
><img width="1528" height="961" alt="image" src="https://github.com/user-attachments/assets/c79951df-14ef-4f2a-a73c-ecb10b348af5" />

**Add member to Organization**
><img width="1704" height="921" alt="image" src="https://github.com/user-attachments/assets/a0a14672-69fd-4b02-968a-f33afbc27346" />

**Add Teams**
><img width="1855" height="513" alt="image" src="https://github.com/user-attachments/assets/43efc415-34e3-4659-a4ed-bae335eaf762" />

**Add Team into repository**
><img width="1855" height="918" alt="image" src="https://github.com/user-attachments/assets/744c7419-6cb1-4e4b-ad2b-5bd84a8d9b69" />

**Select Team Role**
><img width="1855" height="684" alt="image" src="https://github.com/user-attachments/assets/7abf877d-9502-4948-b610-8059048d8690" />

---

# 7. Contact Information

| **Name** | **Email**                 |
| -------- | ------------------------- |
| Maqbool Alam  | [<maqbul.alam.snaatak@mygurukulam.co>](mailto:<maqbul.alam.snaatak@mygurukulam.co>) |

---

# 8. References

| **Topic**                                                                                                                                            | **Description**                                          |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| [GitHub Documentation](https://docs.github.com/)                                                                                                     | Official GitHub documentation.                           |
| [Detailed VCS Documentation](https://github.com/SnaatakKubeClan/Sprint-1/blob/SCRUM-85-PALAK/Documentation/VCS_Design/Features_Of_VCS/DOC/README.md) | Detailed VCS features |
