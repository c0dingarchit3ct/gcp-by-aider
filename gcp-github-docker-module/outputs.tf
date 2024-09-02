output "artifact_registry_repository_name" {
  description = "Name of the created Artifact Registry repository"
  value       = google_artifact_registry_repository.docker_repo.name
}

output "artifact_registry_repository_url" {
  description = "URL of the created Artifact Registry repository"
  value       = "${google_artifact_registry_repository.docker_repo.location}-docker.pkg.dev/${var.gcp_project_name}/${google_artifact_registry_repository.docker_repo.repository_id}"
}

output "service_account_email" {
  description = "Email of the created service account for GitHub Actions"
  value       = google_service_account.github_actions_sa.email
}

output "workload_identity_pool_name" {
  description = "Name of the Workload Identity Pool"
  value       = google_iam_workload_identity_pool.github_pool.name
}

output "workload_identity_pool_provider_name" {
  description = "Name of the Workload Identity Pool Provider"
  value       = google_iam_workload_identity_pool_provider.github_provider.name
}

output "workload_identity_pool_provider_output_id" {
  description = "Name of the Workload Identity Pool Provider"
  value       = google_iam_workload_identity_pool_provider.github_provider.id
}
