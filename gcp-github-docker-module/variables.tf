variable "github_repo_name" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "gcp_project_name" {
  description = "Name of the Google Cloud Platform project"
  type        = string
}

variable "gcp_location" {
  description = "GCP location for resources"
  type        = string
}

variable "environment_tag" {
  description = "Environment tag (e.g., dev, staging, prod)"
  type        = string
}
