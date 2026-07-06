output "bucket_id" {
  description = "S3 Bucket ID"
  value       = aws_s3_bucket.state_bucket.id
}

output "bucket_arn" {
  description = "S3 Bucket ARN"
  value       = aws_s3_bucket.state_bucket.arn
}
