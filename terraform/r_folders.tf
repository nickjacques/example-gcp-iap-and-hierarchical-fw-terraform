resource "google_folder" "Demo" {
  display_name = var.root_folder_name
  parent       = data.google_organization.organization.name
}

resource "google_folder" "Production" {
  display_name = var.leaf1_folder_name
  parent       = google_folder.Demo.name
}

resource "google_folder" "Development" {
  display_name = var.leaf2_folder_name
  parent       = google_folder.Demo.name
}