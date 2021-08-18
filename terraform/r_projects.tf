resource "google_project" "Production" {
  name                = "${var.project_prod_name}-${random_string.random.id}"
  project_id          = "${var.project_prod_name}-${random_string.random.id}"
  folder_id           = google_folder.Production.name
  auto_create_network = false
  skip_delete         = false
  billing_account     = var.billing_account
}

resource "google_project" "Development" {
  name                = "${var.project_dev_name}-${random_string.random.id}"
  project_id          = "${var.project_dev_name}-${random_string.random.id}"
  folder_id           = google_folder.Development.name
  auto_create_network = false
  skip_delete         = false
  billing_account     = var.billing_account
}