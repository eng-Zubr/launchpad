locals {
  ssm_list = "${split("\"", data.aws_ssm_parameter.ecs_ami.value)}"
  ami_id = "${local.ssm_list[9]}"
}

output "ecs_ami_id" {
  value = "${local.ami_id}"
}

output "id" {
  value = "${aws_ecs_cluster.cluster.id}"
}
