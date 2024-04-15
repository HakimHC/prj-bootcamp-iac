resource "google_storage_bucket" "functions_source_bucket" {
  name          = "functions-source-bucket-prj-bootcamp"
  location      = var.region
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_object" "notifications_src" {
  name   = "notifications-src.zip"
  bucket = google_storage_bucket.functions_source_bucket.name
  source = "./functions-src/notifications/slack-notifications.zip"
}

resource "google_storage_bucket_object" "domain_src" {
  name   = "domain-src.zip"
  bucket = google_storage_bucket.functions_source_bucket.name
  source = "./functions-src/domain/domain-function.zip"
}
