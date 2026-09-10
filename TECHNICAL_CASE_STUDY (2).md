# Technical Case Study: Zero Trust Architecture for a Regional Bank

**Hypothetical Financial Services Scenario**

## 1. Technical Scenario and Architecture Objective

For this scenario, the regional bank operates a hybrid environment. Core and legacy systems may remain in the bank's existing environment while newer digital services may use cloud platforms. Employees, customers, applications, third parties, cloud services, and administrative users all require different levels and types of access.

The architecture should not rely on either the internal network or the cloud environment itself as a trusted boundary. The objective is to verify and restrict access, isolate sensitive resources, control connections between environments, provide sufficient visibility, and contain a compromise if one occurs.

I would keep the enterprise architecture cloud-provider neutral at this stage. Selection of a production cloud platform would require evaluation of the bank's existing technology investments, application requirements, security capabilities, interoperability, operational support, staff skills, resilience requirements, regulatory obligations, migration complexity, total cost of ownership, and ongoing FinOps considerations.

AWS is used for the supporting PoC to illustrate what selected portions of the architecture could look like in practice. It is not a conclusion that AWS would be the bank's production platform.

## 2. Architecture Requirements

For this scenario, the architecture needs to:

- Verify identity before granting access.
- Limit access to what an identity or service actually needs.
- Isolate sensitive resources and environments.
- Control the paths into protected services.
- Inspect traffic for malicious or inappropriate requests.
- Record security-relevant activity.
- Contain compromise rather than allowing unrestricted lateral movement.
- Support repeatable controls and governance.
- Support availability and resilience appropriate to the business service.

I would distinguish between the requirement, the architecture decision used to address it, what the PoC actually validates, and what would still need to be addressed at enterprise scale.

## 3. Threat Assumptions

For this scenario, I would assume:

- Credentials can be compromised.
- Applications can be compromised.
- Third parties can be compromised.
- Authorized access can be misused.
- Devices and systems should not be trusted merely because of their location.
- Individual security controls can fail.
- Connectivity between environments can create additional exposure.

A successful compromise should not automatically provide the attacker with a pathway to additional systems, information, or environments.

## 4. Proposed Architecture, Trust Boundaries, and Resilience

A trust boundary is a point where the level of trust changes and access should be evaluated or controlled. It is not necessarily a physical firewall, network boundary, or cloud boundary.

For this scenario, important trust boundaries include:

- Internet users and customer-facing banking services
- Employees and sensitive internal systems
- Third parties and bank resources
- Applications communicating with other applications
- Cloud services communicating with on-premises systems
- Standard users and administrative functions
- Sensitive data environments and other areas of the enterprise

The question at each boundary is:

**When something crosses from one area into another, what must be verified before it is allowed to proceed?**

Crossing one boundary successfully should not make subsequent boundaries disappear. In particular, a hybrid connection between the cloud and the bank's existing environment should not create broad mutual trust.

At a high level, the architecture follows this path:

**Customers / Employees / Third Parties**

↓

**Controlled Access and Verification Boundary**

↓

**Digital Services / Applications**

↓

**Application-to-Application Trust Boundaries**

↓

**Sensitive Banking Services and Data**

The cloud environment would connect to the bank's existing environment through **controlled and resilient hybrid connectivity**, while visibility, logging, policy, and governance span the architecture.

Hybrid connectivity is both a security boundary and an operational dependency. The design therefore needs to address both how access crosses that boundary and what happens when the connection is unavailable.

## 5. Identity and Access Architecture

The identity architecture needs to account for different types of identities, including employees, customers, administrators, third-party users, applications, services, and automated processes.

A successful authentication should not by itself result in broad access. Access decisions should also consider the resource being requested, the action being performed, whether that access is needed, the role or function of the identity, and whether additional verification is appropriate for a higher-risk action.

Normal and privileged access should be treated differently. Administrative, security, payment, and other high-impact functions require tighter restrictions and stronger monitoring than routine access.

Application and service identities also need defined permissions rather than relying on broad trust between technical integrations, particularly when those integrations cross cloud and on-premises boundaries.

**Every identity should receive only the access required for its function, and higher-risk actions should require stronger controls.**

Identity lifecycle is part of the architecture as well. Access needs to be granted, changed, reviewed, and removed as responsibilities change.

Meaningful identity and access activity should be logged in some capacity, including sign-in attempts, approvals and denials, privileged actions, service-to-service access, and permission changes. The exact logging mechanism will vary, but the bank should be able to reconstruct who or what requested access, what was allowed or denied, and what changed.

## 6. Hybrid Connectivity, Isolation, and Resilience

In this scenario, some services may operate in the cloud while critical systems and potentially sensitive data remain in the bank's existing environment. Connectivity between them may be necessary, but that connection should not create broad trust.

For each connection, I would first determine:

- What specifically needs to communicate?
- What data needs to cross the boundary?
- In which direction does it need to move?
- How frequently is the connection required?
- What level of access is actually necessary?

Connectivity should then be limited to that business requirement.

Systems with different sensitivity, purpose, or risk should also be segmented rather than sharing unrestricted network space. In an on-premises environment, this could include separate VLANs, network segments or zones, firewalls, and access-control rules. In a cloud environment, equivalent controls could include virtual networks, subnets, security policies, and workload-level controls. The exact mechanism is platform-dependent.

The purpose of segmentation is not segmentation for its own sake. It is to limit reachability and contain lateral movement. A compromised customer-facing application, for example, should not have unrestricted access to internal systems simply because it needs information from one of them.

Isolation also applies between applications, administrative functions, development and production environments, sensitive data stores, and payment-related systems.

Data placement should be considered separately from application placement. Moving an application to the cloud does not automatically mean the underlying data should move with it. If a cloud service needs access to information that remains on-premises, the architecture should control the path, restrict what can cross it, and account for what happens if that connection fails.

Because hybrid connectivity becomes an operational dependency, the production design would need to consider redundant connectivity, alternate paths, failure and recovery behavior, and degraded operating states according to service criticality.

Those resilience decisions also have cost implications. Not every service requires the same level of redundancy. The investment should reflect the business impact of losing the service.

Boundary connections, denied traffic, connectivity changes, and administrative actions should produce sufficient evidence for monitoring and investigation.

**Connect only what needs to communicate, expose only what needs to be available, move only the data that needs to move, and design resilience according to the business impact of failure.**

## 7. Application and Edge Protection

For internet-facing services, I would first determine what actually needs to be publicly exposed. The customer-facing portion of a service may need to be reachable from the internet, but the underlying application components, databases, payment systems, and internal services do not necessarily need direct exposure.

Requests should enter through a controlled entry point where they can be inspected, common attack patterns can be addressed, usage can be limited where appropriate, and legitimate traffic can be routed to the intended service.

Where identity is required, reaching the application is not the same as being authorized to access an account, initiate a transaction, or perform another protected action.

The application should have only the downstream connectivity it requires. If the public-facing layer is compromised, segmentation and access controls should prevent that compromise from automatically creating unrestricted access to customer data, payment systems, administrative functions, or the bank's existing environment.

The security controls protecting the entry point are themselves operational dependencies. Production design would therefore need to consider availability, capacity, failure behavior, high traffic volumes, and denial-of-service conditions. The amount of redundancy and geographic resilience should reflect the importance of the service and the cost of an outage.

Suspicious and blocked requests, access attempts, unusual traffic patterns, and security-control configuration changes should generate evidence for monitoring and investigation.

In the supporting AWS PoC, API Gateway illustrates a controlled public API entry point and AWS WAF illustrates request inspection and protection against common web attacks.

**Expose only what needs to be exposed, inspect traffic before it reaches sensitive services, and don't allow compromise of the public-facing layer to create unrestricted access behind it.**

## 8. Logging, Monitoring, and Evidence

Security-relevant activity from the hybrid environment should feed a centralized monitoring capability. This includes identity and access activity, privileged actions, application security events, network and trust-boundary activity, security-control changes, and significant system or configuration changes.

The objective is to correlate activity across environments rather than investigate each source independently.

The evidence should be sufficient to establish:

**Who or what acted → What was attempted → Which resource was involved → Allowed or denied → Origin → What happened next**

Higher-risk activity should drive detection and alerting, with thresholds and use cases based on the potential security and business impact. Detection rules and thresholds would also need periodic tuning as normal activity patterns, threats, systems, and business processes change. In a SIEM, for example, this could include adjusting correlation rules, alert thresholds, and use cases based on observed results.

Access to logs should be restricted, critical records should be protected from unauthorized alteration or deletion, and retention should reflect investigative, regulatory, legal, policy, and cost requirements.

Monitoring also needs to account for hybrid availability. Loss of a connection or monitoring component should not unnecessarily eliminate security visibility.

In the AWS PoC, CloudTrail and other logging illustrate selected portions of this requirement. A production bank would need broader centralized monitoring and correlation across cloud, on-premises, identity, network, application, and security-control sources.

## 9. Containment and Failure Scenarios

The architecture should be evaluated assuming an individual control or component can fail. For this scenario, I would test:

- **Stolen credentials:** What additional systems can the compromised identity reach, and which boundaries prevent further access?
- **Compromised application:** What downstream systems or data are reachable, and where is movement restricted?
- **Compromised third party:** What bank resources are reachable through the provider's existing connection?
- **Hybrid connectivity failure:** Which services are affected, which can continue, and what recovery options are available?

For each scenario, I would evaluate:

**Reachability → Permissions → Segmentation → Containment → Visibility → Escalation → Business Impact**

The purpose is to validate that failure of one control or component does not unnecessarily provide broader access or create a larger operational failure.

Escalation matters because detection alone is not enough. Higher-risk events need defined escalation paths and current contacts so the appropriate security, technology, operational, vendor, or business owners can be reached quickly. Who needs to be contacted, in what order, and under what conditions should be established before an incident occurs rather than determined during one.

## 10. Architecture Decisions and Tradeoffs

For this scenario, I focused on the decisions that would have the greatest impact on security, operations, resilience, and cost.

**Hybrid vs. full cloud:** The scenario retains a hybrid model rather than assuming everything should move to the cloud. Data sensitivity, existing systems, regulatory and contractual requirements, dependencies, migration risk, operational capability, and cost all influence that decision.

**Data placement:** Sensitive data does not automatically move with an application. For each workload, I would evaluate where the data should reside and what information actually needs to cross environment boundaries.

**Segmentation vs. complexity:** Greater segmentation can improve containment, but every additional boundary introduces configuration, monitoring, troubleshooting, and operational overhead. The level of segmentation should reflect the sensitivity and risk of the systems being protected.

**Resilience vs. cost:** Redundant connectivity, failover capability, additional capacity, and geographic diversity can improve availability, but they also increase cost and operational complexity. The appropriate investment should reflect the criticality of the service and the business impact of an outage.

**Security vs. usability:** Additional access controls can reduce risk but can also create friction for customers and employees. Higher-risk activities may justify stronger verification without applying the same level of friction to every interaction.

**Cloud/platform selection:** I would keep the enterprise architecture cloud-agnostic. AWS is used in the PoC to illustrate selected architecture concepts, not because this case study concludes that AWS is the best production platform. A real selection would require evaluation of existing investments, integration, security capabilities, support, skills, resilience, migration effort, operational model, and total financial impact.

## 11. PoC Validation

For this case study, AWS was used to illustrate how selected security concepts could be implemented in a cloud environment. The PoC validates portions of the proposed approach; it does not represent a complete production implementation for the hypothetical bank.

The PoC demonstrates several of the concepts discussed in the case study:

**Controlled entry point:** API Gateway provides a defined path into the application rather than directly exposing the underlying resource.

**Identity-based access:** Cognito demonstrates authentication and token-based access before protected application functions are reached.

**Application protection:** AWS WAF provides inspection and filtering of incoming requests, including protections against common web attacks.

**Isolation:** The application workload is placed on private EC2 infrastructure without direct public exposure, illustrating the principle that underlying resources do not need to be internet-accessible simply because the service itself is available externally.

**Logging and evidence:** CloudTrail and supporting logs demonstrate how activity can be recorded for investigation and audit purposes.

**Infrastructure consistency:** Terraform was used for portions of the environment to demonstrate repeatable infrastructure configuration rather than relying entirely on manual setup.

The PoC does not implement the full hybrid bank environment described in this case study. It does not validate production-scale hybrid connectivity, enterprise identity integration, full network segmentation, centralized enterprise monitoring, production resilience and failover, or the complete regulatory and operational requirements of a financial institution.

Those areas would require additional design, testing, and validation before a production recommendation could be made.

## 12. Enterprise-Scale Considerations

The PoC demonstrates selected controls, but moving the architecture into a production banking environment would require additional decisions based on the bank's existing technology, risk profile, business services, and operating model.

**Enterprise identity integration:** Customer, workforce, privileged, third-party, application, and service identities would need to integrate with the bank's existing identity environment. Access provisioning, changes, periodic reviews, and deprovisioning would also need to be incorporated.

**Privileged access:** Administrative access to critical systems would require stronger controls, separation from normal user access, tighter monitoring, and defined emergency-access procedures.

**Hybrid integration:** Cloud services would need controlled connectivity to the specific on-premises systems they require without creating broad trust between environments. Network segmentation, routing, firewall policy, encryption, DNS, and dependency mapping would need to be addressed as part of that design.

**Data ownership and placement:** The bank would need to identify who owns each significant data set and where that data is permitted to reside. Data owners should be accountable for classification, approved use, access requirements, retention, and decisions about whether information can move between on-premises and cloud environments. The architecture would then enforce those decisions through access controls, segmentation, encryption, monitoring, and controlled data flows.

**Resilience and recovery:** Production design would need to account for failure of connectivity, identity services, security controls, cloud services, and supporting infrastructure. Recovery objectives, redundancy, failover, degraded operating modes, and the cost of providing that resilience would need to reflect the criticality of each banking service.

**Centralized security monitoring:** Cloud, on-premises, identity, network, application, and security-control telemetry would need to feed the bank's broader monitoring and incident processes so activity can be correlated across the environment.

**Operational ownership and escalation:** Controls need owners. Production implementation would require clear responsibility for monitoring, configuration, response, recovery, and exceptions. Escalation paths and current contacts would need to include the appropriate security, infrastructure, application, business, cloud, and third-party owners.

**Governance and change:** Architecture standards, configuration baselines, policy enforcement, exceptions, change management, and periodic review would be necessary to prevent the environment from gradually moving away from the intended design. Significant changes to applications, data flows, integrations, or business requirements should also trigger review of the relevant architecture decisions and controls.

**Cost and capacity:** Security and resilience decisions would need to account for ongoing operating cost, including connectivity, logging and retention, redundant infrastructure, security services, data transfer, storage, and capacity requirements.

**Validation before production:** Architecture reviews, threat modeling, security testing, failure testing, recovery exercises, and control validation would be required before treating the design as production-ready.

## 13. Security Standards and Control Traceability

The architecture should be traceable back to the business and security requirements that drove the design. For this scenario, I would use recognized security standards as part of that traceability rather than designing controls around a specific product.

The basic path is:

**Business Requirement → Security Requirement → Architecture Decision → Technical Control → Standards Alignment → Evidence**

### Prevent inappropriate access to banking systems

- **Architecture decision:** Verify identity and restrict access based on need.
- **Standards alignment:** NIST SP 800-207; selected NIST SP 800-53 access-control requirements.
- **Evidence:** Authentication, authorization, and access logs.

### Limit the impact of a compromised account or system

- **Architecture decision:** Segment environments and restrict communication across trust boundaries.
- **Standards alignment:** NIST SP 800-207; selected NIST SP 800-53 access-control and boundary-protection requirements.
- **Evidence:** Network and security policy, denied connections, and segmentation testing.

### Protect payment-related systems and information

- **Architecture decision:** Isolate sensitive services and tightly control permitted access paths.
- **Standards alignment:** PCI DSS requirements for access control, segmentation, and protection of account data.
- **Evidence:** Configuration evidence, access records, and segmentation validation.

### Detect and investigate suspicious activity

- **Architecture decision:** Centralize security-relevant logging and monitoring.
- **Standards alignment:** Selected NIST SP 800-53 audit and monitoring requirements; applicable PCI DSS logging requirements.
- **Evidence:** Logs, alerts, monitoring records, and investigation evidence.

### Control privileged activity

- **Architecture decision:** Separate privileged access and apply stronger controls and monitoring.
- **Standards alignment:** Selected NIST SP 800-53 account-management and least-privilege requirements.
- **Evidence:** Privileged-access records, approvals, and activity logs.

### Maintain accountability for sensitive data

- **Architecture decision:** Define data ownership, classification, permitted location, and access requirements.
- **Standards alignment:** Selected NIST SP 800-53 information-protection controls; applicable PCI DSS data-protection requirements.
- **Evidence:** Data classification, ownership records, access policy, and retention evidence.

The point of the mapping is not simply to show that a control exists. It should be possible to follow a requirement from the original business or security need through the architecture and eventually to evidence showing that the control is operating as intended.

*These are a few readily identifiable examples for purposes of this case study. A real financial institution would have additional regulatory, compliance, contractual, and internal policy requirements that would need to be identified and incorporated into the architecture.*

## 14. What This Demonstrates

This case study demonstrates how I would approach a cloud security architecture problem by starting with the business risk and working through the security and technical decisions needed to address it.

The approach connects business and security requirements to trust boundaries, identity, segmentation, data ownership and placement, resilience, monitoring, governance, and applicable standards. It also considers the operational and financial tradeoffs involved rather than treating security controls in isolation.

The AWS PoC provides implementation evidence for selected architecture concepts without being presented as a complete enterprise implementation or predetermined production platform.

The same architecture can also be communicated at different levels. The accompanying executive case study focuses on business risk, isolation, containment, resilience, and business impact, while this technical case study provides the architecture decisions and reasoning behind that approach.
