locals {
  dns_name = "bootcamp-altostratus.com."
}


resource "google_compute_network" "vpc" {
  name                    = "vpc-internal"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet1"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.0.0.0/24"
}


resource "google_vpc_access_connector" "vpc_connector" {
  name          = "internal-net"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.8.0.0/28"
}

module "private-service-access" {
  source  = "terraform-google-modules/sql-db/google//modules/private_service_access"
  version = "~> 18.0"

  project_id  = var.project
  vpc_network = google_compute_network.vpc.name

  depends_on = [google_compute_network.vpc]
}

resource "google_dns_managed_zone" "private_zone" {
  name        = "private-zone"
  dns_name    = local.dns_name
  description = "Private DNS zone for ${local.dns_name}"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc.self_link
    }
  }
}

resource "google_dns_record_set" "db_record" {
  name         = "db.${local.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.private_zone.name
  rrdatas      = [google_sql_database_instance.db.private_ip_address]

  depends_on = [google_sql_database_instance.db]
}


