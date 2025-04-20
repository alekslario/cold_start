output "url" {
  value = aws_lambda_function_url.endpoint.function_url
}

output "function_arn" {
  value = aws_lambda_function.test.arn
}