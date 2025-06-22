# Create a BigQuery dataset to store processed data
resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = "demo_dataset"
  location   = var.region

  labels = {
    environment = "dev"
    purpose     = "store-pubsub-events"
  }
}

# Create a BigQuery table with a basic schema
resource "google_bigquery_table" "events_table" {
  dataset_id = google_bigquery_dataset.demo_dataset.dataset_id
  table_id   = "events"

  schema = jsonencode([
    {
      name = "id"
      type = "STRING"
      mode = "REQUIRED"
    },
    {
      name = "message"
      type = "STRING"
      mode = "NULLABLE"
    },
    {
      name = "timestamp"
      type = "TIMESTAMP"
      mode = "REQUIRED"
    }
  ])

  deletion_protection = false

  labels = {
    environment = "dev"
    purpose     = "store-events"
  }
}