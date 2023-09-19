## Deploy highly available app on ECS with ASG and ALB using Terraform
- This was set up in a public subnet to reduce cost

## Prequisite
- AWS config set up
- Terraform installed

## Step-1: Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Verify Outputs on the CLI or using below command
terraform output
```

## Step-2: Verify app is running on load balancer url
- Check service is running
- Check task is running successfully
- Verify everything works as required