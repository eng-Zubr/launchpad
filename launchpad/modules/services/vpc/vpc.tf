######
# VPC
######
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = "${map("Name", format("%s", var.default_tags))}"
}
