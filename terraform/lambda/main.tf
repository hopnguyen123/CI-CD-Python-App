# Lambda Role
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    "Name" = "AWS Iam Role"
  }
}

resource "aws_iam_policy" "dynamodb_policy" {
  name = "dynamodb-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query",
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })

  tags = {
    "Name" = "AWS Iam Policy"
  }
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
  policy_arn = aws_iam_policy.dynamodb_policy.arn
  role       = aws_iam_role.lambda_role.name
}

#Create the Lambda function and associate it with the IAM role
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

data "archive_file" "lambda_zip_2" {
  type        = "zip"
  source_file = "${path.module}/lambda_function_2.py"
  output_path = "${path.module}/lambda_function_2.zip"
}

resource "aws_lambda_function" "example_function" {
  function_name    = "example-function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      DATABASE_NAME = var.dynamodb_name
    }
  }

  tags = {
    "Name" = "AWS Lambda function"
  }
}

resource "aws_lambda_function" "example_function_2" {
  function_name    = "example-function-2"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function_2.lambda_handler"
  runtime          = "python3.9"
  filename         = data.archive_file.lambda_zip_2.output_path
  source_code_hash = data.archive_file.lambda_zip_2.output_base64sha256

  environment {
    variables = {
      DATABASE_NAME = var.dynamodb_name
    }
  }

  tags = {
    "Name" = "AWS Lambda function"
  }
}

# Run every 15p - Cloudwatch event
resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "lambda-schedule"
  description         = "Schedule for Lambda function"
  schedule_expression = "cron(0/15 * * * ? *)"

  tags = {
    "Name" = "AWS Cloudwatch event rule"
  }
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.schedule.name
  arn       = aws_lambda_function.example_function_2.arn
  target_id = "example-lambda"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example_function_2.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule.arn
}
