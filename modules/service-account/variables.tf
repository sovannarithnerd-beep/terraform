variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "env" {
  type        = string
  description = "Environment name (dev, prod, etc.)"
}

variable "roles" {
  type        = list(string)
  description = "IAM roles to assign to service account"
  default = [
    "roles/compute.admin",
    "roles/iam.serviceAccountUser",
    "roles/dns.admin",
    "roles/storage.admin",
    "roles/monitoring.admin"
  ]
}
