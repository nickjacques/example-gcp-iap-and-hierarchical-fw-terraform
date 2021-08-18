// Org
resource "google_compute_organization_security_policy" "OrgSecPolicy" {
  provider = google-beta

  display_name = var.org_security_policy_name
  parent       = data.google_organization.organization.name
}

resource "google_compute_organization_security_policy_rule" "OrgSecPolicyRule" {
  provider = google-beta

  policy_id      = google_compute_organization_security_policy.OrgSecPolicy.id
  action         = "deny"
  description    = "Deny all outbound to example CIDR ${var.org_security_policy_deny_cidr}"
  direction      = "EGRESS"
  enable_logging = false
  priority       = 100

  match {
    config {
      dest_ip_ranges = [var.org_security_policy_deny_cidr]
      layer4_config {
        ip_protocol = "tcp"
      }
      layer4_config {
        ip_protocol = "icmp"
      }
      layer4_config {
        ip_protocol = "udp"
      }
    }
  }
}

resource "google_compute_organization_security_policy_rule" "OrgSecPolicyRule-GCLB" {
  provider = google-beta

  policy_id      = google_compute_organization_security_policy.OrgSecPolicy.id
  action         = "allow"
  description    = "Allow all inbound traffic from Google CIDRs for load balancing, health checks, and IAP"
  direction      = "INGRESS"
  enable_logging = false
  priority       = 90

  match {
    config {
      src_ip_ranges = ["35.191.0.0/16", "130.211.0.0/22", "35.235.240.0/20"]
      layer4_config {
        ip_protocol = "tcp"
      }
    }
  }
}

resource "google_compute_organization_security_policy_association" "OrgSecPolicy" {
  provider = google-beta

  name          = var.org_security_policy_name
  attachment_id = google_compute_organization_security_policy.OrgSecPolicy.parent
  policy_id     = google_compute_organization_security_policy.OrgSecPolicy.id
}

//Prod
resource "google_compute_organization_security_policy" "ProdSecPolicy" {
  provider = google-beta

  display_name = var.org_prod_security_policy_name
  parent       = google_folder.Production.id
}

resource "google_compute_organization_security_policy_rule" "ProdSecPolicyRule" {
  provider = google-beta

  policy_id = google_compute_organization_security_policy.ProdSecPolicy.id
  action    = "allow"

  description = "Example partner integration, allow inbound from ${var.org_prod_security_policy_allow_cidr}"

  direction      = "INGRESS"
  enable_logging = false
  match {
    config {
      src_ip_ranges = [var.org_prod_security_policy_allow_cidr]
      layer4_config {
        ip_protocol = "tcp"
        ports       = ["80"]
      }
    }
  }
  priority = 90
}

resource "google_compute_organization_security_policy_association" "ProdSecPolicy" {
  provider = google-beta

  name          = var.org_prod_security_policy_name
  attachment_id = google_compute_organization_security_policy.ProdSecPolicy.parent
  policy_id     = google_compute_organization_security_policy.ProdSecPolicy.id
}
