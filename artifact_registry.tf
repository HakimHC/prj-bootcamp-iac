resource "google_artifact_registry_repository" "my_repository" {
  provider      = google
  location      = var.region
  repository_id = "prj-bootcamp-gar"
  description   = "Docker registry for the offline WP image."
  format        = "DOCKER"
}
