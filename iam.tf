# Create a dedicated service account for the Cloud Function
resource "google_service_account" "function_sa" {
  account_id   = "pubsub-function-sa"
  display_name = "Service Account for Cloud Function (Pub/Sub to BigQuery)"
}

# Grant permission to write to BigQuery
resource "google_project_iam_member" "bigquery_writer" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${google_service_account.function_sa.email}"
}

# Grant permission to read Pub/Sub messages
resource "google_project_iam_member" "pubsub_subscriber" {
  project = var.project_id
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.function_sa.email}"
}