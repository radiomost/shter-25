# =============================================================================
# Outputs (вынесены ИЗ модуля в корень!)
# =============================================================================
output "vpc_network_id" {
  value = module.vpc_dev.network_id
}

output "vpc_subnet_id" {
  value = module.vpc_dev.subnet_id
}

output "marketing_fqdn" {
  value = module.marketing_vm.fqdn
}

output "analytics_fqdn" {
  value = module.analytics_vm.fqdn
}