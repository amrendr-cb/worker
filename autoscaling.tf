// R Service Resources

resource "aws_appautoscaling_target" "scalablegroup_r" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override}/${aws_ecs_service.service_r.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_out_on_high_queue_ratio_r" {
  name               = "${local.appname}-R-scale-out-on-queue-ratio-high"
  resource_id        = "service/${var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override}/${local.appname}-R"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_out_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_out_adjustment
    }
  }

  depends_on = [aws_appautoscaling_target.scalablegroup_r]
}

resource "aws_cloudwatch_metric_alarm" "high_message_worker_ratio_r" {
  alarm_actions             = [aws_appautoscaling_policy.scale_out_on_high_queue_ratio_r.arn]
  alarm_name                = "${local.appname}-R-high-message-worker-ratio"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  threshold                 = var.high_ratio_threshold
  alarm_description         = "When the message in queue to worker R ratio is above ${var.high_ratio_threshold}, trigger"
  insufficient_data_actions = []

  metric_query {
    id          = "e1"
    expression  = "m1/m2"
    label       = "Ratio of Messages in Queue to Running Tasks R"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "false"
    metric {
      metric_name = "ApproximateNumberOfMessagesVisible"
      namespace   = "AWS/SQS"
      period      = "60"
      stat        = "Average"

      dimensions = {
        QueueName = (local.fifo_queue ? "${local.appname}-queue.fifo" : "${local.appname}-queue")
      }
    }
  }

  metric_query {
    id          = "m2"
    return_data = "false"
   
    metric {
      metric_name = "CPUUtilization"
      namespace   = "AWS/ECS"
      period      = "60"
      stat        = "SampleCount"
      //unit        = "Seconds"

      dimensions = {
        ClusterName = var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override
        ServiceName = "${local.appname}-R"
      }
    }
  }
}

resource "aws_appautoscaling_policy" "scale_in_on_low_queue_ratio_r" {
  name               = "${local.appname}-R-scale-in-on-queue-ratio-low"
  resource_id        = "service/${var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override}/${local.appname}-R"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_in_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = var.scale_in_adjustment
    }
  }

  depends_on = [aws_appautoscaling_target.scalablegroup_r]
}

resource "aws_cloudwatch_metric_alarm" "low_message_worker_ratio_r" {
  alarm_actions             = [aws_appautoscaling_policy.scale_in_on_low_queue_ratio_r.arn]
  alarm_name                = "${local.appname}-R-low-message-worker-ratio"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "1"
  threshold                 = var.low_ratio_threshold
  alarm_description         = "When the message in queue to worker R ratio is below ${var.low_ratio_threshold}, trigger"
  insufficient_data_actions = []

  metric_query {
    id          = "e1"
    expression  = "m1/m2"
    label       = "Ratio of Messages in Queue to Running Tasks R"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "false"
    metric {
      metric_name = "ApproximateNumberOfMessagesVisible"
      namespace   = "AWS/SQS"
      period      = "60"
      stat        = "Average"

      dimensions = {
        QueueName = (local.fifo_queue ? "${local.appname}-queue.fifo" : "${local.appname}-queue")
      }
    }
  }

  metric_query {
      id          = "m2"
      return_data = "false"
    
      metric {
        metric_name = "CPUUtilization"
        namespace   = "AWS/ECS"
        period      = "60"
        stat        = "SampleCount"

        dimensions = {
          ClusterName = var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override
          ServiceName = "${local.appname}-R"
        }
      }
    }
}
// G service resources

resource "aws_appautoscaling_target" "scalablegroup_g" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override}/${aws_ecs_service.service_g.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_out_on_high_queue_ratio_g" {
  name               = "${local.appname}-G-scale-out-on-queue-ratio-high"
  resource_id        = "service/${var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override}/${local.appname}-G"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_out_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_out_adjustment
    }
  }

  depends_on = [aws_appautoscaling_target.scalablegroup_g]
}

resource "aws_cloudwatch_metric_alarm" "high_message_worker_ratio_g" {
  alarm_actions             = [aws_appautoscaling_policy.scale_out_on_high_queue_ratio_g.arn]
  alarm_name                = "${local.appname}-G-high-message-worker-ratio"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  threshold                 = var.high_ratio_threshold
  alarm_description         = "When the message in queue to worker G ratio is above ${var.high_ratio_threshold}, trigger"
  insufficient_data_actions = []

  metric_query {
    id          = "e1"
    expression  = "m1/m2"
    label       = "Ratio of Messages in Queue to Running Tasks G"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "false"
    metric {
      metric_name = "ApproximateNumberOfMessagesVisible"
      namespace   = "AWS/SQS"
      period      = "60"
      stat        = "Average"

      dimensions = {
        QueueName = (local.fifo_queue ? "${local.appname}-queue.fifo" : "${local.appname}-queue")
      }
    }
  }

  metric_query {
    id          = "m2"
    return_data = "false"
   
    metric {
      metric_name = "CPUUtilization"
      namespace   = "AWS/ECS"
      period      = "60"
      stat        = "SampleCount"

      dimensions = {
        ClusterName = var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override
        ServiceName = "${local.appname}-G"
      }
    }
  }
}

resource "aws_appautoscaling_policy" "scale_in_on_low_queue_ratio_g" {
  name               = "${local.appname}-G-scale-in-on-queue-ratio-low"
  resource_id        = "service/${var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override}/${local.appname}-G"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_out_cooldown
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = var.scale_in_adjustment
    }
  }

  depends_on = [aws_appautoscaling_target.scalablegroup_g]
}

resource "aws_cloudwatch_metric_alarm" "low_message_worker_ratio_g" {
  alarm_actions             = [aws_appautoscaling_policy.scale_in_on_low_queue_ratio_g.arn]
  alarm_name                = "${local.appname}-G-low-message-worker-ratio"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "1"
  threshold                 = var.low_ratio_threshold
  alarm_description         = "When the message in queue to worker G ratio is below ${var.low_ratio_threshold}}, trigger"
  insufficient_data_actions = []

  metric_query {
    id          = "e1"
    expression  = "m1/m2"
    label       = "Ratio of Messages in Queue to Running Tasks G"
    return_data = "true"
  }

  metric_query {
    id          = "m1"
    return_data = "false"
    metric {
      metric_name = "ApproximateNumberOfMessagesVisible"
      namespace   = "AWS/SQS"
      period      = "60"
      stat        = "Average"

      dimensions = {
        QueueName = (local.fifo_queue ? "${local.appname}-queue.fifo" : "${local.appname}-queue")
      }
    }
  }

  metric_query {
    id          = "m2"
    return_data = "false"
   
    metric {
      metric_name = "CPUUtilization"
      namespace   = "AWS/ECS"
      period      = "60"
      stat        = "SampleCount"

      dimensions = {
        ClusterName = var.cluster_override == "" ? module.environment_info.cluster : var.cluster_override
        ServiceName = "${local.appname}-G"
      }
    }
  }
}
