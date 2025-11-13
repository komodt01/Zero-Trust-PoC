# Risks and Mitigations – AWS Zero Trust PoC

| Risk ID | Risk Description                                              | Impact                                  | Likelihood | Mitigation / Comment                                                                                      |
|--------:|----------------------------------------------------------------|-----------------------------------------|-----------|-----------------------------------------------------------------------------------------------------------|
| R1      | Single AWS account for PoC and security services              | Weaker blast-radius control             | Medium    | Use AWS Organizations and a landing zone for production; apply SCPs and account-level guardrails.        |
| R2      | No device posture checks                                      | Compromised but authenticated clients   | Medium    | Integrate conditional access / risk-based policies in IdP for production workloads.                       |
| R3      | Limited application-layer authorization                       | Over-privileged users within the app    | Medium    | Implement fine-grained, role- or attribute-based access controls at the application/business logic layer. |
| R4      | Manual incident response                                      | Slower containment of attacks           | Medium    | Add automated responders (Lambda/Step Functions) for WAF events, IAM anomalies, and config changes.      |
| R5      | Log retention and SIEM integration not fully defined          | Harder to perform long-term forensics   | Low/Med   | Define retention policies; forward key logs to a SIEM with correlation rules and playbooks.              |
| R6      | Terraform does not yet cover 100% of configuration            | Risk of console drift and misconfig     | Medium    | Extend IaC coverage; enforce changes through code review and CI/CD.                                      |
| R7      | No explicit DDoS strategy beyond managed protections          | Potential service disruption            | Low       | For production, review Shield Advanced, rate limiting, and capacity planning.                             |

The PoC acknowledges these risks and uses them to drive a roadmap for a production-grade Zero Trust architecture.
