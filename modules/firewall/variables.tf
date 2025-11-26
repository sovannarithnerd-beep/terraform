variable "vpc_id" {
  description = "VPC network ID"
  type        = string
}

variable "admin_cidr" {
  description = "List of IPs allowed to SSH"
  type        = list(string)
}

variable "tags_bastion" {
  description = "Target tag for bastion host"
  type        = list(string)
}

variable "tags_nodes" {
  description = "Target tags for Kubernetes nodes (masters/workers)"
  type        = list(string)
}

variable "lb_ip" {
  description = "VIP or external IP for load balancer (if any)"
  type        = string
  default     = null
}
