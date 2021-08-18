resource "google_project_service" "Prod_Compute" {
  project = google_project.Production.id

  service                    = "compute.googleapis.com"
  disable_on_destroy = false
  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_project_service" "Prod_Iap" {
  project = google_project.Production.id

  service                    = "iap.googleapis.com"
  disable_on_destroy = false
  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_project_service" "Prod_Identity" {
  project = google_project.Production.id

  service                    = "cloudidentity.googleapis.com"
  disable_on_destroy = false
  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_project_service" "Prod_IdentityToolkit" {
  project = google_project.Production.id

  service                    = "identitytoolkit.googleapis.com"
  disable_on_destroy = false
  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_project_service" "Prod_Iam" {
  project = google_project.Production.id

  service                    = "iam.googleapis.com"
  disable_on_destroy = false
  timeouts {
    create = "30m"
    update = "40m"
  }
}


resource "google_project_service" "Dev_Compute" {
  project = google_project.Development.id

  service                    = "compute.googleapis.com"
  disable_on_destroy = false
  timeouts {
    create = "30m"
    update = "40m"
  }
}