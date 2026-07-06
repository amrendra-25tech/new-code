output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "eip_public_ip" {
  description = "Public IP associated with Elastic IP"
  value       = aws_eip.nat.public_ip
}
