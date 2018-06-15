# Common vpc modules
# Subnets - Base Subnet

output "bd_password" {
  value = "${random_string.password.result}"
}

output "bd_user" {
  value = "${aws_db_instance.rds-instance.username}"
}

output "bd_endpoint" {
  value = "${aws_db_instance.rds-instance.endpoint}"
}