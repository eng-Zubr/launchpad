data "template_file" "lc_config" {
  template = "${file(var.user_data_script_path)}"
  vars {
    cluster_name = "${var.cluster_name}"
  }
}

module "iam" {
  source = "../../iam/role"
  env_name = "${var.env_name}"
  project_name = "${var.project_name}"
  iam_role_type = "ec2"
}

module "instance_profile" {
  source = "../../iam/instance-profile"
  env_name = "${var.env_name}"
  project_name = "${var.project_name}"
  iam_role_name = "${module.iam.role_name}"
}

resource "aws_launch_configuration" "cluster-launch-configuration" {
  security_groups = ["${var.security_group_ids}"]

  name = "${var.cluster_name}-${var.ecs_ami_id}"

  key_name                    = "${var.conn_key_name}"
  image_id                    = "${var.ecs_ami_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${module.instance_profile.instance_profile_name}"
  user_data                   = "${data.template_file.lc_config.rendered}"
  associate_public_ip_address = true
  root_block_device {
    volume_size = "${var.volume_size}"
    }

  lifecycle {
    create_before_destroy = true
  }
}





