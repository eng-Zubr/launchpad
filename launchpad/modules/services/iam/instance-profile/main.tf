resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.project_name}-${var.env_name}-instance-profile"
  role = "${var.iam_role_name}"
}
