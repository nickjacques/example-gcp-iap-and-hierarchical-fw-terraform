resource "google_compute_network" "ProdNetwork" {
  project = google_project.Production.project_id

  name                    = var.vpc_prod_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "ProdSubnet" {
  project = google_compute_network.ProdNetwork.project

  name                     = var.subnet_prod_name
  ip_cidr_range            = var.subnet_prod_cidr
  region                   = var.region
  private_ip_google_access = true

  network = google_compute_network.ProdNetwork.id
}

resource "google_compute_network" "DevNetwork" {
  project = google_project.Development.project_id

  name                    = var.vpc_dev_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "DevSubnet" {
  project = google_compute_network.DevNetwork.project

  name                     = var.subnet_dev_name
  ip_cidr_range            = var.subnet_dev_cidr
  region                   = var.region
  private_ip_google_access = true

  network = google_compute_network.DevNetwork.id
}