## About this repository
This repository is intended to provide sample Terraform configurations for the following Google Cloud features:
* [Hierarchical firewalls](https://cloud.google.com/vpc/docs/firewall-policies)
* [Identity-Aware Proxy](https://cloud.google.com/iap/docs/concepts-overview)

**Note: this repository is provided for example purposes only. Please do not deploy this to your environment without reviewing, vetting, and customizing its contents.**

## Legal information
Please review `LICENSE.txt` for important licensing and copyright information.

All contents of this repository are provided ​“AS IS”. The developer(s) and maintainer(s) of this repository make no other warranties, express or implied, and hereby disclaims all implied warranties, including any warranty of merchantability and warranty of fitness for a particular purpose.

## Repository contents and descriptions

* `terraform/`
  * `_output.tf` - outputs values for your reference after completing `terraform apply`.
  * `_providers.tf` - a bootstrap configuration for the Google Cloud [Terraform providers](https://www.terraform.io/docs/language/providers/index.html).
  * `_vars.tf` - variables used throughout the other Terraform files.
  * `d_organization.tf` - a data source to retrieve [organization](https://cloud.google.com/resource-manager/docs/creating-managing-organization) information.
  * `r_folders.tf` - creates a folder under the organization root node, and then two folders under that folder.
  * `r_gcs.tf` - creates a GCS bucket, assigns read permissions to the Production default service account, and uploads a startup script to the bucket for use during instance boot-up.
  * `r_iap.tf` - creates the [Identity-Aware Proxy](https://cloud.google.com/iap/docs/concepts-overview) resources required to integrate IAP with the HTTP(S) load balancer.
  * `r_instances.tf` - creates an instance template and zonal managed instance group, which will deploy an instance serving as the backend of the HTTP(S) load balancer.
  * `r_loadbalancer.tf` - creates a static global IP address, [Google-managed TLS certificate](https://cloud.google.com/load-balancing/docs/ssl-certificates/google-managed-certs), and external HTTP(S) load balancer components.
  * `r_nat.tf` - deploys [Cloud NAT](https://cloud.google.com/nat/docs/overview) to the Production project, which allows instances to install packages during startup.
  * `r_networks.tf` - creates a VPC and subnet in the Production and Development projects.
  * `r_projects_apis.tf` - enables necessary APIs in the Production and Development projects.
  * `r_projects.tf` - creates a Production and a Development project, nested under folders defined in `r_folders.tf`.
  * `r_random.tf` - generates a 6-character random ID that is appended to resource names requiring global uniqueness (e.g., projects and GCS buckets)
  * `r_security_policy.tf` - creates [hierarchical firewall](https://cloud.google.com/vpc/docs/firewall-policies) policies and attaches them to the organization (from `d_organization.tf`) and to the Production folder (from `r_folders.tf`).
  * `terraform.tfvars` - SAMPLE/EXAMPLE variable values for `_vars.tf`. **You should review and change this file to suit your needs.**
  * `ProdStartupScripts/`
    * `nginx.sh` - a startup script that installs nginx, ElasticSearch, and Kibana to serve as a sample application behind the IAP-enabled HTTP(S) load balancer.

## How to use this repository

1. Clone this repository to a system that has [Terraform](https://www.terraform.io/downloads.html) installed. This system should have access to a Google Cloud service account with organizational IAM privileges that allows for CRUD operations on the organization, billing account, projects, project contents/resources, and organization security policies.
1. Customize the `terraform.tfvars` file (and other resource configurations) to suit your needs, including the commented lines. If you do not edit and uncomment these lines, you will be prompted for their values during `terraform plan/apply`.
1. `cd terraform/` to enter into the terraform subdirectory.
1. Use `terraform` to take actions...
    * `terraform init` to download/update the providers.
    * `terraform plan` to view what Terraform will deploy.
    * `terraform apply` to deploy the changes listed in `terraform plan`.
    * `terraform destroy` to destroy all resources that Terraform created.

## Notes and caveats
* All resources created by Terraform will be deleted after executing `terraform destroy`. Do not save your work in (or otherwise rely on) the folders, projects, instances, or buckets created by this repo.

* You will need to create a DNS A record that binds the domain configured in `google_managed_cert_domain` to the static IP address created from the `google_compute_global_address.IapIpAddress` resource, in order for the Google-managed TLS certificate to be provisioned. 
  * The IP address of the load balancer will automatically be output upon a successful `terraform apply`. 
  * Provisioning the certificate may take several minutes once the A record has been created.

* In `r_security_policy.tf`, several CIDRs are referenced.
  * Several CIDRs are [reserved example/documentation ranges via RFC 5737](https://datatracker.ietf.org/doc/html/rfc5737#section-3) and are used for examples of allowing/denying traffic.
  * Several other CIDRs are used by Google: [IAP TCP Tunneling](https://cloud.google.com/iap/docs/using-tcp-forwarding) (to click the "SSH" button in the Cloud Console), and [Cloud Load Balancing](https://cloud.google.com/load-balancing/docs/https#firewall-rules).

* A non-exhaustive list of IAM roles that *may* be required for the Terraform service account to execute Terraform successfully:
  * Project Billing Manager
  * Billing Account User
  * Billing Account Viewer
  * Compute Organization Firewall Policy Admin
  * Compute Organization Security Policy Admin
  * Compute Organization Resource Admin
  * IAP Policy Admin
  * IAP Settings Admin
  * Organization Policy Administrator
  * Folder Admin
  * Organization Viewer
  * Project Creator
  * Project Deleter
  * Project IAM Admin
  * Project Mover