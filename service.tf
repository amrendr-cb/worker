
resource "aws_ecs_service" "service_g" {
  cluster                            = var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  desired_count                      = var.min_capacity
  name                               = "${var.team}-${var.shortApplication}-${var.resourceName}-${var.environment}-G"
  task_definition                    = aws_ecs_task_definition.taskdefinition.arn

  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
}

resource "aws_ecs_service" "service_r" {
  cluster                            = var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  desired_count                      = var.min_capacity
  name                               = "${var.team}-${var.shortApplication}-${var.resourceName}-${var.environment}-R"
  task_definition                    = aws_ecs_task_definition.taskdefinition.arn

  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
}

resource "aws_ecs_task_definition" "taskdefinition" {
  container_definitions = templatefile("${var.task_definition_file}", {})
  family                = "${var.team}-${var.shortApplication}-${var.resourceName}-${var.environment}"
  task_role_arn         = aws_iam_role.task_role.arn

  lifecycle {
    create_before_destroy = true
    ignore_changes        = all
  }
}
