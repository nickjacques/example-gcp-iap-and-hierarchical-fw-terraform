resource "google_storage_bucket" "ProdStartupScripts" {
  project = google_project.Production.project_id

  name                        = "${var.gcs_bucket_name}-${random_string.random.id}"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "ProdStartupScriptsIamMember" {
  bucket = google_storage_bucket.ProdStartupScripts.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_project.Production.number}-compute@developer.gserviceaccount.com"
}

resource "google_storage_bucket_object" "ProdNginxStartupScript" {
  name   = "nginx.sh"
  source = "ProdStartupScripts/nginx.sh"
  bucket = google_storage_bucket.ProdStartupScripts.name
}