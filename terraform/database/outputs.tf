output "DynamoDB_name" {
  value       = aws_dynamodb_table.example_table.name
  description = "Output DynamoDB_name of database module"
}

output "DynamoDB_arn" {
  value       = aws_dynamodb_table.example_table.arn
  description = "Output DynamoDB_arn of database module"
}
