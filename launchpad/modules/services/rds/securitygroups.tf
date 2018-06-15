resource "aws_security_group" "Database" {
  name = "Database-${var.identifier}"
  tags {
        Name = "Database_staging"
  }
  description = "ONLY tcp CONNECTION INBOUND"
  vpc_id = "${var.vpc_id}"
  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
