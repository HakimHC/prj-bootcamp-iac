resource "google_clouddeploy_target" "primary" {
  location          = var.region
  name              = "test-target-deploy"
  deploy_parameters = {}
  description       = "basic description"

  execution_configs {
    usages            = ["RENDER", "DEPLOY"]
    execution_timeout = "3600s"
  }

  project          = var.project
  require_approval = false

  run {
    location = "projects/${var.project}/locations/${var.region}"
  }
}

resource "google_clouddeploy_delivery_pipeline" "primary" {
  location    = var.region
  name        = "pipeline"
  description = "basic description"
  project     = var.project

  serial_pipeline {
    stages {
      target_id = google_clouddeploy_target.primary.name
      profiles  = ["app"]
    }
  }
}