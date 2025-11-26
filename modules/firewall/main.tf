# Allow SSH to bastion
resource "google_compute_firewall" "ssh_bastion" {
  name    = "fw-ssh-bastion"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.admin_cidr
  target_tags   = var.tags_bastion
}

# Allow internal SSH from bastion to nodes
resource "google_compute_firewall" "ssh_nodes" {
  name    = "fw-ssh-nodes"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = var.tags_bastion
  target_tags = var.tags_nodes
}
