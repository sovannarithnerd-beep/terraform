resource "google_dns_managed_zone" "main" {
  name        = "${var.env}-zone"
  dns_name    = "${var.domain_name}."
  description = "Managed zone for ${var.env}"
}

# Optional A record for bastion VM
# Optional A record for bastion VM
# resource "google_dns_record_set" "bastion" {
#   name         = "bastion.${var.domain_name}."
#   type         = "A"
#   ttl          = 300
#   managed_zone = google_dns_managed_zone.main.name
#   rrdatas      = [google_compute_address.bastion.address]

#   depends_on = [google_compute_address.bastion]
# }


resource "google_dns_record_set" "bastion" {
  name         = "bastion.${var.domain_name}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.main.name
  rrdatas      = [var.bastion_ip]
}