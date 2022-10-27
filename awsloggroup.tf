resource "aws_cloudwatch_log_group" "logging" {
  name              = "/ecs/${var.team}/${var.shortApplication}/${var.environment}/${var.resourceName}"
}
