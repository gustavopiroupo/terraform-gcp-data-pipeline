# Output the project ID used
output "project_id" {
  description = "The GCP project where resources are deployed"
  value       = var.project_id
}

# Output the region used
output "region" {
  description = "The region where the resources are deployed"
  value       = var.region
}