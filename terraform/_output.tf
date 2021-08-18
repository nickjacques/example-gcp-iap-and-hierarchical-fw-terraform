output "IapLoadBalancerIpAddress" {
  value       = google_compute_global_address.IapIpAddress.address
  description = "The IP address of the IAP HTTP(S) load balancer. You should configure an A record for the hostname you specified in google_managed_cert_domain to point to this address."
}