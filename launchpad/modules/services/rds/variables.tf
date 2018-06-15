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

variable "identifier" {
  description = "Identifier for your DB"
}

variable "storage" {
  description = "Storage size in GB"
}

variable "engine" {
  default     = "postgres"
  description = "Engine type, example values mysql, postgres"
}

variable "instance_class" {
  default     = "db.t2.micro"
  description = "Instance class"
}

variable "db_name" {
  default     = "some_dev"
  description = "db name"
}

variable "username" {
  default     = "some_db_user"
  description = "User name"
}

variable "security_group_whitelisted_id" {
  default     = "security group whitelisted ips id"
  description = "User name"
}

variable "subnets" {
  type        = "list"
  description = "A list of VPC subnet IDs"
}
