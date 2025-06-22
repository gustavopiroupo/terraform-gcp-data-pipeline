# Archive the Cloud Function source code (zip the cloudfunction/ folder)
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/cloudfunction"
  output_path = "${path.module}/cloudfunction.zip"
}

# Upload the zip file to the GCS bucket
resource "google_storage_bucket_object" "function_source_archive" {
  name   = "cloudfunction.zip"
  bucket = google_storage_bucket.function_source_bucket.name
  source = data.archive_file.function_zip.output_path
}

# Deploy the Cloud Function (2nd gen, Python runtime)
resource "google_cloudfunctions2_function" "pubsub_to_bq" {
  name     = "pubsub-to-bigquery"
  location = var.region

  build_config {
    runtime     = "python310"
    entry_point = "main"
    source {
      storage_source {
        bucket = google_storage_bucket.function_source_bucket.name
        object = google_storage_bucket_object.function_source_archive.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "128M"
    timeout_seconds    = 60
    environment        = "GEN_2"
    ingress_settings   = "ALLOW_ALL"

    # Grant required roles through service account
    service_account_email = google_service_account.function_sa.email
  }

  event_trigger {
    trigger_region        = var.region
    event_type            = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic          = google_pubsub_topic.data_topic.id
    retry_policy          = "RETRY_POLICY_DO_NOT_RETRY"
  }
}