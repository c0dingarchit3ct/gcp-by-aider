output "service_name" {
  value       = google_cloud_run_service.service.name
  description = "Name of the created service"
}

output "service_revision" {
  value       = google_cloud_run_service.service.status[0].latest_ready_revision_name
  description = "Deployed revision for the service"
}

output "service_url" {
  value       = google_cloud_run_service.service.status[0].url
  description = "The URL on which the deployed service is available"
}

output "service_id" {
  value       = google_cloud_run_service.service.id
  description = "The ID of the deployed service"
}
