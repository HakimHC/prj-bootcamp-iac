output "vpc-connector" {
  value = google_vpc_access_connector.vpc_connector.name
}

output "cloud_run_sa_email" {
  value = google_service_account.cloud_run_account.email
}

output "static_website_ip" {
  value = google_compute_global_forwarding_rule.static_site_http_rule.ip_address
}