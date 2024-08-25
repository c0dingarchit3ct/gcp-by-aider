terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_name
  region  = var.gcp_region
}

module "gcp_github_docker" {
  source = "./gcp-github-docker-module"

  github_repo_name                   = var.github_repo_name
  gcp_project_name                   = var.gcp_project_name
  gcp_location                       = var.gcp_region
  environment_tag                    = var.environment_tag
  github_org                         = var.github_org
  workload_identity_pool_id          = var.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
}



