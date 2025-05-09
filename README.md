
# AWS Zero Trust Terraform PoC

## 🛡️ Purpose

This Proof of Concept (PoC) demonstrates a Zero Trust architecture using AWS-native services and Terraform. The infrastructure ensures that no resource is directly exposed to the internet and all access is controlled via identity-aware services like Amazon Cognito and API Gateway.

## 🔧 Components Deployed

- **Amazon VPC** with:
  - Public Subnet
  - Internet Gateway
  - Route Table for Internet Access
- **Amazon EC2**: Web server in a public subnet (secured via AWS IAM and Zero Trust routing)
- **Amazon Cognito**: User pool for identity-aware access control
- **Amazon API Gateway**: REST API frontend with controlled exposure
- **Terraform Outputs**: Key identifiers like EC2 instance ID, Cognito Pool ID, and API Gateway URL

## 🚀 How to Deploy

1. **Set AWS CLI Profile** (if not default):
   ```powershell
   $env:AWS_PROFILE = "aws-zero-trust"
   ```

2. **Run Terraform Commands**:
   ```powershell
   terraform init
   terraform plan -out zt-plan.tfplan
   terraform apply "zt-plan.tfplan"
   ```

## 🔍 Requirements

- Terraform v1.5+
- AWS CLI configured with valid credentials
- An AWS account with IAM permissions to deploy VPC, EC2, Cognito, and API Gateway

## 🧾 Variables (`terraform.tfvars`)

Create a `terraform.tfvars` file:
```hcl
aws_region = "us-east-1"
ami_id     = "ami-xxxxxxxxxxxxxxxxx"  # Update with valid AMI
```

## 📦 Outputs

- `ec2_instance_id`
- `cognito_user_pool_id`
- `api_gateway_url`

## 🔚 Teardown

Refer to [`teardown.md`](./teardown.md) for cleanup instructions to avoid incurring AWS charges.

## 📘 Additional Notes

- EC2 instance is reachable only through controlled access (no open SSH in this PoC)
- Designed for educational/lab purposes and is not production-hardened
