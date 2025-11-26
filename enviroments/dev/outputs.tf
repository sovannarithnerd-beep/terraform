output "control_plane_ips" {
  value = module.compute.control_plane_ips
}

output "worker_ips" {
  value = module.compute.worker_ips
}

output "network_name" {
  value = module.network.network_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "lb_ip" {
  value = module.lb.lb_ip
}

output "bastion_ip" {
  description = "Public IP of the bastion host"
  value       = module.compute.bastion_ip
}

output "compute" {
  value = concat(
    [
      for ip in module.compute.control_plane_ips : {
        name       = "master-${ip}"
        private_ip = ip
        role       = "master"
      }
    ],
    [
      for ip in module.compute.worker_ips : {
        name       = "worker-${ip}"
        private_ip = ip
        role       = "worker"
      }
    ]
  )
}




