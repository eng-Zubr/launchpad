module "vpc" {
  source          = "../../modules/services/vpc"
  vpc_cidr_block  = "${var.vpc_cidr}"
  default_tags    = "${var.vpc_name}"
}

module "subnets" {
  source = "../../modules/services/subnets"
  env_name = "${var.env_name}"
  vpc_cidr_block = "${module.vpc.vpc_cidr}"
  vpc_id = "${module.vpc.vpc_id}"
  whitelisted_ip = "${var.whitelisted_ip}"
  private_subnets_enable = "false"
}

module "keypair" {
  source                = "../../modules/services/keypair"
  namespace             = "${var.project_name}"
  stage                 = "${var.env_name}"
  name                  = "key"
  ssh_public_key_path   = "."
  generate_ssh_key      = "true"
  private_key_extension = ".pem"
  public_key_extension  = ".pub"
}

module "ecs_ecr_api" {
  source = "../../modules/services/ecs/ecr"
  project_name = "${var.project_name}"
  repo_name = "api"
  aws_region = "${var.aws_region}"
}

module "ecs_ecr_frontend" {
  source = "../../modules/services/ecs/ecr"
  project_name = "${var.project_name}"
  repo_name = "frontend"
  aws_region = "${var.aws_region}"
}

output "ecs_ami" {
  value = "${module.ecs_cluster.ecs_ami_id}"
}

module "api_dev_dns" {
  source = "../../modules/services/r53"
  record = "${module.alb.alb_endpoint}"
  project_name = "${var.project_name}"
  domain = "be34.me"
  subdomain = "dev-api.be34.me"
  env_name = "${var.project_name}"
}

module "frontend_dev_dns" {
  source = "../../modules/services/r53"
  record = "${module.alb.alb_endpoint}"
  project_name = "${var.project_name}"
  domain = "be34.me"
  subdomain = "app.be34.me"
  env_name = "${var.project_name}"
}
