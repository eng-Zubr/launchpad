variable "vpc_id" {
  description = "VPC ID"
  type = "string"
}

variable "cluster_id" {
  description = "cluster id"
  type = "string"
}

variable "task_definition_arn" {
  description = "task definition arn"
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

variable "repo_name" {
  description = "repo name"
  type = "string"
}

variable "subnets" {
  type        = "list"
  description = "A list of VPC subnet IDs"
}

variable "alb_tg_arn" {
  description = "alb tg arn"
  type = "string"
}

variable "alb_arn" {
  type = "string"
  description = "alb arn"
}
