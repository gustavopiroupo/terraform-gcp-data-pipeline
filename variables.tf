# Google Cloud Project ID
# Must be provided by the user when applying the Terraform configuration
variable "project_id" {
  description = "The ID of your GCP project"
  type        = string
}

# GCP region where resources will be created
# Can be overridden by the user; default is set to 'us-central1'
variable "region" {
  description = "The region to deploy resources in"
  type        = string
  default     = "us-central1"
}