provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "lambda" {
  name = "${var.function_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_lambda_function" "test" {
  filename      = var.zip_path
  function_name = var.function_name
  role          = aws_iam_role.lambda.arn
  handler       = var.handler  # <-- now using variable
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout
  environment {
    variables = var.environment_vars
  }
}

resource "aws_lambda_function_url" "endpoint" {
  function_name      = aws_lambda_function.test.function_name
  authorization_type = "NONE"
}