terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

resource "google_artifact_registry_repository" "docker_repo" {
  provider = google-beta

  location      = var.gcp_location
  repository_id = "${var.github_repo_name}-docker-repo"
  description   = "Docker repository for ${var.github_repo_name}"
  format        = "DOCKER"

  labels = {
    environment = var.environment_tag
  }
}

resource "google_service_account" "github_actions_sa" {
  account_id   = "${var.github_repo_name}-github-actions"
  display_name = "GitHub Actions Service Account for ${var.github_repo_name}"
  project      = var.gcp_project_name
}

resource "google_artifact_registry_repository_iam_member" "github_actions_iam" {
  provider = google-beta

  location   = google_artifact_registry_repository.docker_repo.location
  repository = google_artifact_registry_repository.docker_repo.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_service_account_key" "github_actions_sa_key" {
  service_account_id = google_service_account.github_actions_sa.name
}
