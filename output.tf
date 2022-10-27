output "ecs-task-role" {
  value = "${var.team}-${var.application}-${var.environment}-task"
}

output "scaleout_r" {
  value = aws_appautoscaling_policy.scale_out_on_high_queue_ratio_r.arn 
}

output "scalein_r" {
  value = aws_appautoscaling_policy.scale_in_on_low_queue_ratio_r.arn  
}

output "scaleout_g" {
  value = aws_appautoscaling_policy.scale_out_on_high_queue_ratio_g.arn
}

output "scalein_g" {
  value = aws_appautoscaling_policy.scale_in_on_low_queue_ratio_g.arn
}
