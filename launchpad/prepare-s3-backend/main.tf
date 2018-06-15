# Check Terraform version
terraform {
  required_version = ">= 0.11.7"
}

# Configure the AWS Provider
provider "aws" {
  region           = "${var.aws_region}"
  profile          = "${var.aws_profile}"
}
