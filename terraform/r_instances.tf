resource "google_compute_instance_template" "IapInstanceTemplate" {
  project = google_project.Production.project_id

  name           = "iap-instance-template"
  machine_type   = var.instance_machine_type
  can_ip_forward = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
    auto_delete  = true
    boot         = true
    disk_size_gb = 25
  }

  network_interface {
    network    = google_compute_network.ProdNetwork.self_link
    subnetwork = google_compute_subnetwork.ProdSubnet.self_link
  }

  shielded_instance_config {
    enable_secure_boot = true
  }

  metadata = {
    "startup-script-url" = "gs://${google_storage_bucket.ProdStartupScripts.name}/nginx.sh"
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}


resource "google_compute_instance_group_manager" "IapInstanceGroupMananger" {
  project = google_project.Production.project_id

  name               = "iap-instance-group"
  base_instance_name = "iap-server"
  zone               = var.zone

  version {
    instance_template = google_compute_instance_template.IapInstanceTemplate.id
  }

  target_size = 1

  named_port {
    name = "http"
    port = 80
  }

  # Do not start instances until Cloud NAT has been deployed to ensure internet access is available for downloading packages from repos
  depends_on = [
    google_compute_router_nat.CloudNat
  ]
}
