output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the created public subnets"
  value       = aws_subnet.public_subnet.*.id
}

output "private_subnet_ids" {
  description = "The IDs of the created private subnets"
  value       = aws_subnet.private_subnet.*.id
}
