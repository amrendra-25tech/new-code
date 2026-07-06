output "bastion_security_group_id" {
  description = "Security Group ID of the Bastion host"
  value       = aws_security_group.bastion.id
}

output "monitoring_security_group_id" {
  description = "Security Group ID of the Monitoring host"
  value       = aws_security_group.monitoring.id
}
