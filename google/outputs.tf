output "function_url" {
  value       = google_cloudfunctions_function.function.https_trigger_url
  description = "HTTP trigger URL for the Cloud Function"
}

output "bucket_name" {
  value       = google_storage_bucket.bucket.name
  description = "Name of the storage bucket holding function code"
}