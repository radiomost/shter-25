output "fqdn" {
  description = "FQDN виртуальных машин"
  value       = yandex_compute_instance.vm[*].fqdn
}

output "instance_ids" {
  description = "ID виртуальных машин"
  value       = yandex_compute_instance.vm[*].id
}

output "public_ips" {
  description = "Внешние IP адреса"
  value       = yandex_compute_instance.vm[*].network_interface[0].nat_ip_address
}