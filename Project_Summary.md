# Project Summary – AWS Zero Trust PoC

## 1. Problem Statement

Traditional perimeter-based security assumes that anything inside the network is trustworthy. For internet-facing APIs, this is no longer acceptable. The organization needed a way to:

- Protect a simple web/API workload from common attacks.
- Ensure that all access is authenticated and auditable.
- Demonstrate how Zero Trust concepts can be applied using AWS-native services.

## 2. Project Definition

This proof of concept implements a **Zero Trust-inspired reference architecture** on AWS using:

- API Gateway
- Amazon Cognito
- AWS WAF
- Private EC2 instances in a VPC
- CloudTrail and other logging sources

The PoC emphasizes **identity-centric access, segmentation, and observability**, not full enterprise-scale Zero Trust.

## 3. Goals and Success Criteria

- All API access requires authenticated, token-based identity.
- No direct internet access to EC2; traffic must pass through WAF and API Gateway.
- Core actions are logged (CloudTrail + application logs) for audit and incident response.
- The PoC can be deployed in a lab account using infrastructure as code (Terraform).

## 4. Scope and Assumptions

**In scope**

- Single account, single region.
- One public API Gateway endpoint secured by Cognito and WAF.
- A small set of private EC2 instances hosting a demo application.
- Baseline compliance mapping for NIST SP 800-53, PCI DSS, and HIPAA.

**Out of scope**

- Multi-account landing zone and SCP guardrails.
- Endpoint/device posture checks.
- Fine-grained authorization at the data level.
- Full SIEM and SOAR integration.

## 5. Methodology

1. **Design** – Created the high-level architecture diagram and mapped controls to Zero Trust principles and frameworks.
2. **Build** – Used Terraform to deploy VPC, subnets, route tables, internet gateway, and EC2 instances.
3. **Integrate** – Configured API Gateway, Cognito, and WAF to front the application and require authenticated requests.
4. **Observe** – Verified CloudTrail and related logs captured key events, including API calls and configuration changes.
5. **Evaluate** – Documented the achieved controls, gaps, and next steps in `security_requirements.md` and `risks_and_mitigations.md`.

## 6. Results

- All inbound traffic to the application flows through API Gateway and WAF.
- EC2 instances are private with no public IP addresses.
- Basic Zero Trust patterns are in place:
  - Identity-driven access
  - Network segmentation
  - Centralized logging and monitoring
- Compliance mapping shows how core controls help support NIST, PCI DSS, and HIPAA requirements for access, monitoring, and audit.

## 7. Recommendations and Next Steps

To progress from PoC to production:

- Move into a **multi-account landing zone** with dedicated security and shared services accounts.
- Expand **logging and alerting** into a SIEM with defined detection rules.
- Implement **fine-grained authorization** at the application layer (e.g., per-role or per-tenant controls).
- Introduce **automated remediation** for WAF / IAM / configuration anomalies.
- Integrate **device posture or conditional access** via the identity provider for higher-risk use cases.
