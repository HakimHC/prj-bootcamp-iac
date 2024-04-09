resource "google_cloudbuild_trigger" "offline-wp-trigger" {
  location = var.region
  name     = "offline-wp-trigger"

  github {
    owner = var.github_owner
    name  = var.repo_name

    push {
      branch = "^main$"
    }
  }

  substitutions = {
    _LOCATION   = var.region
    _PROJECT_ID = var.project
    _REPOSITORY = google_artifact_registry_repository.wp-repo.name
    _PIPELINE   = google_clouddeploy_delivery_pipeline.primary.name
    _VPC        = google_vpc_access_connector.vpc_connector.name
  }

  service_account = google_service_account.cloud_build_account.id


  filename = var.cloud_build_yaml_path
}
