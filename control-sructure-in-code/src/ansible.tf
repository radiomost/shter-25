locals {
  # ---------------------------------------------------------------------------
  # Группа Web-серверов (выбираем nat_ip или внутренний ip)
  # ---------------------------------------------------------------------------
  webservers = [
    for vm in yandex_compute_instance.web : {
      name       = vm.name
      # Если nat_ip есть - используем его, иначе внутренний IP
      ansible_host = length(vm.network_interface[0].nat_ip_address) > 0 ? vm.network_interface[0].nat_ip_address : vm.network_interface[0].ip_address
      fqdn       = vm.fqdn
    }
  ]

  # ---------------------------------------------------------------------------
  # Группа Баз данных
  # ---------------------------------------------------------------------------
  databases = [
    for vm in yandex_compute_instance.db : {
      name       = vm.name
      ansible_host = length(vm.network_interface[0].nat_ip_address) > 0 ? vm.network_interface[0].nat_ip_address : vm.network_interface[0].ip_address
      fqdn       = vm.fqdn
    }
  ]

  # ---------------------------------------------------------------------------
  # Группа Storage
  # ---------------------------------------------------------------------------
  storage = [
    {
      name       = yandex_compute_instance.storage.name
      ansible_host = length(yandex_compute_instance.storage.network_interface[0].nat_ip_address) > 0 ? yandex_compute_instance.storage.network_interface[0].nat_ip_address : yandex_compute_instance.storage.network_interface[0].ip_address
      fqdn       = yandex_compute_instance.storage.fqdn
    }
  ]
}

# =============================================================================
# Генерация Ansible inventory файла
# =============================================================================

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })

  filename = "${path.module}/hosts.ini"
}

# =============================================================================
# Запуск ansible-playbook через null_resource
# =============================================================================

resource "null_resource" "ansible_configure" {
  triggers = {
    inventory_hash = sha256(local_file.ansible_inventory.content)
  }

  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.db,
    yandex_compute_instance.storage,
    local_file.ansible_inventory
  ]

  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/hosts.ini ${path.module}/test.yml"
    
    # Опционально: указать переменные
    # environment = {
    #   ANSIBLE_HOST_KEY_CHECKING = "False"
    # }
  }
}