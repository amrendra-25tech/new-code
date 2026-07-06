variable "instance_name" {
  description = "Name identifier for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Specific AMI ID, if left empty Ubuntu 24.04 LTS will be dynamically queried"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet ID to launch instance in"
  type        = string
}

variable "key_name" {
  description = "SSH Key Pair name"
  type        = string
}

variable "security_group_ids" {
  description = "List of Security Group IDs"
  type        = list(string)
}

variable "associate_public_ip" {
  description = "Associate public IP address"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
  default     = null
}

variable "volume_size" {
  description = "Root disk volume size in GB"
  type        = number
  default     = 20
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
