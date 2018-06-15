# Common Terraform Modules
# VPC

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type = "string"
}

variable "default_tags" {
  description = "Default tag values to be applied to all resources"
  type = "string"
}
