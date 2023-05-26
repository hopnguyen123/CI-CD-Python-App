# 1/ Install Jenkins on Ubuntu 22.04
## 1.1 On Ubuntu 
- Install Java on ubuntu
- Install Jenkins on Ubuntu
- Install Docker on Ubuntu
- Allow port
  - 8080
  - 8096
  - Open SSH
- `Thêm user jenkins vào group docker` [tại đây](https://www.digitalocean.com/community/tutorials/how-to-set-up-continuous-integration-pipelines-in-jenkins-on-ubuntu-22-04)

## 1.2 On Jenkins Dashboard
### 1.2.1 Install Docker plugin
  - `Doker`
  - `Docker API`
  - `Docker Commons`
  - `Docker Pipeline`
  - `docker-build-step`

### 1.2.2 Install AWS plugin
  - `AWS CodePipeline Plugin`
  - `AWS Global Configuration Plugin`
  - `AWS Lambda Cloud plugin`
  - `AWS Secrets Manager Credentials Provider`
  - `AWS Secrets Manager SecretSource`
  - `CloudBees AWS Credentials Plugin`
  - `aws sdk for java`
### 1.2.3 Add Credentials
  - `DockerHub`
  - `AWS`
  - `Git`
  
# 2/ Terraform folder
- Create `AWS 3 tier` architecture
- Create `DynamoDB` database
- Create `Lambda` function
## 2.1 RUN 
- B1: Create `S3 State`
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
## 2.2 root
### 2.2.1 variables.tf
- `AWS_region` : ap-southeast-1
- `vpc_cidr_block` : 10.0.0.0/16
- `private_subnet_list` : ["10.0.1.0/24", "10.0.2.0/24"]
- `public_subnet_list` : ["10.0.3.0/24", "10.0.4.0/24"]
- `AZ_list` : ["ap-southeast-1a", "ap-southeast-1b"]
- `table_name` : "example-table"
- `bucket_name` : nnhop-terraform-state-bucket
- `"dynamoDB_state_lock_name"`: "nnhop-terraform-state-lock-table"
### 2.2.2 main.tf
- Call 3 module `vpc`, `database`, `lambda` and 
data transmission from `variables.tf` to 3 module
### 2.2.3 backend.tf
- Create backend in terraform: `S3 state` and `DynamoDB state lock`
  - First: Create `S3 state` in AWS from CMD
  - Terraform backend region is declared when run `terraform init`
  
## 2.3 vpc module
### 2.3.1 variables.tf
- `vpc_cidr_block` : 10.0.0.0/16
- `private_subnet` : from `private_subnet_list` in `root/variables.tf`
- `public_subnet` : from `public_subnet_list` in `root/variables.tf`
- `availability_zone` : from `AZ_list` in `root/variables.tf`
  
### 2.3.2 main.tf
- Create
  - `VPC`
  - `Private_subnet`
  - `Public_subnet`
  - `Internet_gateway`
  - `NAT`
  - `Route_table` 
    - `pubic`
    - `private`
## 2.4 Lambda module
### 2.4.1 variables.tf
- `dynamodb_name` : from `root/main.tf` -> `root/variables.tf`
- `table_name` : from `root/main.tf` -> `root/variables.tf`
### 2.4.2 main.tf
- Create `IAM role`
- Create `IAM Policy` to CRUD item in DynamoDB
  
- Attachment `role` with `policy`
- Create `Lambda function` with `policy`
- Create `Lambda function 2` with `policy`
- Create `Cloudwatch` to trigger `Lambda function 2` every 15 minutes

### 2.4.3 lambda_function.py
- Put item to DynamoDB table

### 2.4.4 lambda_function_2.py
- Comparison `current_time` with `expires_at` to set `status` of item in DynamoDB table

## 2.5 database module
### 2.5.1 variables.tf
 - `table_name` : from `root/main.tf` -> `root/variables.tf`
### 2.5.2 main.tf
- Create `DynamoDB table`

# 3/ python-app
- Contain `python-app` and `jenkinsfile`
## 3.1 app folder
- Contain `python app`
## 3.2 JENKINS folder
- Contain all `jenkinsfile`
- Using `parameters` we can change `params` when run pipeline jenkins
### 3.2.1 build stage
- `jenkinsfile` to checkout code, build images, push image to DockerHub
### 3.2.2 test stage
- `jenkinsfile` to pull image from DockerHub and test image

### 3.2.3 deploy stage
- `jenkinsfile` to push image from DockerHub and Deploy container on localhost:8096

### 3.2.4 test
- `jenkinsfile` 
  - invoke `build`, `test`, `deploy` stage 
  - Send data after deploy to DynamoDB using `jenkins shared library`

# 4/ jenkins-library
## 4.1 vars
### 4.1.1 AWSCredentialsModule.groovy
- Create Credential provider AWS
### 4.1.2 DateUtilsModule.groovy
- Transfer String to format Day expire
### 4.1.3 DynamoDBModule.groovy
- Put item to DynamoDB table AWS

### 4.1.4 hello.groovy
- main file groovy