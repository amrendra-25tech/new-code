# Terraform Remote Backend Configuration
# ==============================================================================
# ARCHITECTURAL NOTE ON STATE LOCKING & DYNAMODB OMISSION:
# ------------------------------------------------------------------------------
# As per project requirements, this backend configuration utilizes Amazon S3 exclusively
# without DynamoDB state locking.
#
# LIMITATIONS OF NOT USING DYNAMODB LOCKING:
# 1. Race Conditions: Multiple concurrent CI/CD pipeline executions or team members running 
#    'terraform apply' simultaneously can lead to race conditions, corrupting state files or
#    creating overlapping resource allocations.
# 2. State Inconsistency: Without distributed locking, two operations can perform write checks
#    at the same time, leading to inconsistent state writes and phantom infrastructure resources.
# 3. Lack of Concurrency Protection: CI/CD jobs must be strictly sequential (concurrency = 1)
#    in Jenkins to prevent parallel modifications.
#
# RECOMMENDATION FOR HIGH-CONCURRENCY PRODUCTION TEAMS:
# Integrate AWS DynamoDB table with a 'LockID' Primary Key (String) to enable automatic state locking.
# ==============================================================================

terraform {
  backend "s3" {
    bucket  = "devops-monitoring-tf-state-bucket"
    key     = "monitoring-infrastructure/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
