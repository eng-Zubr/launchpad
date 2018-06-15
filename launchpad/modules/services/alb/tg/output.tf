output "tg_id" {
  value = "${aws_alb_target_group.tg.id}"
}

output "tg_arn" {
  value = "${aws_alb_target_group.tg.arn}"
}
