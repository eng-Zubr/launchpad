# Common values

variable "aws_region" {
  default = "us-east-1"
  description = "AWS region"
}

variable "aws_profile" {
  default = "default"                  #use default if have only one
  description = "AWS region"
}

variable "project_name" {
  default = "launchpad"
  description = "Some project name - lowercase"
}

variable "env_name" {
  default = "dev"
  description = "env name"
}

variable "vpc_name" {
  default = "launchpad-testing"
  description = "Some VPCs names" #single vpc at this stage
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
  description = "10.20.0.0/16" #single vpc at this stage
}

variable "whitelisted_ip" {
  default = "0.0.0.0/0"
  description = "whitelisted ip"
}
