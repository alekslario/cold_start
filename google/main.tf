provider "google" {
  project = var.gcp_project_id
  region  = var.region
}

resource "google_storage_bucket" "bucket" {
  name     = "${var.function_name}-${random_id.suffix.hex}"
  location = "US"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "google_cloudfunctions_function" "function" {
  name                  = var.function_name
  runtime               = var.runtime
  entry_point           = var.entry_point
  available_memory_mb                = var.memory_mb
  timeout               = var.timeout_seconds
  trigger_http          = true
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  environment_variables = var.environment_variables
  min_instances         = var.min_instances
}

resource "google_storage_bucket_object" "archive" {
  name   = var.zip_bucket_object_name  # Now variable-based
  bucket = google_storage_bucket.bucket.name
  source = var.zip_source_path         # Now variable-based
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}