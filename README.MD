# What is it, anyhow?

Just sample Terraform configuration that's creates sample Infrastructure for typical web application with separate VPC, AWS ECS, and all underlying Infra.

# How to deploy?

Install AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/installing.html

Configure credentials for your AWS account

Configure frontend/package.json - "proxy": "https://dev-api.be34.me:443" -> to your subdomain

Prepare terraform backend on S3:

```
cd launchpad/prepare-s3-backend
terraform init
terraform apply

```
Deploy:

Check for variables variables.tf & modules.tf

```
cd launchpad/us-east-1/launchpad
terraform init
terraform apply

```
