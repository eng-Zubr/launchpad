output "alb_endpoint" {
  value = "${aws_alb.alb.dns_name}"
}

output "alb_arn" {
  value = "${aws_alb.alb.arn}"
}
