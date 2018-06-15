# Common vpc modules
# Subnets - Base Subnet

output "subnets_public" {
  value = "${aws_subnet.PublicAZ.*.id}"
}

output "security_group_local_id" {
  value = "${aws_security_group.Local.id}"
}

output "security_group_whitelisted_id" {
  value = "${aws_security_group.Whitelisted.id}"
}
