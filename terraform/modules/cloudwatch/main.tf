resource "aws_cloudwatch_log_group" "monitoring" {
  name              = "/aws/ec2/${var.name_prefix}-monitoring-logs"
  retention_in_days = var.log_retention_days

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-cloudwatch-log-group"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.name_prefix}-high-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 high cpu utilization"

  dimensions = {
    InstanceId = var.monitoring_instance_id
  }

  tags = var.tags
}
