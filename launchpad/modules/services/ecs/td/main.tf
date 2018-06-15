data "template_file" "task_definition" {
  template = "${var.task_definition_template_path}"

  vars {
    image_url        = "${var.image_url}:latest"
    container_name   = "${var.project_name}-${var.env_name}-${var.repo_name}"
    log_group_region = "${var.aws_region}"
    log_group_name   = "${var.project_name}-${var.env_name}-${var.repo_name}"
    ENV = "${var.ENV}"
  }
}

resource "aws_ecs_task_definition" "ecs_td" {
  family                = "${var.project_name}-${var.env_name}-${var.repo_name}"
  container_definitions = "${data.template_file.task_definition.rendered}"
}

module "cw_log_stream" {
  source = "../../cw/logs"
  log_stream_name = "${var.project_name}-${var.env_name}-${var.repo_name}"
}
