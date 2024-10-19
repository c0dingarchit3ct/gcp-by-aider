
terraform {
  required_version = "~> 1.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.40"
    }
  }
  backend "gcs" {
    bucket = "apigee-test-437023-terraform-remote-backend"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.gcp_project_name
  region  = var.gcp_region
}
