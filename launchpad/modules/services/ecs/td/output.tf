output "ecs_td_arn" {
  value = "${aws_ecs_task_definition.ecs_td.arn}"
}

output "ecs_td_family" {
  value = "${aws_ecs_task_definition.ecs_td.family}"
}

output "ecs_td_revision" {
  value = "${aws_ecs_task_definition.ecs_td.revision}"
}
