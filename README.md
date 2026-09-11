# AWS Zero Trust PoC and Regional Bank Architecture Case Study

## Project Overview

This repository explores how Zero Trust principles could be applied to a hypothetical regional bank operating in a hybrid environment. It combines two architecture case studies with an AWS proof of concept (PoC) that validates selected security concepts.

The architecture case studies are intentionally broader than the AWS implementation. They address business risk, trust boundaries, identity, segmentation, hybrid connectivity, resilience, monitoring, data ownership, governance, and architecture tradeoffs.

AWS is used as the supporting PoC platform to demonstrate selected controls in practice. The PoC is not intended to represent the bank's complete production architecture or to imply that AWS would necessarily be selected as the production platform.

## Scope Note

**Implemented:** The AWS PoC demonstrates selected controls using API Gateway, Cognito, AWS WAF, private EC2 infrastructure, VPC security controls, CloudTrail/logging, and portions of the infrastructure built with Terraform.

**Proposed architecture:** The regional bank scenario, hybrid enterprise architecture, enterprise-scale integrations, resilience decisions, governance model, and related architecture recommendations are part of a hypothetical case study and were not implemented as a production banking environment.

## Choose Your View

### Executive Case Study

[Executive Case Study: Protecting a Regional Bank as Digital Services Expand](Executive%20Case%20Study.md)

A business-focused view of the hypothetical regional bank scenario. It focuses on customer trust, business risk, isolation, containment, resilience, and the impact of a security failure without requiring the reader to understand the underlying cloud technologies.

### Technical Case Study

**[Technical Case Study: Zero Trust Architecture for a Regional Bank](TECHNICAL_CASE_STUDY%20.md)**

A technical architecture view of the same scenario. It covers the hybrid environment, architecture requirements, threat assumptions, trust boundaries, identity and access, segmentation, hybrid connectivity, application protection, monitoring, containment, resilience, cost, architecture tradeoffs, enterprise-scale considerations, and standards traceability.

### AWS PoC

The PoC provides implementation evidence for selected concepts from the broader architecture using:

- Amazon API Gateway for a controlled public API entry point
- Amazon Cognito for authentication and token issuance
- AWS WAF for request inspection and common web attack protections
- Private EC2 workloads with no direct internet exposure
- VPC segmentation and security controls
- AWS CloudTrail and supporting logs for auditability and investigation
- Terraform for portions of the infrastructure deployment

## Architecture Overview

At a high level, the PoC demonstrates a controlled path from an external request to a protected application workload.

1. A user accesses the application through a public API endpoint.
2. Identity is verified using Amazon Cognito and token-based authentication.
3. AWS WAF provides request inspection and filtering for common web attack patterns and inappropriate traffic.
4. Approved traffic reaches application workloads hosted on private EC2 infrastructure.
5. Security and control-plane activity is recorded through CloudTrail and supporting logging sources.

The EC2 workload is not directly exposed to the internet. Access is mediated through defined entry points, identity controls, security policy, and network restrictions.

## Zero Trust Concepts Demonstrated

### Identity Before Access

Authentication is required before protected application functions are reached. Successful authentication does not imply unrestricted access to the rest of the environment.

### No Implicit Network Trust

The application workload is private. Network location alone is not treated as sufficient reason to trust a request or identity.

### Isolation and Segmentation

Private workloads and network controls reduce unnecessary reachability and help limit the potential impact of a compromised component.

### Controlled Entry Points

API Gateway and WAF provide defined points through which public application traffic is received and evaluated rather than exposing the underlying workload directly.

### Logging and Evidence

CloudTrail and supporting logs provide evidence of activity that can support monitoring, investigation, and audit requirements.

## What the PoC Validates

The AWS implementation provides practical evidence for selected parts of the broader architecture:

- Identity-based access
- Controlled application exposure
- Request inspection
- Workload isolation
- Network segmentation concepts
- Security logging and auditability
- Repeatable infrastructure deployment concepts

The PoC supports the architecture case study, but it should not be interpreted as validation of the entire enterprise design.

## What the PoC Does Not Validate

The PoC does not reproduce the complete hybrid banking environment described in the technical case study.

It does not validate:

- Production-scale hybrid connectivity to on-premises banking systems
- Enterprise workforce and customer identity integration
- Privileged access management
- Full enterprise network segmentation
- Centralized SIEM correlation across all bank environments
- Production resilience, failover, disaster recovery, or multi-region design
- Actual banking data placement or payment-system integration
- Complete regulatory or compliance requirements
- A production cloud-provider selection

Those areas would require additional architecture, engineering, testing, operational planning, and validation before a production recommendation could be made.

## Infrastructure-as-Code Note

Portions of the PoC were built using Terraform to provision components such as the VPC, subnets, route tables, and private EC2 instances.

The Terraform files are not included in this repository. They were used to support the testing environment and demonstrate concepts including:

- Network provisioning through Infrastructure as Code
- Private subnet configuration
- Repeatable deployment patterns
- Variables, outputs, and structured configuration

The repository therefore documents the IaC work without presenting unavailable Terraform source files as current repository artifacts.

## Security Standards and Compliance

The project includes high-level mapping to security and compliance frameworks to demonstrate how selected architecture decisions relate to recognized control requirements.

Examples include:

- NIST SP 800-207 Zero Trust principles
- Selected NIST SP 800-53 access-control and monitoring requirements
- PCI DSS concepts related to access control, segmentation, protection of payment environments, and logging
- HIPAA security safeguard concepts included in the original PoC mapping

See **[Compliance Mapping](Compliance_Mapping.md)** for the PoC-specific mapping. The technical case study provides broader architecture and control traceability.

These mappings are illustrative. A real financial institution would have additional regulatory, compliance, contractual, legal, and internal policy requirements that would need to be identified and incorporated into the architecture.

## Supporting Documentation

The repository includes additional documentation developed as part of the PoC:

- **[Project Summary](Project_Summary.md)** — original PoC objectives and implementation summary
- **[Security Requirements](Security_Requirements.md)** — security requirements used for the PoC
- **[Risks and Mitigations](Risks_and_Mitigations.md)** — identified risks and corresponding controls
- **[Technologies](Technologies.md)** — technologies used in the implementation
- **[Compliance Mapping](Compliance_Mapping.md)** — high-level control-framework mapping
- **[Lessons Learned](Lessons_Learned.md)** — observations and lessons from the implementation
- **Diagrams/** — supporting architecture and security diagrams

## Key Takeaway

The AWS PoC demonstrates selected Zero Trust controls in practice, while the accompanying case studies expand the exercise into a broader architecture problem.

The goal is not to present one cloud platform or one set of security services as the answer. The goal is to show how business risk can be translated into architecture requirements, how security and operational tradeoffs can be evaluated, and how a focused PoC can be used to validate selected parts of a larger design.
