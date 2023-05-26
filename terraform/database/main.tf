resource "aws_dynamodb_table" "example_table" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "deployment_id"
  attribute {
    name = "deployment_id"
    type = "N"
  }
  global_secondary_index {
    name            = "group_id-index"
    hash_key        = "deployment_id"
    projection_type = "ALL"
  }

  tags = {
    "Name" = "DynamoDB Table"
  }
}
