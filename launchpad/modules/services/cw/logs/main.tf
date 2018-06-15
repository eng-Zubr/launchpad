resource "aws_cloudwatch_log_group" "cw_log_stream" {
  name = "${var.log_stream_name}"
  retention_in_days = 90
}
