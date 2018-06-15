#==============================================================
# Database / ssm-parameters.tf
#==============================================================
resource "aws_ssm_parameter" "rds_db_name" {
  name      = "/${var.project_name}/${var.env_name}/rds/${aws_db_instance.rds-instance.identifier}/db-name"
  value     = "${var.db_name}"
  type      = "String"
  overwrite = "true"
}

resource "aws_ssm_parameter" "rds_admin_username" {
  name      = "/${var.project_name}/${var.env_name}/rds/${aws_db_instance.rds-instance.identifier}/admin-username"
  value     = "${aws_db_instance.rds-instance.username}"
  type      = "String"
  overwrite = "true"
}

resource "aws_ssm_parameter" "rds_admin_password" {
  name      = "/${var.project_name}/${var.env_name}/rds/${aws_db_instance.rds-instance.identifier}/admin-password"
  value     = "${random_string.password.result}"
  type      = "SecureString"
  overwrite = "true"
}

resource "aws_ssm_parameter" "rds_host" {
  name      = "/${var.project_name}/${var.env_name}/rds/${aws_db_instance.rds-instance.identifier}/host"
  value     = "${aws_db_instance.rds-instance.endpoint}"
  type      = "String"
  overwrite = "true"
}
