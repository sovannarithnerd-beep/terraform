output "zone_name" {
  value       = google_dns_managed_zone.main.name
  description = "DNS managed zone name"
}

output "zone_dns_name" {
  value       = google_dns_managed_zone.main.dns_name
  description = "DNS zone FQDN"
}
