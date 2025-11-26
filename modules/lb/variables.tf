variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}


variable "cp_instances" {
  description = "Map of control-plane instance self-links"
  type        = map(string)
}
variable "cp_ips" {
  description = "Map of control-plane instance self-links"
  type        = map(string)
}
