variable "env" {
  description = "Deployment environment name (dev, prod, etc.)"
  type        = string
}
variable "domain_name" {
  default = "Domain of dns k8s"
  type    = string
}
variable "project_id" {}
variable "region" {}
variable "zones" {
  type = list(string)
}
variable "credentials_file" {}
variable "state_bucket" {}
variable "ssh_user" {}
variable "ssh_pub_key_path" {}
variable "node_map" {}
variable "image_project" {}
variable "image_family" {}
variable "node_disk_size_gb" {}
variable "node_disk_type" {}
variable "network_cidr" {}
variable "subnet_cidr" {}
variable "admin_cidr" {
  type = list(string)
}
variable "tags" {
  type = list(string)
}
variable "network" {}
variable "vpc_id" {}