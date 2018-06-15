resource "aws_security_group" "OpenWeb" {
  name = "OpenWeb"
  tags {
        Name = "Open web"
  }
  description = "ONLY HTTP(S) CONNECTION INBOUD"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}