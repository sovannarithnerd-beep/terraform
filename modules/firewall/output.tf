output "ssh_bastion_firewall" {
  description = "Firewall rule allowing SSH to bastion"
  value       = google_compute_firewall.ssh_bastion.name
}

output "ssh_nodes_firewall" {
  description = "Firewall rule allowing bastion to SSH nodes"
  value       = google_compute_firewall.ssh_nodes.name
}
