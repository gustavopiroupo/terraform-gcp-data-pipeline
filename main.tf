# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Specify the required providers and Terraform version
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}