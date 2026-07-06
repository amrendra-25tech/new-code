output "instance_profile_name" {
  description = "IAM Instance Profile Name"
  value       = aws_iam_instance_profile.this.name
}

output "role_arn" {
  description = "IAM Role ARN"
  value       = aws_iam_role.ec2_monitoring.arn
}
