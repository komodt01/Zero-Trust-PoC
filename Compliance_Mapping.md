# Compliance Mapping – AWS Zero Trust PoC

This PoC is not a full compliance solution but demonstrates how AWS-native controls can help support requirements in **NIST SP 800-53**, **PCI DSS**, and **HIPAA**.

## Summary Table

| AWS Control             | NIST SP 800-53                 | PCI DSS (example areas)                            | HIPAA (example)           |
|-------------------------|---------------------------------|----------------------------------------------------|---------------------------|
| API Gateway + Cognito   | AC-2 (Account Management)      | Req. 7 – Restrict access to cardholder data       | 164.312(a)(1) – Access    |
|                         | AC-17 (Remote Access)          | Req. 8 – Identify/authenticate access to systems  |                           |
| AWS WAF                 | SI-4 (System Monitoring)       | Req. 1 & 6 – Protect systems from attacks         | 164.310(a)(1) – Security  |
| Private EC2 in VPC      | (Supports SC/Baseline CM)      | Req. 1 – Network segmentation and firewalling     | 164.310(a)(1) – Facility  |
| CloudTrail              | AU-2 (Audit Events), AU-6      | Req. 10 – Track and monitor all access            | 164.312(b) – Audit        |

> **Note:** These mappings are illustrative, showing how Zero Trust-oriented controls contribute to compliance posture. A full assessment would require additional controls and documentation.

## Control Rationale

- **API Gateway + Cognito**
  - Centralizes access control and enforces strong authentication.
  - Supports requirements around uniquely identifying users and controlling who may access which APIs.

- **AWS WAF**
  - Provides active monitoring and blocking of malicious requests.
  - Helps address requirements for protecting public-facing web applications from known attacks.

- **Private EC2**
  - Implements network isolation and limits exposure of systems that process sensitive data.
  - Supports firewall and segmentation requirements.

- **CloudTrail**
  - Records security-relevant events for later review.
  - Helps demonstrate who accessed or modified systems and data.

This mapping positions the PoC as a **bridge** between architecture decisions and compliance frameworks, without overstating its scope.
