output "network_id" {
  description = "ID созданной сети"
  value       = yandex_vpc_network.network.id
}

output "subnet_id" {
  description = "ID созданной подсети"
  value       = yandex_vpc_subnet.subnet.id
}

output "subnet_zones" {
  description = "Зона подсети"
  value       = [var.zone]
}

output "cidr_blocks" {
  description = "CIDR блоки подсети"
  value       = [var.cidr]
}