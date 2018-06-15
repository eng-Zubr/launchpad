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

variable "subnets" {
  type        = "list"
  description = "A list of VPC subnet IDs"
}

variable "domain_cert_arn" {
  type        = "string"
  description = "domain cert arn"
}

variable "tg_id" {
  type        = "list"
  description = "tg ids"
}
