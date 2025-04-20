variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

# Function Configuration
variable "function_name" {
  description = "Name of the Cloud Function"
  type        = string
  default     = "cold-start-test"
}

variable "runtime" {
  description = "Runtime environment (nodejs18, python39, go119)"
  type        = string
  default     = "nodejs18"
}

variable "entry_point" {
  description = "Function entry point name"
  type        = string
  default     = "handler"
}

# Performance Parameters
variable "memory_mb" {
  description = "Memory allocation (MB) - Test with 128, 256, 512, 1024"
  type        = number
  default     = 256
}

variable "timeout_seconds" {
  description = "Function timeout (seconds) - Test with 30, 60, 180"
  type        = number
  default     = 60
}

# Deployment Options
variable "region" {
  description = "GCP deployment region"
  type        = string
  default     = "us-central1"
}

variable "environment_variables" {
  description = "Environment variables for the function"
  type        = map(string)
  default     = {
    TEST_MODE = "cold_start"
  }
}

# Advanced (Optional)
variable "min_instances" {
  description = "Minimum instances to keep warm (0 for pure cold starts)"
  type        = number
  default     = 0
}

variable "zip_source_path" {
  description = "Local path to the zipped function code"
  type        = string
  default     = "./node.zip"
}

variable "zip_bucket_object_name" {
  description = "Name of the zip file in the GCS bucket"
  type        = string
  default     = "node.zip"
}