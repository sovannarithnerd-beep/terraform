variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "env" {
  type        = string
  description = "Environment name (dev, prod, etc.)"
}

variable "domain_name" {
  type        = string
  description = "Domain name for managed zone (e.g., example.com)"
}

variable "bastion_ip" {
  type        = string
  description = "Optional: public IP of bastion VM to create A record"
  default     = ""
}
