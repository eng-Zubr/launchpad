variable "vpc_id" {
  description = "VPC ID"
  type = "string"
}

variable "tg_name" {
  type        = "string"
  description = "tg name"
}

variable "container_port" {
  type        = "string"
  description = "container_port"
}

variable "health_check_path" {
  type        = "string"
  description = "health check path"
}

variable "alb_arn" {
  type        = "string"
  description = "alb arn"
}
