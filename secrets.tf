locals {
  secrets = {
    DB_HOST     = google_dns_record_set.db_record.name
    DB_USER     = google_sql_user.wordpress_user.name
    DB_PASSWORD = google_sql_user.wordpress_user.password
    DB_DATABASE = google_sql_database.wordpress.name
    DB_PORT     = 5432

    SSP_GITHUB_TOKEN = var.ssp_github_token
    SSP_GITHUB_USER = var.ssp_github_user
    SSP_GITHUB_REPO = var.ssp_github_repo
    SSP_GITHUB_BRANCH = var.ssp_github_branch

    DOMAIN_FUNCTION_URL = module.domain_function.function_uri
    SERVICE_NAME        = var.cloud_run_service_name

    WP_ADMIN_USER             = var.wp_admin_user
    WP_ADMIN_PASSWORD         = var.wp_admin_password
  }
}

resource "google_secret_manager_secret" "dynamic_secrets" {
  for_each = local.secrets

  secret_id = each.key

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "dynamic_secret_versions" {
  for_each = local.secrets

  secret      = google_secret_manager_secret.dynamic_secrets[each.key].id
  secret_data = each.value
}
