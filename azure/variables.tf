variable "function_name" {
  description = "Base name for function resources"
  type        = string
  default     = "coldstart-test"
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "westeurope"
}

variable "runtime" {
  description = "Function runtime stack"
  type        = string
  default     = "node"
  validation {
    condition     = contains(["node", "python", "dotnet", "java"], var.runtime)
    error_message = "Invalid runtime"
  }
}

variable "plan_type" {
  description = "App Service Plan type"
  type        = string
  default     = "Consumption"
  validation {
    condition     = contains(["Consumption", "Premium", "AppServicePlan"], var.plan_type)
    error_message = "Invalid plan type"
  }
}

variable "always_on" {
  description = "Prevent cold starts by keeping instance alive"
  type        = bool
  default     = false
}

variable "worker_count" {
  description = "Number of worker processes"
  type        = number
  default     = 1
}

variable "memory_mb" {
  description = "Memory allocation in MB"
  type        = number
  default     = 1536
}

variable "timeout_seconds" {
  description = "Function timeout duration"
  type        = number
  default     = 300
}

variable "function_code_path" {
  description = "Path to the function code zip file"
  type        = string
  default     = "node.zip"
}

variable "function_entry_point" {
  description = "Entry point function name"
  type        = string
  default     = "handler" # Change for your function
}