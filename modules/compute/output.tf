# -----------------------------
# Masters (control-plane) private IPs
# -----------------------------
output "control_plane_ips" {
  description = "Private IPs of all control-plane nodes"
  value = [
    for inst in google_compute_instance.masters : inst.network_interface[0].network_ip
  ]
}

# -----------------------------
# Worker nodes private IPs
# -----------------------------
output "worker_ips" {
  description = "Private IPs of all worker nodes"
  value = [
    for inst in google_compute_instance.workers : inst.network_interface[0].network_ip
  ]
}

# -----------------------------
# Bastion public IP
# -----------------------------
output "bastion_ip" {
  description = "Public IP of the bastion host"
  #value = [for b in google_compute_instance.bastion : b.network_interface[0].access_config[0].nat_ip]
  value = google_compute_address.bastion.address
}

# -----------------------------
# Optional: Self-links for reference (not required for Ansible)
# -----------------------------
output "control_plane_self_links" {
  value = {
    for name, inst in google_compute_instance.masters : name => inst.self_link
  }
}
