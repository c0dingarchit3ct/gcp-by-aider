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

output "service_account_key" {
  description = "Private key of the created service account for GitHub Actions (sensitive)"
  value       = google_service_account_key.github_actions_sa_key.private_key
  sensitive   = true
}
