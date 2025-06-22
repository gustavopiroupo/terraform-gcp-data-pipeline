# Create a Pub/Sub topic to simulate data ingestion
resource "google_pubsub_topic" "data_topic" {
  name = "data-topic"

  labels = {
    environment = "dev"
    purpose     = "trigger-function"
  }
}

# (Optional) You could also define a subscription here if needed,
# but since the Cloud Function will be the subscriber, Terraform will handle the binding later.