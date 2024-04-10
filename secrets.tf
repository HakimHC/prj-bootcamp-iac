# TODO: separate db secrets from cloud function secrets

locals {
  secrets = {
    DB_HOST     = google_dns_record_set.db_record.name
    DB_USER     = google_sql_user.wordpress_user.name
    DB_PASSWORD = google_sql_user.wordpress_user.password
    DB_DATABASE = google_sql_database.wordpress.name
    DB_PORT     = 5432

    SLACK_API_TOKEN = var.slack_api_token
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
