terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Enable the Artifact Registry API
resource "google_project_service" "artifact_registry" {
  project = var.gcp_project_name
  service = "artifactregistry.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  # Disable dependent services
  disable_dependent_services = true
}

resource "google_artifact_registry_repository" "docker_repo" {
  depends_on = [google_project_service.artifact_registry]
  provider   = google-beta

  project       = var.gcp_project_name
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

  project    = var.gcp_project_name
  location   = google_artifact_registry_repository.docker_repo.location
  repository = google_artifact_registry_repository.docker_repo.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

resource "google_iam_workload_identity_pool" "github_pool" {
  provider                  = google-beta
  project                   = var.gcp_project_name
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = "GitHub Actions Pool"
  description               = "Identity pool for GitHub Actions"
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  provider                           = google-beta
  project                            = var.gcp_project_name
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  display_name                       = "GitHub Actions Provider"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.actor_id"   = "assertion.actor_id"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
  attribute_condition = "attribute.repository == \"${var.github_org}/${var.github_repo_name}\" && attribute.actor_id.startsWith(\"${var.github_org}/\")"
}

# resource "google_service_account_iam_member" "workload_identity_user" {
#   service_account_id = google_service_account.github_actions_sa.name
#   role               = "roles/iam.workloadIdentityUser"
#   member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${var.github_org}/${var.github_repo_name}"

#   condition {
#     title       = "Limit to specific GitHub repo and org"
#     description = "Only allow access from the specified GitHub repository and organization"
#     expression  = <<EOT
#     "attribute.repository == "${var.github_org}/${var.github_repo_name}" &&
#     attribute.actor_id.startsWith("${var.github_org}/")"
# EOT
#   }
# }
