data "aws_ecs_task_definition" "task_definition" {
  task_definition = "${var.task_definition_arn}"
}

data "aws_alb" "alb" {
  arn = "${var.alb_arn}"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.project_name}-${var.env_name}-${var.repo_name}"
  cluster         = "${var.cluster_id}"
  task_definition = "${data.aws_ecs_task_definition.task_definition.family}:${max("${data.aws_ecs_task_definition.task_definition.revision}")}"
  desired_count   = 1
  iam_role        = "${module.iam_ecs_service_role.role_name}"
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 200
  health_check_grace_period_seconds = 120

  load_balancer {
    target_group_arn = "${var.alb_tg_arn}"
    container_name   = "${var.project_name}-${var.env_name}-${var.repo_name}"
    container_port   = "80"
  }

  depends_on = ["data.aws_alb.alb"]
}

module "iam_ecs_service_role" {
  source = "../../iam/role"
  env_name = "${var.env_name}"
  project_name = "${var.project_name}"
  iam_role_type = "ecs-service"
}
