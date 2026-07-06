variable "key_name" {
  description = "Name of the SSH Key Pair"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
