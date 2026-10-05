# AWS Cost Allocation Tags – Implementation

<div align="center">
<img width="100" alt="image" src="https://github.com/user-attachments/assets/5e055238-0451-4994-a860-e12be7e6b122" />
</div>

<br/>

## Contact Information

| **Author** | **Created On** | **Version** | **L0 Reviewer** | **L1 Reviewer** | **L2 Reviewer** |
| ---------------- | -------------------- | ----------------- | --------------------- | --------------------- | --------------------- |
| Amrendra         | 28-09-2026           | v1.0              | Shubham Rathi / Sunny | Shreya J / Nikita     | Piyush Upadhyay       |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
3. [Pre-Setup Cost Optimization](#3-pre-setup-cost-optimization)
   - [3.1 Right Sizing Assessment](#31-right-sizing-assessment)
   - [3.2 Spot Instances Exploration](#32-spot-instances-exploration)
4. [AWS Cost Allocation Tags Setup (AWS Console)](#4-aws-cost-allocation-tags-setup-aws-console)
   - [4.1 Standard Tag Strategy](#41-standard-tag-strategy)
   - [4.2 Search and Apply Tags Using Tag Editor](#42-search-and-apply-tags-using-tag-editor)
   - [4.3 Verify Tagged Resources in Resource Explorer](#43-verify-tagged-resources-in-resource-explorer)
   - [4.4 Activate Cost Allocation Tags in Billing Console](#44-activate-cost-allocation-tags-in-billing-console)
   - [4.5 View and Filter Costs in Cost Explorer](#45-view-and-filter-costs-in-cost-explorer)
5. [Conclusion](#5-conclusion)
6. [Author Information](#6-author-information)
7. [References](#7-references)

---

# 1. Introduction

This document provides a simple, console-based guide to implement **AWS Cost Allocation Tags**.
All steps are performed directly using the **AWS Management Console**.
It covers workload right-sizing, spot instance exploration, tagging using AWS Tag Editor, verification in AWS Resource Explorer, and activating tags in the Billing Console.




# 2. Prerequisites

The table below lists all console requirements needed before starting.

| **Requirement**             | **Purpose**                                                 | **Status** |
| --------------------------------- | ----------------------------------------------------------------- | ---------------- |
| **AWS Management Console**  | Access to AWS Web UI.                                             | Required         |
| **Console IAM Permissions** | Permissions for EC2, Resource Groups, Billing, and Cost Explorer. | Required         |
| **AWS Region**              | Deployed in Asia Pacific Mumbai (`ap-south-1`).                 | Configured       |
| **AWS Tag Editor**          | Used to search and manage resource tags in bulk.                  | Available        |
| **AWS Resource Explorer**   | Used to search and verify tagged resources.                       | Enabled          |

---

# 3. Pre-Setup Cost Optimization

We must optimize compute capacity in the AWS Console before applying permanent cost tags.

---

## 3.1 Right Sizing Assessment

Right-sizing ensures instances match workload traffic and prevents paying for idle compute.

| **Step** | **Console Action**       | **Details**                                                                 |
| -------------- | ------------------------------ | --------------------------------------------------------------------------------- |
| **1**    | **Open EC2 Console**     | Navigate to**EC2** $\rightarrow$ **Instances** in `ap-south-1`.   |
| **2**    | **Review Utilization**   | Check CPU and Memory metrics in the**Monitoring** tab.                      |
| **3**    | **Select Instance Size** | Choose a right-sized instance type (e.g.,`t3.micro` for lightweight workloads). |
| **4**    | **Check Storage Tier**   | Ensure root volumes use`gp3` instead of older `gp2` disks.                    |
| **5**    | **Launch Optimized EC2** | Confirm running instance (e.g.,`i-0628df79db03fad30` as `t3.micro`).          |



<img width="1857" height="883" alt="allocation tags (3)" src="https://github.com/user-attachments/assets/6deecdd3-a3db-408d-9e44-e3603ade846b" />


---

## 3.2 Spot Instances Exploration

Spot instances use spare AWS compute at discounts up to 90%.

### Workload Suitability:

| **Workload Name**         | **Use Spot?** | **Reason**                             | **Console Setup**                 |
| ------------------------------- | ------------------- | -------------------------------------------- | --------------------------------------- |
| **CI/CD Build Nodes**     | **Yes**       | Stateless tasks that can restart.            | Launch Template with Spot checked.      |
| **Microservice APIs**     | **Yes**       | Runs behind ALB with multiple instances.     | Auto Scaling with mixed Spot instances. |
| **Database (PostgreSQL)** | **No**        | Requires steady uptime and persistent state. | Use On-Demand instance.                 |

### Steps to Configure Spot via Console:

| **Step** | **Console Action**          | **Details**                                                                                     |
| -------------- | --------------------------------- | ----------------------------------------------------------------------------------------------------- |
| **1**    | **Open Launch Templates**   | Go to EC2$\rightarrow$ **Launch Templates** $\rightarrow$ **Create launch template**. |
| **2**    | **Enable Spot**             | Expand**Advanced details** and check **Request Spot Instances**.                          |
| **3**    | **Set Allocation Strategy** | Select**Capacity-optimized** allocation strategy.                                               |
| **4**    | **Add Lifecycle Tag**       | Add tag`Lifecycle = spot` directly in the template.                                                 |

---

# 4. AWS Cost Allocation Tags Setup (AWS Console)

All tagging steps are performed using the AWS Management Console.

---

## 4.1 Standard Tag Strategy

Use uniform tag keys and values across resources.

| **Tag Key** | **Value Example**         | **Mandatory** | **Purpose**                |
| ----------------- | ------------------------------- | ------------------- | -------------------------------- |
| `Environment`   | `development`, `production` | Yes                 | Shows environment tier.          |
| `Project`       | `ot-microservices`            | Yes                 | Tracks spending for the project. |
| `Owner`         | `amrendra`                    | Yes                 | Identifies responsible engineer. |
| `CostCenter`    | `cc-engineering-101`          | Yes                 | Associates costs with budget.    |
| `Lifecycle`     | `spot`, `on-demand`         | Yes                 | Tracks Spot vs On-Demand costs.  |

---

## 4.2 Search and Apply Tags Using Tag Editor

Use **AWS Tag Editor** under Resource Groups to find and tag resources in bulk.

| **Step** | **Console Action**        | **Details**                                                                                             |
| -------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **1**    | **Open Tag Editor**       | In AWS Console, search for**Resource Groups & Tag Editor** $\rightarrow$ select **Tag Editor**. |
| **2**    | **Set Search Scope**      | Select Regions:`ap-south-1`. Select Resource types: `AWS::EC2::Instance`.                                 |
| **3**    | **Search Resources**      | Click**Search resources** to list instances (found `i-0628df79db03fad30`).                            |
| **4**    | **Select Instance**       | Select checkbox next to instance`i-0628df79db03fad30`.                                                      |
| **5**    | **Click Manage Tags**     | Click**Manage tags of selected resources**.                                                             |
| **6**    | **Enter Tag Key & Value** | Enter tag key (e.g.,`key` or standard keys) and value (e.g., `instance`).                                 |
| **7**    | **Apply Changes**         | Click**Review and apply tag changes** $\rightarrow$ click **Apply changes to all selected**.    |

<img width="1857" height="883" alt="allocation tags (3)" src="https://github.com/user-attachments/assets/a27ad49b-4235-4074-b248-ba73575ca32f" />

---

## 4.3 Verify Tagged Resources in Resource Explorer

Use **AWS Resource Explorer** to verify that the resource is indexed with tags.

| **Step** | **Console Action**         | **Details**                                                                              |
| -------------- | -------------------------------- | ---------------------------------------------------------------------------------------------- |
| **1**    | **Open Resource Explorer** | In AWS Console, search and open**AWS Resource Explorer**.                                |
| **2**    | **Query by Tag**           | In the search bar, enter query:`Tag = key=instance` and Region = `ap-south-1`.             |
| **3**    | **Confirm Search Result**  | Verify instance`i-0628df79db03fad30` appears in results with tag count.                      |
| **4**    | **Check Overview**         | Open instance details to confirm**Running** state, `t3.micro` size, and attached tags. |

<img width="1857" height="883" alt="allocation tags (3)" src="https://github.com/user-attachments/assets/238e4f5e-2289-4a7a-b843-7b97a678f434" />


---

## 4.4 Activate Cost Allocation Tags in Billing Console

Tags must be activated in the Billing Console to appear in cost reports.

| **Step** | **Console Action**             | **Details**                                          |
| -------------- | ------------------------------------ | ---------------------------------------------------------- |
| **1**    | **Open Billing Console**       | Navigate to**AWS Billing and Cost Management**.      |
| **2**    | **Go to Cost Allocation Tags** | Click**Cost Allocation Tags** in the left menu.      |
| **3**    | **Open User-Defined Tab**      | Select the**User-defined cost allocation tags** tab. |
| **4**    | **Select Tags**                | Select your created tag keys from the list.                |
| **5**    | **Click Activate**             | Click**Activate** button and confirm.                |
| **6**    | **Verify Active Badge**        | Confirm the status shows green**Active** badge.      |

---

## 4.5 View and Filter Costs in Cost Explorer

View tagged expenditure in AWS Cost Explorer.

| **Step** | **Console Action**     | **Details**                                                             |
| -------------- | ---------------------------- | ----------------------------------------------------------------------------- |
| **1**    | **Open Cost Explorer** | In Billing Console, select**Cost Explorer**.                            |
| **2**    | **Select Date Range**  | Choose**Current Month** or **Last 30 Days**.                      |
| **3**    | **Group by Tag**       | Under**Group by**, select **Tag** and choose your active tag key. |
| **4**    | **Filter Costs**       | Apply filters to view costs by project or environment.                        |
| **5**    | **Save Report**        | Click**Save report** for recurring sprint review.                       |

---

# 5. Conclusion

AWS Cost Allocation Tags were successfully configured using the AWS Console.
Resources were right-sized to `t3.micro` and tagged using Tag Editor and Resource Explorer.
Activating tags in Billing enables clear spending tracking in AWS Cost Explorer.

---

# 6. Author Information

| **Name** | **Email ID**                    |
| -------------- | ------------------------------------- |
| Amrendra       | amrendra.yadav.snaatak@mygurukulam.co |

---

# 7. References

| **Topic**                    | **Reference Link**                                                                                           |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| **AWS Cost Allocation Tags** | [AWS Cost Allocation Tags Guide](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) |
| **AWS Tag Editor**           | [AWS Tag Editor User Guide](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html)                   |
| **AWS Cost Explorer**        | [AWS Cost Explorer Documentation](https://docs.aws.amazon.com/cost-management/latest/userguide/ce-what-is.html)     |
