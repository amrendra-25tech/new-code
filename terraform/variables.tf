# Global Project Variables

variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (dev, stage, prod)"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name tag and naming prefix"
  type        = string
  default     = "enterprise-monitoring"
}

# VPC Variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnet allocation"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# EC2 Instance Variables
variable "bastion_instance_type" {
  description = "EC2 instance type for the Bastion host"
  type        = string
  default     = "t3.micro"
}

variable "monitoring_instance_type" {
  description = "EC2 instance type for the Monitoring server"
  type        = string
  default     = "t3.medium"
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair to create/use"
  type        = string
  default     = "monitoring-ec2-key"
}

variable "allowed_ssh_cidr" {
  description = "Allowed CIDR range for Bastion SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
