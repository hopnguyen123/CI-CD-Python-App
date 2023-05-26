output "dynamodb_arn" {
  value       = module.database.DynamoDB_arn
  description = "DynamoDB arn of module database"
}
output "dynamodb_name" {
  value       = module.database.DynamoDB_name
  description = "DynamoDB name of module database"
}
