# Define variables
variable "gcp_project_name" {
  description = "Name of the Google Cloud Platform project"
  type        = string
}

variable "gcp_region" {
  description = "GCP region for resources"
  type        = string
}

variable "github_repo_name" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "environment_tag" {
  description = "Environment tag (e.g., dev, staging, prod)"
  type        = string
}

variable "github_org" {
  description = "GitHub organization name"
  type        = string
}

variable "workload_identity_pool_id" {
  description = "ID for the Workload Identity Pool"
  type        = string
}

variable "workload_identity_pool_provider_id" {
  description = "ID for the Workload Identity Pool Provider"
  type        = string
}

variable "service_name" {
  description = "Name of the Cloud Run service that will be deployed"
  type        = string

}
