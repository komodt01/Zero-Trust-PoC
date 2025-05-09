
# 📘 Lessons Learned

This PoC demonstrated several key takeaways in designing and deploying a Zero Trust architecture using Terraform and AWS-native services.

---

## 🔹 Always Validate Resource References
Terraform will break if outputs reference undeclared resources — outputs.tf must align exactly with what's declared.

---

## 🔹 Stale Plans = Replan
Changing variables (e.g., AMI ID or subnet ID) after saving a `.tfplan` will invalidate it. Always re-run `terraform plan` after such changes.

---

## 🔹 Use Dynamic AMI Lookups When Possible
Hardcoding AMI IDs works temporarily but breaks across regions or over time. Consider using `data "aws_ami"` to dynamically fetch the latest AMI.

---

## 🔹 Modular Design Helps
Splitting networking from compute/API layers helped isolate issues and made debugging easier. You can apply them independently or integrate fully.

---

## 🔹 Teardown Scripts Prevent Cost Overruns
Having a clear `teardown.md` or script is essential in labs to prevent forgotten EC2 or API Gateway instances incurring costs.

---

## 🔹 Cloud Shell is Limited
Running locally gave more control and stability vs. AWS Cloud Shell’s 1GB limit and timeout sessions.

---

This PoC reflects practical, real-world challenges in deploying secure cloud architectures — valuable for both learning and interviews.
