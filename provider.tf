# Configure the Google Cloud provider
provider "google" {
  project = var.gcp_project_name
  region  = var.gcp_region
}

# Enable required Google APIs
resource "google_project_service" "required_apis" {
  for_each = toset([
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sts.googleapis.com"
  ])

  project = var.gcp_project_name
  service = each.key

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}
