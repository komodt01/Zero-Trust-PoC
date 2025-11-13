# Security Requirements – AWS Zero Trust PoC

## 1. Security Objectives

- Replace perimeter-only trust with **identity- and policy-based access**.
- Prevent direct internet access to compute resources hosting the application.
- Ensure all critical actions are **authenticated, authorized, and auditable**.
- Align the PoC with relevant controls from **NIST SP 800-53**, **PCI DSS**, and **HIPAA**.

## 2. Derived Security Requirements

### 2.1 Identity and Access Management

- All API requests must be authenticated via **Cognito** (user pool or federated IdP); no anonymous API methods.
- Access decisions are based on:
  - Valid OIDC/JWT tokens
  - IAM roles and resource policies for API Gateway, WAF, and EC2
- IAM policies must:
  - Follow **least privilege**, avoiding `*` where possible.
  - Separate infrastructure management roles from application runtime roles.

### 2.2 Network Security and Segmentation

- EC2 instances must reside in **private subnets** with no public IP addresses.
- Only AWS WAF/API Gateway are exposed to the internet.
- Security groups must:
  - Allow traffic only from WAF/API Gateway to the application ports.
  - Restrict outbound traffic from EC2 to what is required (e.g., updates, dependencies).
- No direct SSH/RDP access from the internet. In a production follow-on, **SSM Session Manager** is preferred.

### 2.3 Data Protection

- All communication between clients and API Gateway must use **HTTPS (TLS 1.2+)**.
- Where applicable, data stores integrated into this pattern (S3, RDS, etc.) must use **KMS-backed encryption at rest**.
- Sensitive configuration values (e.g., secrets) should not be hardcoded; future iterations would integrate Secrets Manager or Parameter Store.

### 2.4 Logging, Monitoring, and Detection

- **CloudTrail** must be enabled for the account and configured to store logs centrally.
- API Gateway and WAF logs must be enabled for observability and attack detection.
- Application logs from EC2 should be written in a structured format and retained for troubleshooting and basic forensic analysis.
- Basic alarms should be defined for:
  - Excessive WAF blocks
  - Suspicious API error rates
  - Significant configuration changes

### 2.5 Governance and Compliance

- Terraform is used as the primary **infrastructure as code** mechanism to allow repeatable deployments and configuration review.
- The PoC must map key AWS controls to:
  - NIST SP 800-53 (e.g., AC-2, AC-17, SI-4)
  - PCI DSS categories for access control, network security, and logging
  - HIPAA 164.31x(a)(1) safeguards

## 3. Controls Implemented in the PoC

- Identity enforcement via Cognito and IAM for API access.
- Private VPC subnets for application EC2 instances; no direct internet exposure.
- WAF in front of API Gateway with managed rule sets to reduce OWASP-style attacks.
- CloudTrail enabled to capture API and configuration events.
- Terraform templates to define network topology and related infrastructure.

## 4. Residual Risks and Limitations

- **Single-account deployment** – No organization-level SCPs or centralized security account. This is acceptable for a PoC but not sufficient for production.
- **Limited device context** – Zero Trust decisions are based on identity and network, not device posture or user risk scoring.
- **Manual incident response** – Alerts are not wired to automated remediation; operator action is required.
- **Application-layer authorization** – The PoC focuses on authenticating users to the API, not fine-grained authorization within the application.
- **Log retention and SIEM integration** – Logs are available but not yet integrated into a full SIEM with correlation rules and playbooks.

These limitations are documented in `risks_and_mitigations.md` to show what would be required for a production deployment.
