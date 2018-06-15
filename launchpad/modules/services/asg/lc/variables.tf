variable "vpc_id" {
  description = "VPC ID"
  type = "string"
}

variable "project_name" {
  description = "env name"
  type = "string"
}

variable "cluster_name" {
  description = "cluster name"
  type = "string"
}

variable "env_name" {
  description = "env name"
  type = "string"
}

variable "ecs_ami_id" {
  description = "ecs ami id"
  type = "string"
}

variable "instance_type" {
  description = "instance type"
  type = "string"
}

variable "conn_key_name" {
  description = "conn key name"
  type = "string"
}

variable "user_data_script_path" {
  description = "user data script path"
  type = "string"
}

variable "volume_size" {
  description = "volume size"
  type = "string"
}

variable "security_group_ids" {
  description = "security_group_ids"
  type = "list"
}
