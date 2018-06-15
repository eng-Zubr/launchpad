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

variable "user_data_script_path" {
  description = "user data script path"
  type = "string"
}

variable "security_group_ids" {
  description = "security_group_ids"
  type = "list"
}

variable "conn_key_name" {
  description = "conn key name"
  type = "string"
}

variable "volume_size" {
  description = "root volume size"
  type = "string"
}

variable "instance_type" {
  description = "instance type"
  type = "string"
}

variable "subnets" {
  type        = "list"
  description = "A list of VPC subnet IDs"
#  default     = []
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
