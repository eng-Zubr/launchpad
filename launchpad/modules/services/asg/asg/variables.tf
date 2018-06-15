variable "vpc_id" {
  description = "VPC ID"
  type = "string"
}

variable "project_name" {
  description = "env name"
  type = "string"
}

variable "env_name" {
  description = "env name"
  type = "string"
}

variable "security_group_ids" {
  description = "security_group_ids"
  type = "list"
}

variable "subnets" {
  type        = "list"
  description = "A list of VPC subnet IDs"
#  default     = []
}

variable "ecs_ami_id" {
  description = "ecs ami id"
  type = "string"
}

variable "launch_configuration_name" {
  description = "launch configuration name"
  type = "string"
}

variable "max_size" {
  description = "max asg size"
  type = "string"
}

variable "min_size" {
  description = "min asg size"
  type = "string"
}

variable "desired_capacity" {
  description = "desired asg capacity"
  type = "string"
}
