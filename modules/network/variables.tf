variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "network_cidr" {
  type        = string
  description = "VPC network CIDR"
}

variable "subnet_cidr" {
  type        = string
  description = "Subnet CIDR"
}
