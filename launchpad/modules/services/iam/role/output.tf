output "role_name" {
  value = "${aws_iam_role.iam_role.name}"
}

output "role_policy" {
  value = "${aws_iam_role_policy.role_policy.name}"
}
