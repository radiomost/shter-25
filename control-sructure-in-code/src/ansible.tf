locals {
  #NOTE Группа Web-серверов (из count-vm.tf)
  webservers = [
    for vm in yandex_compute_instance.web : {
      name       = vm.name
      ansible_host = vm.network_interface[0].nat_ip_address
      fqdn       = vm.fqdn
    }
  ]

  #NOTE Группа Баз данных (из for_each-vm.tf)
  databases = [
    for vm in yandex_compute_instance.db : {
      name       = vm.name
      ansible_host = vm.network_interface[0].nat_ip_address
      fqdn       = vm.fqdn
    }
  ]

  #NOTE Группа Storage (из disk_vm.tf) - оборачиваем в список для единообразия
  storage = [
    {
      name       = yandex_compute_instance.storage.name
      ansible_host = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn       = yandex_compute_instance.storage.fqdn
    }
  ]
}

#NOTE Генерация Ansible inventory файла через templatefile
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })

  filename = "${path.module}/hosts.ini"
}

#NOTE Output для проверки (опционально)
output "inventory_file_path" {
  value = "${path.module}/inventory/hosts.ini"
}


# resource "null_resource" "ansible_inventory" {
#   triggers = {
#     # Пересоздавать файл при изменении состава ВМ
#     inventory_hash = sha256(join("", concat(
#       [for vm in local.webservers : vm.fqdn],
#       [for vm in local.databases : vm.fqdn],
#       [for vm in local.storage : vm.fqdn]
#     )))
#   }

#   provisioner "local-exec" {
#     command = "cat > ${path.module}/hosts.ini <<EOF\n${templatefile("${path.module}/hosts.tftpl", { webservers = local.webservers, databases = local.databases, storage = local.storage })}\nEOF"
#   }
# }