resource "google_cloudbuild_trigger" "offline-wp-trigger" {
  location = var.region
  name = "offline-wp-trigger"

  github {
    owner = var.github_owner
    name = var.repo_name

    push {
      branch = "^main$"
    }
  }

  substitutions = {
    _LOCATION = var.region
    _PROJECT_ID = var.project
    _REPOSITORY = google_artifact_registry_repository.wp-repo.name
  }

  filename = var.cloud_build_yaml_path
}
