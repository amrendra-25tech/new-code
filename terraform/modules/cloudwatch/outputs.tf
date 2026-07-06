output "log_group_name" {
  description = "Name of CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.monitoring.name
}

output "log_group_arn" {
  description = "ARN of CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.monitoring.arn
}
