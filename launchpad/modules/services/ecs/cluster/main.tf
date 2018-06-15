resource "aws_ecs_cluster" "cluster" {
  name = "${var.project_name}-${var.env_name}"
}

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux/recommended"
}

module "asg-lc" {
  source = "../../asg/lc"
  volume_size = "${var.volume_size}"
  vpc_id = "${var.vpc_id}"
  env_name = "${var.env_name}"
  project_name = "${var.project_name}"
  conn_key_name = "${var.conn_key_name}"
  ecs_ami_id = "${local.ami_id}"
  instance_type = "${var.instance_type}"
  security_group_ids = "${var.security_group_ids}"
  user_data_script_path = "${var.user_data_script_path}"
  cluster_name = "${aws_ecs_cluster.cluster.name}"
}

module "asg-asg" {
  source = "../../asg/asg"
  vpc_id = "${var.vpc_id}"
  env_name = "${var.env_name}"
  project_name = "${var.project_name}"
  ecs_ami_id = "${local.ami_id}"
  security_group_ids = "${var.security_group_ids}"
  launch_configuration_name = "${module.asg-lc.launch-configuration-name}"
  subnets = "${var.subnets}"
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"
}
