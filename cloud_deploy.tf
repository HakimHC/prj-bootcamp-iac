resource "google_clouddeploy_target" "primary" {
  location          = var.region
  name              = "offline-wp-target"
  deploy_parameters = {}
  description       = "Cloud run target for Offline Wordpress"

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
  name        = "offline-wp-delivery-pipeline"
  description = "Delivery pipeline for the Offline Wordpress Service."
  project     = var.project

  serial_pipeline {
    stages {
      target_id = google_clouddeploy_target.primary.name
      profiles  = ["app"]
    }
  }
}