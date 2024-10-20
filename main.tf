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

module "cloud_run_service" {
  source           = "./cloud-run-module"
  service_name     = var.service_name
  gcp_project_name = var.gcp_project_name
  gcp_location     = var.gcp_region
  environment_tag  = var.environment_tag
}

# resource "google_project_service" "iamserveres" {
#   project = var.gcp_project_name
#   service = "iam.googleapis.com"

#   timeouts {
#     create = "30m"
#     update = "40m"
#   }

#   disable_on_destroy = false
# }
# resource "google_project_service" "credservices" {
#   project = var.gcp_project_name
#   service = "iamcredentials.googleapis.com"

#   timeouts {
#     create = "30m"
#     update = "40m"
#   }

#   disable_on_destroy = false
# }
# resource "google_project_service" "resourcemanagerservices" {
#   project = var.gcp_project_name
#   service = "cloudresourcemanager.googleapis.com"

#   timeouts {
#     create = "30m"
#     update = "40m"
#   }

#   disable_on_destroy = false
# }
# resource "google_project_service" "stsservices" {
#   project = var.gcp_project_name
#   service = "sts.googleapis.com"

#   timeouts {
#     create = "30m"
#     update = "40m"
#   }

#   disable_on_destroy = false
# }
