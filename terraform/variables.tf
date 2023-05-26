variable "AWS_region" {
  default     = "ap-southeast-1"
  description = "Aws Region"

  type = string
}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"

  type = string
}

variable "private_subnet_list" {
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "Private subnet List"

  type = list(string)
}

variable "public_subnet_list" {
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  description = "Public subnet list"

  type = list(string)
}

variable "AZ_list" {
  default     = ["ap-southeast-1a", "ap-southeast-1b"]
  description = "Availability Zone list"

  type = list(string)
}

variable "table_name" {
  default     = "example-table"
  description = "Table Name: example-table"

  type = string
}

variable "bucket_name" {
  default     = "nnhop-terraform-state-bucket"
  description = "Bucket name of S3 state"

  type = string
}

variable "dynamoDB_state_lock_name" {
  default     = "nnhop-terraform-state-lock-table"
  description = "DynamoDB state lock name"

  type = string
}
