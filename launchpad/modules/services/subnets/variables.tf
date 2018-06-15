# Common Terraform Modules
# VPC

variable "vpc_id" {
  description = "VPC ID"
  type = "string"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type = "string"
}

variable "env_name" {
  description = "env name"
  type = "string"
}

variable "whitelisted_ip" {
  description = "whitelisted ip"
  type = "string"
}

variable "private_subnets_enable" {
  description = "private subnets enable"
  type = "string"
}
