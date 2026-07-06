# Root Module Outputs

output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.subnet.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.subnet.private_subnet_ids
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = module.bastion_ec2.public_ip
}

output "monitoring_private_ip" {
  description = "Private IP of the Monitoring Server"
  value       = module.monitoring_ec2.private_ip
}

output "grafana_url" {
  description = "URL to access Grafana (via SSH Tunnel or Port Forwarding)"
  value       = "http://${module.monitoring_ec2.private_ip}:3000"
}

output "prometheus_url" {
  description = "URL to access Prometheus (via SSH Tunnel or Port Forwarding)"
  value       = "http://${module.monitoring_ec2.private_ip}:9090"
}

output "ssh_bastion_command" {
  description = "SSH Command to connect to Bastion Host"
  value       = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ubuntu@${module.bastion_ec2.public_ip}"
}

output "ssh_monitoring_command" {
  description = "SSH Tunnel Command to reach Monitoring Host via Bastion"
  value       = "ssh -J ubuntu@${module.bastion_ec2.public_ip} ubuntu@${module.monitoring_ec2.private_ip}"
}
