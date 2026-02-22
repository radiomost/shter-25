output "vm_inventory" {
  description = "Список всех ВМ с name, id и fqdn"
  value = concat(
    [
      for vm in yandex_compute_instance.web : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ],
    [
      for vm in yandex_compute_instance.db : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ]
  )
}