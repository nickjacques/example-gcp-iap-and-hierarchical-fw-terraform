variable "billing_account" {
  type        = string
  description = "The billing account to associate new projects with."
}

variable "region" {
  type = string

  description = "The region to deploy resources in (e.g., us-central1)."
}

variable "zone" {
  type        = string
  description = "The zone to deploy instances to (e.g., us-central1-a)."
}

variable "project" {
  type = string

  description = "The project to use as a seed project (ie has a Terraform service account)."
}

variable "organization" {
  type = string

  description = "The organization domain (e.g., example.com)."
}

variable "root_folder_name" {
  type        = string
  description = "The name of the root folder to be nested under the organization (e.g., Demo)."
}

variable "leaf1_folder_name" {
  type        = string
  description = "The name of a leaf folder to be nested under the root folder (e.g., Production)."
}

variable "leaf2_folder_name" {
  type        = string
  description = "The name of a leaf folder to be nested under the root folder (e.g., Development)."
}

variable "project_prod_name" {
  type        = string
  description = "The name/id of the production project (e.g. my-prod-project)"
}

variable "project_dev_name" {
  type        = string
  description = "The name/id of the development project (e.g. my-dev-project)"
}

variable "gcs_bucket_name" {
  type        = string
  description = "The name of the GCS bucket to deploy in the production project, which will host startup scripts."
}

variable "iap_support_email" {
  type        = string
  description = "The support email address to use for IAP."
}

variable "iap_application_name" {
  type        = string
  description = "The name of the IAP application."
}

variable "iap_iam_members" {
  type        = list(string)
  description = "A list of users or groups permitted to use the IAP application."

}

variable "vpc_prod_name" {
  type        = string
  description = "The name of the VPC in the production project"
}

variable "vpc_dev_name" {
  type        = string
  description = "The name of the VPC in the development project"
}

variable "subnet_prod_name" {
  type        = string
  description = "The name of the subnet in the production VPC"
}

variable "subnet_dev_name" {
  type        = string
  description = "The name of the subnet in the developent VPC"
}

variable "subnet_prod_cidr" {
  type        = string
  description = "The CIDR of the production subnet (e.g., 192.168.0.0/24)"
}

variable "subnet_dev_cidr" {
  type        = string
  description = "The CIDR of the development subnet (e.g., 192.168.0.0/24)"
}

variable "cloud_nat_router_name" {
  type        = string
  description = "The name of the Cloud Router to be used with Cloud NAT in the production project"
}

variable "cloud_nat_router_asn" {
  type        = number
  description = "The ASN of the Cloud Router to be used with Cloud NAT in the production project"
}

variable "cloud_nat_name" {
  type        = string
  description = "The name of the Cloud NAT instance to use in the production project"
}

variable "instance_machine_type" {
  type        = string
  description = "The machine type of the instance to deploy as an IAP backend (e.g., e2-medium)"
  default     = "e2-medium"
}

variable "google_managed_cert_domain" {
  type        = string
  description = "The domain name to provision a TLS certificate for, used by the IAP load balancer (e.g., myapp.example.com.)."
}

variable "org_security_policy_name" {
  type        = string
  description = "The name of the security policy to be applied at the root of the organiztion."
  default     = "org-security-policy"
}

variable "org_security_policy_deny_cidr" {
  type        = string
  description = "An example CIDR to deny egress to in the org security policy (e.g., 198.51.100.0/24)"
  default     = "198.51.100.0/24" #RFC 5737 https://datatracker.ietf.org/doc/html/rfc5737#section-3
}

variable "org_prod_security_policy_name" {
  type        = string
  description = "The name of the security policy to be applied at the Production folder in the organization."
  default     = "org-prod-security-policy"
}

variable "org_prod_security_policy_allow_cidr" {
  type        = string
  description = "An example CIDR to allow egress to in the org's production security policy (e.g., 203.0.113.0/24)"
  default     = "203.0.113.0/24" #RFC 5737 https://datatracker.ietf.org/doc/html/rfc5737#section-3
}