# Lessons Learned – AWS Zero Trust PoC

## 1. Zero Trust Is a Direction, Not a Single Product

Implementing API Gateway, Cognito, WAF, and private EC2 does not “complete” Zero Trust. It does, however, show how identity-centric access and segmentation can be achieved with AWS-native services.

**Key takeaway:** Focus on principles (identity, least privilege, continuous verification) and use services as building blocks.

## 2. Identity is the New Perimeter

Configuring Cognito and API Gateway correctly is as important as configuring security groups or NACLs. Weak identity configuration would undermine the value of private subnets.

**Key takeaway:** Treat IdP configuration and token validation as critical security controls, not just plumbing.

## 3. Logging and Observability Must Be Designed, Not Assumed

Simply enabling CloudTrail is not enough. You must know:

- Which events matter.
- Where logs are stored.
- How long they are retained.
- Who reviews them and how alerts are generated.

**Key takeaway:** Logging is part of the architecture, not an afterthought.

## 4. Infrastructure as Code Accelerates Security Reviews

Using Terraform for the network and core infrastructure made it easier to:

- Reason about trust boundaries.
- Identify overly broad permissions.
- Rebuild the PoC cleanly if changes were needed.

**Key takeaway:** IaC supports both operational repeatability and security governance.

## 5. PoC vs. Production: Be Honest About Gaps

The PoC highlights several gaps that would need to be addressed for production, including:

- Multi-account design and SCPs.
- Device posture and conditional access.
- Automated incident response and SOAR integration.
- Fine-grained authorization in the application.

**Key takeaway:** Calling out limitations strengthens credibility and sets a clear roadmap for next steps.

## 6. Communication Matters

Diagrams and compliance mappings (NIST, PCI, HIPAA) helped translate technical design decisions into language that risk, audit, and business stakeholders can relate to.

**Key takeaway:** A good architecture is one that can be explained clearly to both engineers and non-technical stakeholders.
