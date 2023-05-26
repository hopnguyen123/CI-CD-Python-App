# S3 State     
## S3 BUCKET
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "nnhop-terraform-state-bucket"

#   lifecycle {
#     prevent_destroy = true #false
#   }

#   tags = {
#     Name = "S3 bucket state"
#   }
# }

## S3 ACL 
resource "aws_s3_bucket_ownership_controls" "terraform_state" {
  bucket = var.bucket_name
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "terraform_state" {
  depends_on = [aws_s3_bucket_ownership_controls.terraform_state]

  bucket = var.bucket_name
  acl    = "private"
}

## S3 Versioning - Enable
resource "aws_s3_bucket_versioning" "versioning_terraform_state" {
  bucket = var.bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}
## KMS KEY
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 7

  tags = {
    "Name" = "AWS KMS Key"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = var.bucket_name

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }

}

# DynamoDB state lock      
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = var.dynamoDB_state_lock_name
  billing_mode   = "PROVISIONED"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "Name" = "AWS DynamoDB Table state lock"
  }
}

# Terraform block  
terraform {
  backend "s3" {
    bucket = "nnhop-terraform-state-bucket"
    key    = "terraform.tfstate"
    # region = "ap-southeast-1"
    dynamodb_table = "nnhop-terraform-state-lock-table"
    encrypt        = true
  }
}
