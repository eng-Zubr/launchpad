# Declare the data source
data "aws_availability_zones" "available" {}

resource "aws_subnet" "PublicAZ" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${var.vpc_id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr_block, 8, count.index + 1)}"
  tags {
        Name = "${var.env_name}-public-${data.aws_availability_zones.available.names[count.index]}"
  }
 availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
}

resource "aws_subnet" "PrivateAZ" {
  count = "${var.private_subnets_enable == "true" ? length(data.aws_availability_zones.available.names):0}"
  vpc_id = "${var.vpc_id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr_block, 8, aws_subnet.PublicAZ.count + count.index + 1)}"
  tags {
        Name = "${var.env_name}-private-${data.aws_availability_zones.available.names[count.index]}"
  }
 availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
}


resource "aws_route_table_association" "PublicAZA" {
    count = "${aws_subnet.PublicAZ.count}"
    subnet_id = "${element(aws_subnet.PublicAZ.*.id, count.index)}"
    route_table_id = "${aws_route_table.public.id}"
}

resource "aws_network_acl" "all" {
   vpc_id = "${var.vpc_id}"
    egress {
        protocol = "-1"
        rule_no = 2
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block =  "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    tags {
        Name = "open acl"
    }
}
resource "aws_route_table" "public" {
  vpc_id = "${var.vpc_id}"
  tags {
      Name = "Public"
  }
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }
}
