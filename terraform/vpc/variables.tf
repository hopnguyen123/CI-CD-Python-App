variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR BLOCK"
}

variable "private_subnet" {
  type        = list(string)
  description = "Private Subnet List"
}

variable "public_subnet" {
  type        = list(string)
  description = "Public Subnet List"
}

variable "availability_zone" {
  type        = list(string)
  description = "Availability Zone List"
}
