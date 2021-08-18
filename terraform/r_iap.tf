resource "google_iap_brand" "IapBrand" {
  project = google_project.Production.project_id

  support_email     = var.iap_support_email
  application_title = var.iap_application_name

  # Prevent race condition where deploying this resource before iap.googleapis.com is enabled will cause terraform apply to fail
  depends_on = [
    google_project_service.Prod_Iap
  ]
}

resource "google_iap_client" "IapClient" {
  display_name = "IAP Client"
  brand        = google_iap_brand.IapBrand.name
}

resource "google_iap_web_backend_service_iam_binding" "IapIamBinding" {
  project = google_compute_backend_service.IapBackendService.project

  web_backend_service = google_compute_backend_service.IapBackendService.name
  role                = "roles/iap.httpsResourceAccessor"
  members             = var.iap_iam_members
}