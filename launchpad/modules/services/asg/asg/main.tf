resource "aws_autoscaling_group" "asg" {
  name                 = "${var.project_name}-${var.env_name}-${var.ecs_ami_id}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  force_delete         = true
  default_cooldown     = 60
  health_check_grace_period = 60
  launch_configuration = "${var.launch_configuration_name}"
  vpc_zone_identifier = ["${var.subnets}"]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.env_name}-${var.ecs_ami_id}"
    propagate_at_launch = "true"
  }
}
