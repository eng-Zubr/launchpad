variable "aws_region" {
  description = "AWS region"
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

variable "task_definition_template_path" {
  description = "task definition template path"
  type = "string"
}

variable "image_url" {
  description = "image url"
  type = "string"
}

variable "repo_name" {
  description = "repo name"
  type = "string"
}

variable "ENV" {
  description = "ENV"
  type = "string"
}
