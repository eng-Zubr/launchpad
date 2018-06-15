data "aws_route53_zone" "zone" {
  name       = "${var.domain}"
}

resource "aws_route53_record" "dev" {
  name      = "${var.subdomain}"
  zone_id   = "${data.aws_route53_zone.zone.id}"
  type      = "CNAME"
  ttl       = "180"
  records   = ["${var.record}"]
}
