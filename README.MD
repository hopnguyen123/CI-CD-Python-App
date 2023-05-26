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