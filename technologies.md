
# 🧪 Technologies Used

This Zero Trust PoC uses native AWS services and Terraform infrastructure as code. Here's a breakdown of each technology:

---

## 🏗️ Terraform
**What it is**: An open-source infrastructure as code tool that lets you build, change, and version cloud infrastructure safely and efficiently.

**Why it’s used**: Enables repeatable, consistent, and auditable deployment of AWS infrastructure.

---

## ☁️ Amazon VPC
**What it is**: A virtual network that closely resembles a traditional data center network.

**Why it’s used**: Provides isolation and control over networking components including subnets, route tables, and gateways.

---

## 🌐 Amazon Internet Gateway (IGW)
**What it is**: A horizontally scaled, redundant, and highly available VPC component that allows communication between instances in your VPC and the internet.

**Why it’s used**: Required for public subnet routing to allow EC2 to access the internet (e.g., for updates, CloudWatch logs, etc.).

---

## 📡 Amazon API Gateway
**What it is**: A fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs.

**Why it’s used**: Acts as the secure entry point into the application layer — enforces access control before reaching EC2 resources.

---

## 🔐 Amazon Cognito
**What it is**: Provides user authentication, authorization, and user management.

**Why it’s used**: Identity-based access control, a critical component of Zero Trust, ensuring only authenticated users can access protected APIs.

---

## 💻 Amazon EC2
**What it is**: Scalable virtual servers in the AWS Cloud.

**Why it’s used**: Hosts the backend workload (e.g., a web server), placed behind API Gateway and not directly exposed to the public.

