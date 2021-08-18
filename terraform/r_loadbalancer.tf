resource "google_compute_global_address" "IapIpAddress" {
  project = google_project.Production.project_id

  name = "iap-loadbalancer-ip"
}

resource "google_compute_global_forwarding_rule" "IapForwardingRule" {
  project = google_project.Production.project_id

  name       = "iap-forwarding-rule"
  target     = google_compute_target_https_proxy.IapHttpsProxy.id
  port_range = "443"
  ip_address = google_compute_global_address.IapIpAddress.address
}

resource "google_compute_target_https_proxy" "IapHttpsProxy" {
  project = google_project.Production.project_id

  name             = "iap-https-proxy"
  url_map          = google_compute_url_map.IapUrlMap.id
  ssl_certificates = [google_compute_managed_ssl_certificate.IapHttpsCert.id]
}

resource "google_compute_managed_ssl_certificate" "IapHttpsCert" {
  project = google_project.Production.project_id

  name = "iap-https-cert"
  managed {
    domains = [var.google_managed_cert_domain]
  }
}

resource "google_compute_url_map" "IapUrlMap" {
  project = google_project.Production.project_id

  name            = "iap-url-map"
  default_service = google_compute_backend_service.IapBackendService.id
}

resource "google_compute_backend_service" "IapBackendService" {
  project = google_project.Production.project_id

  name          = "iap-backend"
  port_name     = "http"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = [google_compute_http_health_check.IapHealthCheck.id]

  backend {
    group = google_compute_instance_group_manager.IapInstanceGroupMananger.instance_group
  }

  iap {
    oauth2_client_id     = google_iap_client.IapClient.client_id
    oauth2_client_secret = google_iap_client.IapClient.secret
  }
}

resource "google_compute_http_health_check" "IapHealthCheck" {
  project = google_project.Production.project_id

  name               = "iap-healthcheck"
  request_path       = "/api/status"
  check_interval_sec = 1
  timeout_sec        = 1
}