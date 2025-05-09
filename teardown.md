
# 🧹 Teardown Guide

To destroy all resources deployed by this Terraform project:

## Step 1: Set AWS Profile (if using one)
```powershell
$env:AWS_PROFILE = "aws-zero-trust"
```

## Step 2: Run Terraform Destroy
```powershell
terraform destroy -auto-approve
```

## Optional: Cleanup State Files (Use With Caution)
After confirming that all resources are destroyed:
```powershell
Remove-Item -Recurse -Force .terraform
Remove-Item terraform.tfstate*
```

⚠️ Only delete `.terraform` and state files if you are **sure** you won't need to recover the Terraform state.

## Reminder

You are responsible for any AWS charges incurred. Always verify all resources are destroyed in the AWS Console.
