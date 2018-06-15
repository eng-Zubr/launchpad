resource "aws_db_instance" "rds-instance" {
  depends_on             = ["aws_security_group.Database"]
  identifier             = "${var.identifier}"
  allocated_storage      = "${var.storage}"
  storage_type           = "gp2"
  engine                 = "${var.engine}"
#  engine_version         = "${lookup(var.engine_version, var.engine)}" #latest stable
  instance_class         = "${var.instance_class}"
  name                   = "${var.db_name}"
  username               = "${var.username}"
  password               = "${random_string.password.result}"
  vpc_security_group_ids = ["${aws_security_group.Database.id}", "${var.security_group_whitelisted_id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.default.id}"
  publicly_accessible    = "true"
  port                   = 5432
  backup_retention_period = 30
  skip_final_snapshot = "true"
}


resource "aws_db_subnet_group" "default" {
  name        = "${var.project_name}-rds-${var.identifier}"
  description = "${var.identifier} group of subnets"
  subnet_ids = ["${var.subnets}"]
  lifecycle {
    create_before_destroy = true
  }
}
