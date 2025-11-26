# Create a forwarding rule and target pool for HA API server
# resource "google_compute_target_pool" "cp_pool" {
#   name = "k8s-cp-target-pool"
#   region = var.region
#   instances = var.cp_ips
# }
resource "google_compute_target_pool" "cp_pool" {
  name      = "cp-pool"
  region    = var.region
  instances = values(var.cp_instances)  # convert map to list of self-links
}


resource "google_compute_forwarding_rule" "cp_lb" {
  name        = "k8s-cp-lb"
  target      = google_compute_target_pool.cp_pool.id
  port_range  = "6443"
  region      = var.region
  load_balancing_scheme = "EXTERNAL"
  ip_protocol = "TCP"
}
