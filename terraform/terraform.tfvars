# Update commented out lines to contain details specific to your needs

#billing_account               = "XXXXXX-XXXXXX-XXXXXX"
#project                       = "example-project-id"
region                        = "us-central1"
zone                          = "us-central1-a"
#organization                  = "example.com"
root_folder_name              = "IAP Demo"
leaf1_folder_name             = "Production"
leaf2_folder_name             = "Development"
project_prod_name             = "iap-tf-demo-prod"
project_dev_name              = "iap-tf-demo-dev"
gcs_bucket_name               = "iap-tf-demo-gcs"
#iap_support_email             = "terraform@project-id.iam.gserviceaccount.com"
iap_application_name          = "IAP Demonstration App"
#iap_iam_members               = ["user:username@example.com"]
vpc_prod_name                 = "iap-tf-demo-prod-vpc"
vpc_dev_name                  = "iap-tf-demo-dev-vpc"
subnet_prod_name              = "iap-tf-prod-subnet"
subnet_prod_cidr              = "192.168.200.0/24"
subnet_dev_name               = "iap-tf-dev-subnet"
subnet_dev_cidr               = "192.168.201.0/24"
cloud_nat_router_name         = "cloud-nat-router"
cloud_nat_router_asn          = 64514
cloud_nat_name                = "prod-cloud-nat"
#google_managed_cert_domain    = "iap-demo.example.com." # note: trailing . is required
org_security_policy_name      = "iap-tf-org-sec-policy"
org_prod_security_policy_name = "iap-tf-org-prod-sec-policy"