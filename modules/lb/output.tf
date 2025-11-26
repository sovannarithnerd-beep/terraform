output "lb_ip" {
  description = "External IP of HA API load balancer"
  value       = google_compute_forwarding_rule.cp_lb.ip_address
}
