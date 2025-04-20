# Enable required APIs
resource "google_project_service" "apis" {
  project = var.gcp_project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_project_iam_member" "functions_artifact_registry" {
  project = var.gcp_project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcf-admin-robot.iam.gserviceaccount.com"
}

# Grant Cloud Functions service account the Artifact Registry role
data "google_project" "project" {
  project_id = var.gcp_project_id
}
