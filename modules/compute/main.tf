# Masters
resource "google_compute_instance" "masters" {
  for_each = { for k, v in var.nodes : k => v if v.role == "master" }

  name         = each.key
  machine_type = each.value.machine_type
  zone         = each.value.zone

  boot_disk {
    initialize_params {
      image = "projects/${var.image_project}/global/images/family/${var.image_family}"
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.vpc_id
    subnetwork = var.subnet_id
    # Masters use private IP only, no access_config
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key)}"
  }

  tags = each.value.tags

  lifecycle {
    #prevent_destroy = true
  }
}

# Workers
resource "google_compute_instance" "workers" {
  for_each = { for k, v in var.nodes : k => v if v.role == "worker" }

  name         = each.key
  machine_type = each.value.machine_type
  zone         = each.value.zone

  boot_disk {
    initialize_params {
      image = "projects/${var.image_project}/global/images/family/${var.image_family}"
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.vpc_id
    subnetwork = var.subnet_id
    # Masters use private IP only, no access_configv
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key)}"
  }

  tags = each.value.tags
}

# ==========================
# Bastion Host
# ==========================
# Reserve a static external IP for bastion
resource "google_compute_address" "bastion" {
  name   = "bastion-static-ip"
  region = var.region
}

# Bastion VM
resource "google_compute_instance" "bastion" {
  for_each = { for k, v in var.nodes : k => v if v.role == "bastion" }

  name         = each.key
  machine_type = each.value.machine_type
  zone         = each.value.zone

  boot_disk {
    initialize_params {
      image = "projects/${var.image_project}/global/images/family/${var.image_family}"
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }

  network_interface {
    network    = var.vpc_id
    subnetwork = var.subnet_id

    access_config {
      nat_ip = google_compute_address.bastion.address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key)}"
  }

  tags = each.value.tags
}