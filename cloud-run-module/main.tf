resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.gcp_location
  project  = var.gcp_project_name

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        ports {
          container_port = 1234
          name           = "http1"
        }
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.service.name
  location = google_cloud_run_service.service.location
  project  = google_cloud_run_service.service.project
  role     = "roles/run.invoker"
  member   = "allUsers"
}
