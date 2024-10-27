
terraform {
  backend "gcs" {
    bucket = "apigee-test-437023-terraform-remote-backend"
    prefix = "terraform/state"
  }
}
