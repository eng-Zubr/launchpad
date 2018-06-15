resource "aws_alb" "alb" {
  name            = "${var.project_name}-${var.env_name}-api"
  subnets         = ["${var.subnets}"]
  security_groups = ["${aws_security_group.OpenWeb.id}"]
  internal = false
}
