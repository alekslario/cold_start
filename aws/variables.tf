# AWS Config
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# Lambda Function
variable "function_name" {
  type    = string
  default = "node-coldstart-test"
}

variable "memory_size" {
  type    = number
  default = 128  # Test: 128, 256, 512, 1024, 2048
}

variable "timeout" {
  type    = number
  default = 3  # Seconds (Test: 1, 3, 10)
}

# Advanced
variable "environment_vars" {
  type    = map(string)
  default = {
    TEST_MODE = "cold_start"
  }
}

# Deployment Package
variable "zip_path" {
  type    = string
  default = "node.zip"
}

variable "handler" {
  type    = string
  default = "lambda.handler"  # You can change the default as needed
}

variable "runtime" {
  type    = string
  default = "nodejs18.x"  # Test: nodejs16.x, nodejs18.x
}
