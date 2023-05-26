# Install Jenkins on Ubuntu 22.04
## On Ubuntu 
- Install Java on ubuntu
- Install Jenkins on Ubuntu
- Install Docker on Ubuntu
- Allow port
  - 8080
  - 8096
  - Open SSH
- `Thêm user jenkins vào group docker` [tại đây](https://www.digitalocean.com/community/tutorials/how-to-set-up-continuous-integration-pipelines-in-jenkins-on-ubuntu-22-04)

## On Jenkins Dashboard
### Install Docker plugin
  - `Doker`
  - `Docker API`
  - `Docker Commons`
  - `Docker Pipeline`
  - `docker-build-step`

### Install AWS plugin
  - `AWS CodePipeline Plugin`
  - `AWS Global Configuration Plugin`
  - `AWS Lambda Cloud plugin`
  - `AWS Secrets Manager Credentials Provider`
  - `AWS Secrets Manager SecretSource`
  - `CloudBees AWS Credentials Plugin`
  - `aws sdk for java`
### Add Credentials
  - `DockerHub`
  - `AWS`
  - `Git`
  
# Terraform folder
- Create `AWS 3 tier` architecture
- Create `DynamoDB` database
- Create `Lambda` function
## RUN 
- B1: Create S3
  - `aws s3api create-bucket --bucket nnhop-terraform-state-bucket --region ap-southeast-1 --create-bucket-configuration LocationConstraint=ap-southeast-1`

- B2: Init
  - `terraform init  -backend-config="region=ap-southeast-1"`

- B3: Apply
  - `terraform apply -lock=false`

- B4: Run Lambda function
  - `aws lambda invoke --function-name example-function lambda/output.json`
  - `aws lambda invoke --function-name example-function-2 lambda/output.json`

- Final: Destroy on Localhost
  - `comment backend`
  - `terraform init -migrate-state `
    - `yes`
  - `terraform destroy -auto-approve`
## root
### variables.tf
- `AWS_region` : ap-southeast-1
- `vpc_cidr_block` : 10.0.0.0/16
- `private_subnet_list` : ["10.0.1.0/24", "10.0.2.0/24"]
- `public_subnet_list` : ["10.0.3.0/24", "10.0.4.0/24"]
- `AZ_list` : ["ap-southeast-1a", "ap-southeast-1b"]
- `table_name` : "example-table"
- `bucket_name` : nnhop-terraform-state-bucket
- `"dynamoDB_state_lock_name"`: "nnhop-terraform-state-lock-table"
### main.tf
- Call 3 module `vpc`, `database`, `lambda` and 
data transmission from `variables.tf` to 3 module
### backend.tf
- Create backend in terraform: `S3 state` and `DynamoDB state lock`
  - First: Create `S3 state` in AWS from CMD
  - Terraform backend region is declared when run `terraform init`
  
## vpc module
### variables.tf
- `vpc_cidr_block` : 10.0.0.0/16
- `private_subnet` : from `private_subnet_list` in `root/variables.tf`
- `public_subnet` : from `public_subnet_list` in `root/variables.tf`
- `availability_zone` : from `AZ_list` in `root/variables.tf`
  
### main.tf
- Create
  - `VPC`
  - `Private_subnet`
  - `Public_subnet`
  - `Internet_gateway`
  - `NAT`
  - `Route_table` 
    - `pubic`
    - `private`
## Lambda module
### variables.tf
- `dynamodb_name` : from `root/main.tf` -> `root/variables.tf`
- `table_name` : from `root/main.tf` -> `root/variables.tf`
###  main.tf
- Create `IAM role`
- Create `IAM Policy` to CRUD item in DynamoDB
  
- Attachment `role` with `policy`
- Create `Lambda function` with `policy`
- Create `Lambda function 2` with `policy`
- Create `Cloudwatch` to trigger `Lambda function 2` every 15 minutes

### lambda_function.py
- Put item to DynamoDB table

### lambda_function_2.py
- Comparison `current_time` with `expires_at` to set `status` of item in DynamoDB table

## database module
### variables.tf
 - `table_name` : from `root/main.tf` -> `root/variables.tf`
### main.tf
- Create `DynamoDB table`

