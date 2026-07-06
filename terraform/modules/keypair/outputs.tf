output "key_name" {
  description = "SSH Key Name"
  value       = aws_key_pair.this.key_name
}

output "private_key_pem" {
  description = "Private key content in PEM format"
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
}
