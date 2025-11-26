# Network module
module "network" {
  source       = "../../modules/network"
  project_id   = var.project_id
  region       = var.region
  network_cidr = var.network_cidr
  subnet_cidr  = var.subnet_cidr
}

# Compute module
module "compute" {
  source        = "../../modules/compute"
  nodes         = var.node_map
  image_project = var.image_project
  image_family  = var.image_family
  disk_size_gb  = var.node_disk_size_gb
  disk_type     = var.node_disk_type
  vpc_id        = module.network.network_name
  subnet_id     = module.network.subnet_name
  ssh_user      = var.ssh_user
  ssh_pub_key   = var.ssh_pub_key_path
  region        = var.region
}

# Firewall module
module "firewall" {
  source       = "../../modules/firewall"
  vpc_id       = module.network.vpc_id # must be output from network module
  admin_cidr   = var.admin_cidr
  tags_bastion = ["bastion"] # tag applied to bastion host
  tags_nodes   = ["k8s"]     # tags applied to master/worker nodes
  lb_ip        = null

}

module "lb" {
  source       = "../../modules/lb"
  project_id   = var.project_id
  region       = var.region
  cp_ips       = module.compute.control_plane_self_links # exact variable name LB module expects
  cp_instances = module.compute.control_plane_self_links
}

# Service Account module
module "service_account" {
  source     = "../../modules/service-account"
  project_id = var.project_id
  env        = var.env
  roles = [
    "roles/compute.admin",
    "roles/dns.admin",
    "roles/iam.serviceAccountUser",
    "roles/storage.admin"
  ]
}

# DNS module
module "dns" {
  source      = "../../modules/dns"
  project_id  = var.project_id
  env         = var.env
  domain_name = "k8s-bastion-dns.whitecloud.space"
  #bastion_ip  = module.compute.bastion_ip[0] # Since bastion_ip output is a list
  bastion_ip = module.compute.bastion_ip


}





