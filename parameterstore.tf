resource "aws_ssm_parameter" "queue_url" {
    name      = "/${var.team}/${var.application}/${var.environment}/${upper(replace(var.startCommand, "start:",""))}_QUEUE_URL"
    overwrite = true
    type      = "String"
    value     = aws_sqs_queue.queue.id
}