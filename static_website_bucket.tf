resource "google_storage_bucket" "static_site" {
  name          = "static-wp-bucket"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["*"]
    method          = ["GET"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_iam_binding" "public_read" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}

resource "google_compute_backend_bucket" "static_site_backend" {
  name        = "static-wp-bucket-backend"
  bucket_name = google_storage_bucket.static_site.name
}

resource "google_compute_url_map" "static_site_url_map" {
  name            = "static-wp-bucket-url-map"
  default_service = google_compute_backend_bucket.static_site_backend.self_link
}

resource "google_compute_target_http_proxy" "static_site_proxy" {
  name    = "static-wp-bucket-http-proxy"
  url_map = google_compute_url_map.static_site_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "static_site_http_rule" {
  name       = "static-wp-bucket-http-rule"
  target     = google_compute_target_http_proxy.static_site_proxy.self_link
  port_range = "80"
}

