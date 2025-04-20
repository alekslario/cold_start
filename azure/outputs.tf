output "function_name" {
  description = "Name of the deployed Azure Function"
  value       = azurerm_windows_function_app.func.name
}

output "function_url" {
  description = "URL endpoint of the Azure Function"
  value       = "https://${azurerm_windows_function_app.func.default_hostname}/api/${var.function_name}"
}

output "cold_start_configuration" {
  description = "Current cold start-related configuration"
  value = {
    plan_type        = var.plan_type
    always_on        = var.always_on
    worker_count     = var.worker_count
    memory_mb        = var.memory_mb
    timeout_seconds  = var.timeout_seconds
  }
}
