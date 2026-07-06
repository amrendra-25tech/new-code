variable "public_subnet_id" {
  description = "Public subnet ID where NAT gateway reside"
  type        = string
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
