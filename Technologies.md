# Technologies – AWS Zero Trust PoC

This project uses AWS-native services and Terraform to demonstrate Zero Trust patterns.

---

## Amazon API Gateway

**What it is**  
Fully managed service for creating and managing HTTP/REST APIs at scale.

**How it is used**  
- Terminates public API requests over HTTPS.  
- Integrates with Amazon Cognito to require authenticated calls.  
- Forwards traffic to the application tier behind WAF.

**Why it matters for Zero Trust**  
- Provides a controlled, audited entry point to the environment.  
- Enforces authentication and throttling before requests reach application servers.

---

## Amazon Cognito

**What it is**  
Managed identity service for user sign-up, sign-in, and token issuance, supporting OIDC and OAuth2 flows.

**How it is used**  
- Authenticates users and issues JWT tokens.  
- API Gateway authorizers validate these tokens before routing requests.

**Why it matters for Zero Trust**  
- Shifts trust decisions to **identity** instead of network location.  
- Enables fine-grained control over which users/clients can call which APIs.

---

## AWS WAF

**What it is**  
Web Application Firewall that inspects HTTP(S) traffic and applies customizable rules.

**How it is used**  
- Sits in front of the API Gateway endpoint.  
- Applies managed rule sets to block common attack patterns (SQLi, XSS, bad bots).  
- Provides visibility into blocked and allowed requests.

**Why it matters for Zero Trust**  
- Acts as a centralized policy enforcement point.  
- Reduces attack surface by validating and filtering traffic before it reaches the application.

---

## Amazon EC2 (Private Subnets)

**What it is**  
Elastic compute service for running virtual machines in a VPC.

**How it is used**  
- Hosts the demo application on instances placed in **private subnets**.  
- Instances do not have public IPs; access flows only from API Gateway/WAF.

**Why it matters for Zero Trust**  
- Workloads are not directly reachable from the internet.  
- Traffic paths are explicit and enforced via security groups and routing.

---

## Amazon VPC

**What it is**  
Virtual network environment for deploying AWS resources with control over subnets, routing, and security.

**How it is used**  
- Provides public subnets for edge components (if required) and private subnets for EC2 instances.  
- Security groups and route tables define allowed communication paths.

**Why it matters for Zero Trust**  
- Enables segmentation and minimizes implicit trust within the network.  
- Supports the principle of “only necessary pathways are allowed.”

---

## AWS CloudTrail

**What it is**  
Service that records account-level API activity and configuration changes.

**How it is used**  
- Captures create/update/delete operations for APIs, WAF rules, IAM, and EC2/networking changes.  
- Provides evidence for audit and helps investigate incidents.

**Why it matters for Zero Trust**  
- Supports continuous verification and accountability.  
- Ensures there is an auditable record of who changed what and when.

---

## Terraform

**What it is**  
Infrastructure as Code (IaC) tool that declaratively manages cloud resources.

**How it is used**  
- Provisions the VPC, subnets, route tables, internet gateway, and EC2 instances.  
- Produces a repeatable, version-controlled deployment for the PoC.

**Why it matters for Zero Trust**  
- Reduces risk of misconfiguration by codifying infrastructure.  
- Allows peer review and change history, improving governance and compliance.
