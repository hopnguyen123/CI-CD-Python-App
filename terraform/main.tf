
# Terraform block    
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.45.0"
    }
  }
}

# Provider       
provider "aws" {
  region = var.AWS_region
}

# Module VPC      
module "vpc" {
  source = "./vpc"

  vpc_cidr_block    = var.vpc_cidr_block
  private_subnet    = var.private_subnet_list
  public_subnet     = var.public_subnet_list
  availability_zone = var.AZ_list
}

# Module Database
module "database" {
  source     = "./database"
  table_name = var.table_name
}

# Lambda modules
module "lambda" {
  source        = "./lambda"
  table_name    = var.table_name
  dynamodb_name = module.database.DynamoDB_name
}
