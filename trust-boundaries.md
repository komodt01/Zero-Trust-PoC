# Trust Boundary Analysis

## Purpose

This document identifies the primary trust boundaries in the Zero Trust architecture explored by this project.

A trust boundary is a point where identity, authority, network reachability, data access, or administrative privilege changes and where access should be explicitly evaluated.

A trust boundary is not necessarily a firewall, VLAN, subnet, or cloud boundary. Network segmentation can enforce a boundary, but Zero Trust requires the architecture to evaluate who or what is requesting access, which resource is being requested, what action is being performed, and whether that access should be permitted.

This project contains two related scopes:

1. **AWS PoC** — selected Zero Trust concepts demonstrated using AWS services.
2. **Regional Bank Architecture Case Study** — a broader hypothetical hybrid enterprise architecture that was not implemented as a production banking environment.

The boundaries below distinguish between those scopes.

---

# Part I — Boundaries Demonstrated by the AWS PoC

## Boundary 1 — Internet to Public Application Entry Point

**Trust transition:** Internet user → Public application interface

The public internet is an untrusted environment.

The PoC uses a controlled application entry point rather than directly exposing the underlying EC2 workload.

API Gateway provides the public API interface, while AWS WAF provides request inspection and filtering.

This creates a boundary between externally originated traffic and the protected application environment.

Security objectives at this boundary include:

* Expose only the required application interface.
* Inspect incoming requests.
* Reduce exposure to common web attacks.
* Avoid direct internet exposure of the underlying compute workload.
* Generate evidence of suspicious or blocked activity.

Reaching the public interface does not establish trust in the requester or authorize access to protected application functions.

---

## Boundary 2 — Unauthenticated Request to Authenticated Identity

**Trust transition:** Unverified requester → Authenticated user identity

Amazon Cognito is used in the PoC to demonstrate authentication and token-based access.

This boundary establishes an identity before protected application functions are reached.

Successful authentication means that an identity has been established. It does not mean that the identity should receive unrestricted access to the application or downstream resources.

The broader architecture would require authorization decisions based on the requested resource, permitted action, business role, risk, and other applicable context.

The PoC therefore demonstrates authentication as one component of Zero Trust rather than treating authentication as complete authorization.

---

## Boundary 3 — Public Application Layer to Private Workload

**Trust transition:** Publicly reachable service layer → Private EC2 application infrastructure

The underlying EC2 workload is placed in private infrastructure without direct public internet exposure.

Traffic reaches the application through defined entry points rather than directly reaching the compute resource.

This boundary reduces unnecessary network reachability and helps contain exposure if an internet-facing component is attacked.

The architectural principle is:

**Public service availability does not require public exposure of every component supporting that service.**

Network location alone does not establish trust. Communication should still be limited to required paths and services.

---

## Boundary 4 — Application Workload to Downstream Resources

**Trust transition:** Application workload → Required supporting service or resource

An application should not receive unrestricted access to other systems simply because it is an approved workload.

Application and service identities require defined permissions, and network connectivity should be limited to required communication paths.

The AWS PoC demonstrates portions of this principle through private infrastructure, IAM, and network security controls.

The broader banking architecture would require more detailed application-to-application authorization and segmentation than the PoC implements.

A compromised application should not automatically provide unrestricted access to customer information, payment systems, administrative functions, or other sensitive resources.

---

## Boundary 5 — Workload Network to Management Access

**Trust transition:** Normal application operation → Administrative access

Administrative access represents a different trust level from ordinary application traffic.

The PoC does not rely on direct internet-facing SSH or RDP access to private EC2 resources.

The Security Requirements identify AWS Systems Manager Session Manager as a preferred production approach for controlled administrative access.

The broader architecture would require stronger privileged-access controls, monitoring, approval, and emergency-access procedures.

Administrative access should therefore be treated as a separate privileged path rather than another normal application connection.

---

## Boundary 6 — Operational Activity to Security Evidence

**Trust transition:** System or administrative activity → Security logging and audit evidence

Security-relevant activity must cross into a monitoring and evidence domain where it can be used for investigation and audit.

The PoC uses CloudTrail and supporting logging to demonstrate portions of this requirement.

Relevant activity can include:

* Authentication activity
* Administrative actions
* Configuration changes
* API activity
* WAF activity
* Application events
* Security-control changes

The existence of logs does not by itself provide complete monitoring.

A production implementation would require defined retention, access protection, centralized correlation, alerting, ownership, and investigation processes.

---

# Part II — Regional Bank Architecture Trust Boundaries

The following boundaries belong to the broader hypothetical regional-bank architecture. They should not be interpreted as fully implemented by the AWS PoC.

## Boundary 7 — Customer Identity to Banking Services

**Trust transition:** Customer → Customer banking service

Customers require access to externally available banking services without gaining access to internal banking systems.

The architecture must distinguish between:

* Establishing customer identity
* Accessing an account
* Viewing information
* Initiating transactions
* Performing higher-risk actions

Higher-risk actions may require stronger verification or additional authorization.

A customer session should never establish general trust in the internal banking environment.

---

## Boundary 8 — Workforce Identity to Internal Resources

**Trust transition:** Employee identity → Internal bank resource

Employees require different access based on their business responsibilities.

Being connected to an internal network should not itself establish authorization.

Access should be based on identity, role or function, resource sensitivity, required action, and applicable security policy.

Identity lifecycle is part of this boundary.

Access should be granted, changed, periodically reviewed, and removed as responsibilities change.

---

## Boundary 9 — Standard User to Privileged Administration

**Trust transition:** Normal user authority → Administrative or high-impact authority

Administrative, security, payment, infrastructure, and other privileged functions represent a higher trust level than ordinary user activity.

The architecture should separate normal and privileged access.

Production controls could include:

* Stronger authentication
* Privileged access management
* Just-in-time or time-limited access
* Separate administrative identities
* Approval requirements
* Session monitoring
* Enhanced logging
* Emergency-access procedures

The AWS PoC does not implement a complete enterprise privileged-access architecture.

---

## Boundary 10 — Third Party to Bank Environment

**Trust transition:** External organization or provider → Bank-controlled resource

Third parties should not receive broad trust simply because they have an established business relationship with the bank.

For every third-party connection, the architecture should determine:

* Which identity or system is connecting?
* Which bank resource is required?
* What data is required?
* Which actions are permitted?
* In which direction must communication occur?
* How is activity monitored?
* How is access revoked?

Compromise of a third party should not automatically provide broad access to the bank environment.

Third-party access should therefore be treated as its own trust boundary.

---

## Boundary 11 — Cloud Environment to On-Premises Environment

**Trust transition:** Cloud resource → Existing bank environment

Hybrid connectivity is one of the most significant boundaries in the proposed architecture.

A private or dedicated connection between cloud and on-premises environments should not create broad mutual trust.

For each hybrid connection, the architecture should identify:

* Which systems need to communicate
* Which protocols and ports are required
* Which direction communication must flow
* Which identities or workloads may use the connection
* Which data may cross the boundary
* What monitoring is required
* What happens when connectivity is unavailable

Network controls may include routing restrictions, firewalls, security policies, network zones, VLANs, subnets, and workload-level controls depending on the environment.

Identity and application authorization remain necessary even when network connectivity is private.

---

## Boundary 12 — Network Segment to Network Segment

**Trust transition:** One network security zone → Another security zone

Systems with different sensitivity, purpose, or risk should not automatically share unrestricted network reachability.

In an on-premises environment, segmentation could include:

* VLANs
* Network zones
* Firewalls
* Access-control rules
* Restricted routing

In cloud environments, equivalent controls could include:

* Virtual networks
* Private subnets
* Security groups
* Network security policies
* Routing controls
* Workload-level policy

The purpose is not segmentation for its own sake.

The purpose is to reduce unnecessary reachability and contain lateral movement.

Segmentation decisions should reflect application dependencies, data sensitivity, administrative requirements, business criticality, and operational complexity.

---

## Boundary 13 — Application to Application

**Trust transition:** Calling application or service → Receiving application or service

Applications should not implicitly trust other applications because they operate inside the same network, cloud environment, or organization.

Service-to-service communication should identify:

* The calling workload
* The receiving workload
* The permitted operation
* Required data
* Authentication requirements
* Authorization requirements
* Logging requirements

This becomes particularly important when application communication crosses cloud, on-premises, business-unit, or data-sensitivity boundaries.

---

## Boundary 14 — Application Environment to Sensitive Data

**Trust transition:** Application or service → Sensitive banking information

Application placement and data placement are separate architecture decisions.

Moving an application to the cloud does not automatically require moving its underlying data.

The bank would need to determine:

* Who owns the data
* How the data is classified
* Where the data is permitted to reside
* Which applications require access
* Which identities may access it
* Which information may cross environment boundaries
* How long information should be retained
* How access and movement are monitored

The architecture should then enforce those decisions through identity controls, authorization, segmentation, encryption, monitoring, and controlled data flows.

---

## Boundary 15 — Development and Production Environments

**Trust transition:** Development or testing environment → Production environment

Development, testing, and production should not automatically share the same level of trust.

A production banking environment would require appropriate separation of:

* Administrative access
* Application identities
* Credentials
* Data
* Deployment authority
* Network access
* Logging
* Change controls

Non-production environments should not provide an indirect path into production.

The AWS PoC does not implement a complete enterprise environment-separation model.

---

## Boundary 16 — Security Telemetry to Central Monitoring

**Trust transition:** Distributed security events → Central monitoring and investigation capability

A hybrid bank architecture produces security evidence across multiple environments.

Relevant sources could include:

* Identity systems
* Cloud platforms
* On-premises infrastructure
* Applications
* Network controls
* WAF and edge services
* Privileged-access systems
* Security tools
* Administrative platforms

A production architecture should correlate relevant events rather than require investigators to examine each source independently.

Monitoring should make it possible to establish:

**Who or what acted → What was attempted → Which resource was involved → Allowed or denied → Origin → What happened next**

Access to security evidence should itself be controlled and monitored.

---

# Part III — Cross-Boundary Security Principles

## Identity Does Not Eliminate Other Boundaries

Successful authentication does not eliminate network, application, data, or privilege boundaries.

An authenticated identity can still be compromised, over-privileged, or attempting an unauthorized action.

Authorization should therefore continue as the request moves deeper into the architecture.

---

## Network Location Does Not Establish Trust

Being connected to:

* A corporate network
* A private subnet
* A VPN
* A dedicated hybrid connection
* An internal VLAN
* A cloud VPC

does not by itself establish authorization.

Network controls reduce reachability and provide containment, but identity and authorization remain necessary.

---

## Private Connectivity Does Not Mean Broad Connectivity

A private connection between two environments should not automatically allow unrestricted communication between them.

Connectivity should be explicitly limited to required systems, services, protocols, directions, and business purposes.

---

## Segmentation Supports Containment

Segmentation should reduce the amount of the environment reachable after a compromise.

This applies to:

* Network segments
* Applications
* Cloud environments
* Administrative functions
* Development and production
* Sensitive data environments
* Payment-related systems

The value of segmentation should be evaluated through containment rather than simply by counting network boundaries.

---

## Human and Workload Identities Require Different Controls

The architecture includes both people and technical workloads.

Human identities may include:

* Customers
* Employees
* Administrators
* Security personnel
* Third-party users

Workload identities may include:

* Applications
* APIs
* Services
* Automated processes
* Cloud resources

Both require authentication, authorization, lifecycle management, and monitoring, but the mechanisms and risk considerations may differ.

---

## Data Crossing a Boundary Requires Explicit Consideration

Network connectivity does not automatically authorize data movement.

When information crosses an environment or application boundary, the architecture should consider:

* Classification
* Ownership
* Purpose
* Minimum required data
* Encryption
* Retention
* Regulatory requirements
* Monitoring
* Downstream use

Data flow is therefore a security boundary consideration independent of network connectivity.

---

## Security Controls Are Also Dependencies

Identity systems, WAF services, logging platforms, hybrid connectivity, DNS, monitoring systems, and other security components can fail.

Architecture should therefore consider both:

**What does this control protect?**

and:

**What happens when this control is unavailable or compromised?**

---

# Part IV — Failure and Containment Review

A Zero Trust architecture should be evaluated under compromised conditions rather than only during normal operation.

## Compromised Customer Identity

Evaluate:

**Identity → Authorized Functions → Reachable Data → Transaction Authority → Additional Verification → Detection**

A compromised customer account should not provide access to other customers, administrative functions, internal systems, or unrelated data.

## Compromised Workforce Identity

Evaluate:

**Identity → Role → Resource Access → Privileged Paths → Segmentation → Detection**

The impact should be constrained by least privilege and separation between ordinary and privileged functions.

## Compromised Application

Evaluate:

**Workload Identity → Network Reachability → Downstream Permissions → Data Access → Lateral Movement → Detection**

Compromise of a public-facing application should not automatically provide broad access to the internal bank environment.

## Compromised Third Party

Evaluate:

**Third-Party Identity → Connection → Authorized Resources → Reachability → Data Access → Revocation**

Third-party compromise should be contained by narrowly scoped connectivity and authorization.

## Hybrid Connectivity Failure

Evaluate:

**Dependency → Affected Services → Degraded Operation → Alternate Path → Recovery → Business Impact**

The security architecture must account for availability as well as unauthorized access.

## Security-Control Failure

Evaluate:

**Control Failure → Remaining Controls → Exposure → Detection → Escalation → Recovery**

The architecture should not assume that WAF, identity, logging, segmentation, or any other individual control will always operate correctly.

---

# Implemented vs. Proposed Boundary Coverage

The AWS PoC provides implementation evidence for selected boundaries involving:

* Public application entry
* Identity verification
* Private workload placement
* Network restrictions
* Request inspection
* IAM-based access concepts
* Logging and auditability

The broader case study considers additional boundaries involving:

* Hybrid cloud and on-premises connectivity
* Enterprise workforce identity
* Customer identity
* Privileged access
* Third-party access
* Application-to-application communication
* Sensitive data environments
* VLAN and network-zone segmentation
* Development and production separation
* Enterprise monitoring
* Resilience and recovery

Those broader boundaries are architecture considerations and should not be interpreted as controls fully implemented by the AWS PoC.

---

# Architectural Principle

The central trust-boundary principle of this project is:

**Crossing one trusted boundary does not eliminate the next boundary.**

An authenticated user is not automatically authorized for every application.

An authorized application is not automatically authorized for every data store.

A private network connection does not create unrestricted trust between environments.

A cloud workload does not automatically receive access to on-premises systems.

An internal user does not automatically receive privileged authority.

Zero Trust therefore depends on continuously limiting trust as identities, applications, data, and communication move through the architecture:

**Verify Identity → Authorize the Action → Restrict Reachability → Protect the Data → Record the Activity → Contain Failure**
