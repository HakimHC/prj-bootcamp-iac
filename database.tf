resource "google_sql_database_instance" "db" {
  project          = var.project
  name             = "wordpress-db-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    edition = "ENTERPRISE"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.self_link
    }
  }

  depends_on          = [module.private-service-access]
  deletion_protection = false
}

resource "google_sql_database" "wordpress" {
  name     = "wordpress"
  instance = google_sql_database_instance.db.name
}

resource "random_password" "wp-pass" {
  length  = 16
  special = true
}

resource "google_sql_user" "wordpress_user" {
  name     = "wordpress_user"
  instance = google_sql_database_instance.db.name
  password = random_password.wp-pass.result
}