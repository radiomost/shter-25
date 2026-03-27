output "out" {
  description = "Список FQDN всех виртуальных машин"
  value = concat(
    module.marketing_vm.fqdn,
    module.analytics_vm.fqdn
  )
}