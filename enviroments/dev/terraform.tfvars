env         = "dev"
domain_name = "k8s-bastion-dns.whitecloud.space"
# GCP project
project_id       = "final-project-300usd"
region           = "asia-southeast2"
zones            = ["asia-southeast2-a", "asia-southeast2-b", "asia-southeast2-c"]
credentials_file = "../../gcp/gcp-ha-k8s.json"
state_bucket     = "tfstate-rith-ha-k8s-prod"

ssh_user         = "rith"
ssh_pub_key_path = "~/.ssh/devops_key.pub"
network          = "ha-k8s-vpc"


node_map = {
  "k8s-cp-1"     = { role = "master", machine_type = "e2-medium", zone = "asia-southeast2-a", tags = ["k8s", "master"] }
  "k8s-cp-2"     = { role = "master", machine_type = "e2-medium", zone = "asia-southeast2-b", tags = ["k8s", "master"] }
  "k8s-cp-3"     = { role = "master", machine_type = "e2-medium", zone = "asia-southeast2-c", tags = ["k8s", "master"] }
  "k8s-worker-1" = { role = "worker", machine_type = "e2-medium", zone = "asia-southeast2-a", tags = ["k8s", "worker"] }
  "k8s-worker-2" = { role = "worker", machine_type = "e2-medium", zone = "asia-southeast2-b", tags = ["k8s", "worker"] }
  "k8s-worker-3" = { role = "worker", machine_type = "e2-medium", zone = "asia-southeast2-c", tags = ["k8s", "worker"] }
  "bastion"      = { role = "bastion", machine_type = "e2-small", zone = "asia-southeast2-a", tags = ["bastion"] }
}

image_project     = "ubuntu-os-cloud"
image_family      = "ubuntu-2204-lts"
node_disk_size_gb = 30
node_disk_type    = "pd-balanced"

network_cidr = "10.0.0.0/16"
subnet_cidr  = "10.0.0.0/24"

admin_cidr = ["203.0.113.25/32", "203.0.113.30/32"]
tags       = ["k8s", "ha-cluster"]
