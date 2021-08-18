resource "google_compute_router" "NatRouter" {
  project = google_project.Production.project_id

  name    = var.cloud_nat_router_name
  region  = google_compute_subnetwork.ProdSubnet.region
  network = google_compute_network.ProdNetwork.id

  bgp {
    asn = var.cloud_nat_router_asn
  }
}

resource "google_compute_router_nat" "CloudNat" {
  project = google_project.Production.project_id

  name                               = var.cloud_nat_name
  router                             = google_compute_router.NatRouter.name
  region                             = google_compute_router.NatRouter.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}