resource "aws_security_group" "Local" {
  vpc_id = "${var.vpc_id}"
  name = "Local"
  tags {
        Name = "Local"
  }
  description = "local VPC trafic"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "Whitelisted" {
  name = "Whitelisted"
  tags {
        Name = "Whitelisted IPs"
  }
  description = "Whitelisted IPs"
  vpc_id = "${var.vpc_id}"
  ingress {
      from_port   = "22"
      to_port     = "22"
      protocol    = "TCP"
      cidr_blocks = ["${var.whitelisted_ip}"]
  }
  ingress {
      from_port   = "5432"
      to_port     = "5432"
      protocol    = "TCP"
      cidr_blocks = ["${var.whitelisted_ip}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
