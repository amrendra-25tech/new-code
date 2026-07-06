# Terraform VPC Module

This module provisions an Amazon Virtual Private Cloud (VPC) with configurable DNS support and custom tagging.

## Usage
```hcl
module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  name_prefix  = "enterprise-monitoring-prod"
  tags         = local.common_tags
}
```
