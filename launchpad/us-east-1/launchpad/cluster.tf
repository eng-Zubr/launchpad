module "ecs_cluster" {
  source = "../../modules/services/ecs/cluster"
  vpc_id = "${module.vpc.vpc_id}"
  project_name = "${var.project_name}"
  env_name = "${var.env_name}"
  security_group_ids = ["${module.subnets.security_group_local_id}", "${module.subnets.security_group_whitelisted_id}"]
  user_data_script_path = "${path.module}/templates/lc-config.sh"
  conn_key_name = "${module.keypair.key_name}"
  instance_type = "t2.micro"
  volume_size = "12"
  subnets = "${module.subnets.subnets_public}"
  max_size = "1"
  min_size = "1"
  desired_capacity = "1"
}

module "alb" {
  source = "../../modules/services/alb/alb"
  vpc_id = "${module.vpc.vpc_id}"
  domain_cert_arn = "arn:aws:acm:us-east-1:014173831091:certificate/58b10430-08b1-41b0-b0ac-22b108c726fb"
  env_name = "${var.env_name}"
  project_name = "${var.project_name}"
  subnets = "${module.subnets.subnets_public}"
  tg_id = ["${module.dev_frontend_tg.tg_id}", "${module.dev_api_tg.tg_id}"]
}

module "dev_api_tg" {
  source = "../../modules/services/alb/tg"
  vpc_id = "${module.vpc.vpc_id}"
  tg_name = "${var.project_name}-${var.env_name}-api"
  health_check_path = "/api/hello"
  container_port = "80"
  alb_arn = "${module.alb.alb_arn}"
}

module "dev_frontend_tg" {
  source = "../../modules/services/alb/tg"
  vpc_id = "${module.vpc.vpc_id}"
  tg_name = "${var.project_name}-${var.env_name}-frontend"
  health_check_path = "/"
  container_port = "3000"
  alb_arn = "${module.alb.alb_arn}"
}

resource "aws_lb_listener_rule" "host_based_routing_api" {
  listener_arn = "${aws_alb_listener.alb-listener.arn}"
  priority     = 98

  action {
    type             = "forward"
    target_group_arn = "${module.dev_api_tg.tg_arn}"
  }

  condition {
    field  = "host-header"
    values = ["dev-api.be34.me"]
  }
}

module "ecs_td_api" {
  source = "../../modules/services/ecs/td"
  project_name = "${var.project_name}"
  env_name = "${var.env_name}"
  image_url = "${module.ecs_ecr_api.repo_url}"
  task_definition_template_path = "${file("${path.module}/templates/task-definition-api.json")}"
  repo_name = "api"
  aws_region = "${var.aws_region}"
  ENV = "${var.env_name}"
}

module "ecs_td_frontend" {
  source = "../../modules/services/ecs/td"
  project_name = "${var.project_name}"
  env_name = "${var.env_name}"
  image_url = "${module.ecs_ecr_frontend.repo_url}"
  task_definition_template_path = "${file("${path.module}/templates/task-definition-frontend.json")}"
  repo_name = "frontend"
  aws_region = "${var.aws_region}"
  ENV = "${var.env_name}"
}

resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = "${module.alb.alb_arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "arn:aws:acm:us-east-1:014173831091:certificate/58b10430-08b1-41b0-b0ac-22b108c726fb"

  default_action {
    target_group_arn = "${module.dev_frontend_tg.tg_arn}"
    type             = "forward"
  }
  depends_on = ["module.alb"]
}

resource "aws_ecs_service" "ecs_service_api" {
  name            = "${var.project_name}-${var.env_name}-api"
  cluster         = "${module.ecs_cluster.id}"
  task_definition = "${module.ecs_td_api.ecs_td_family}:${max("${module.ecs_td_api.ecs_td_revision}")}"
  desired_count   = 1
  iam_role        = "${module.iam_ecs_service_role.role_name}"
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 200
  health_check_grace_period_seconds = 120

  load_balancer {
    target_group_arn = "${module.dev_api_tg.tg_arn}"
    container_name   = "${var.project_name}-${var.env_name}-api"
    container_port   = "80"
  }
  depends_on = ["module.alb", "module.dev_api_tg", "aws_alb_listener.alb-listener"]
}

resource "aws_ecs_service" "ecs_service_frontend" {
  name            = "${var.project_name}-${var.env_name}-frontend"
  cluster         = "${module.ecs_cluster.id}"
  task_definition = "${module.ecs_td_frontend.ecs_td_family}:${max("${module.ecs_td_frontend.ecs_td_revision}")}"
  desired_count   = 1
  iam_role        = "${module.iam_ecs_service_role.role_name}"
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent = 200
  health_check_grace_period_seconds = 120

  load_balancer {
    target_group_arn = "${module.dev_frontend_tg.tg_arn}"
    container_name   = "${var.project_name}-${var.env_name}-frontend"
    container_port   = "3000"
  }
  depends_on = ["module.alb", "module.dev_frontend_tg", "aws_alb_listener.alb-listener"]
}

module "iam_ecs_service_role" {
  source = "../../modules/services/iam/role"
  env_name = "${var.env_name}"
  project_name = "${var.project_name}"
  iam_role_type = "ecs-service"
}
