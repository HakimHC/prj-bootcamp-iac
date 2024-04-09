resource "google_service_account" "cloud_build_account" {
  project      = var.project
  account_id   = "cloud-build-account"
  display_name = "Cloud Build Service Account"
}

resource "google_service_account" "cloud_run_account" {
  project      = var.project
  account_id   = "cloud-run-account"
  display_name = "Cloud Run Service Account"
}
