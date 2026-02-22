#NOTE Создание 3-х одинаковых дисков с помощью count
resource "yandex_compute_disk" "storage_disk" {
  count = 3

  name     = "storage-disk-${count.index + 1}"
  type     = "network-hdd"
  zone     = var.default_zone
  size     = 1  # Размер в ГБ (по заданию 1 Гб)
  folder_id = var.folder_id
}

#NOTE Создание одиночной ВМ "storage" с динамическим подключением дисков
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"
  zone        = var.default_zone
  hostname    = "storage"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8q1krrgc5pncjckeht"  #NOTE Ubuntu 22.04 LTS
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  #NOTE Динамическое подключение дополнительных дисков через dynamic блок
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk
    
    content {
      disk_id = secondary_disk.value.id
      mode    = "READ_WRITE"
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  depends_on = [yandex_compute_instance.db, yandex_compute_instance.web]
}