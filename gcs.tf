# Create a Google Cloud Storage bucket to store the Cloud Function source code
resource "google_storage_bucket" "function_source_bucket" {
  name     = "${var.project_id}-function-source"
  location = var.region

  uniform_bucket_level_access = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 7 # auto-delete objects older than 7 days
    }
  }

  versioning {
    enabled = true
  }

  labels = {
    environment = "dev"
    purpose     = "cloud-function-source"
  }
}