data "aws_alb" "alb" {
  arn = "${var.alb_arn}"
}

resource "aws_alb_target_group" "tg" {
  name     = "${var.tg_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  deregistration_delay = 60
  health_check {
     healthy_threshold = 2
     unhealthy_threshold = 5
     timeout = 3
     path = "${var.health_check_path}"
     interval = 20
     matcher = "200"
    }
  depends_on = ["data.aws_alb.alb"]
}
