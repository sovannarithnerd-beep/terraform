variable "nodes" {
  description = "Map of node definitions (key = node name, value = object with role, machine_type, zone, tags)"
  type = map(object({
    role         = string
    machine_type = string
    zone         = string
    tags         = list(string)
  }))
}

variable "image_project" {
  description = "GCP image project"
  type        = string
}

variable "image_family" {
  description = "GCP image family"
  type        = string
}

variable "disk_size_gb" {
  description = "Size of boot disk in GB"
  type        = number
}

variable "disk_type" {
  description = "Disk type (pd-standard, pd-balanced, pd-ssd)"
  type        = string
}

variable "vpc_id" {
  description = "VPC network ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnetwork ID"
  type        = string
}

variable "ssh_user" {
  description = "SSH username"
  type        = string
}

variable "ssh_pub_key" {
  description = "Path to SSH public key"
  type        = string
}
variable "region" {
  description = "Path to SSH public key"
  type        = string
}
