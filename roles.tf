locals {
  cloud_build_roles = [
    "roles/cloudbuild.builds.builder",
    "roles/clouddeploy.operator",
    "roles/run.admin",
    "roles/iam.serviceAccountUser"
  ]

  cloud_run_roles = [
    "roles/secretmanager.secretAccessor"
  ]
}

resource "google_project_iam_member" "cloud_build_iam" {
  for_each = toset(local.cloud_build_roles)
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.cloud_build_account.email}"
}

resource "google_project_iam_member" "cloud_run_iam" {
  for_each = toset(local.cloud_run_roles)
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.cloud_run_account.email}"
}

#roles/secretmanager.secretAccessor