
# Output important values
output "artifact_registry_repository_name" {
  description = "Name of the created Artifact Registry repository"
  value       = module.gcp_github_docker.artifact_registry_repository_name
}

output "artifact_registry_repository_url" {
  description = "URL of the created Artifact Registry repository"
  value       = module.gcp_github_docker.artifact_registry_repository_url
}

output "service_account_email" {
  description = "Email of the created service account for GitHub Actions"
  value       = module.gcp_github_docker.service_account_email
}

output "workload_identity_pool_name" {
  description = "Name of the Workload Identity Pool"
  value       = module.gcp_github_docker.workload_identity_pool_name
}

output "workload_identity_pool_provider_name" {
  description = "Name of the Workload Identity Pool Provider"
  value       = module.gcp_github_docker.workload_identity_pool_provider_name
}

output "workload_identity_pool_provider_output_id" {
  description = "Name of the Workload Identity Pool Provider"
  value       = module.gcp_github_docker.workload_identity_pool_provider_output_id
}

output "cloud_run_service_url" {
  description = "URL of the Cloud Run service"
  value       = module.cloud_run_service.service_url
}

output "cloud_run_service_name" {
  description = "Name of the Cloud Run service"
  value       = module.cloud_run_service.service_name
}

output "cloud_run_service_revision" {
  description = "Revision of the Cloud Run service"
  value       = module.cloud_run_service.service_revision
}

output "cloud_run_service_id" {
  description = "ID of the Cloud Run service"
  value       = module.cloud_run_service.service_id
}
