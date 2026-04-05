# === Сеть и подсети ===
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_nat_gateway" "nat_gw_a" {
  name     = "nat-gateway-a"
  subnet_id = yandex_vpc_subnet.develop.id
}

resource "yandex_vpc_nat_gateway" "nat_gw_b" {
  name     = "nat-gateway-b"
  subnet_id = yandex_vpc_subnet.develop_db.id
}

# Маршруты для зоны A (web)
resource "yandex_vpc_route_table" "rt_a" {
  network_id = yandex_vpc_network.develop.id
  name       = "route-table-a"

  static_route {
    destination_prefix = "0.0.0.0/0"
    nat_gateway_id     = yandex_vpc_nat_gateway.nat_gw_a.id
  }
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
  route_table_id = yandex_vpc_route_table.rt_a.id
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_name_db
  zone           = var.default_zone_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_db
  route_table_id = yandex_vpc_route_table.rt_b.id
}



# Маршруты для зоны B (db)
resource "yandex_vpc_route_table" "rt_b" {
  network_id = yandex_vpc_network.develop.id
  name       = "route-table-b"

  static_route {
    destination_prefix = "0.0.0.0/0"
    nat_gateway_id     = yandex_vpc_nat_gateway.nat_gw_b.id
  }
}

data "yandex_compute_image" "ubuntu_web" {
  family = var.vm_web_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_names.web
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_web.image_id
      type     = var.vms_resources["web"].hdd_type
      size     = var.vms_resources["web"].hdd_size
    }
  }

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = false
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${data.vault_kv_secret_v2.voult_secrets.data["vms_ssh_root_key"]}"
  }

}

data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_family
}

resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_names.db
  platform_id = var.vm_db_platform_id
  zone        = var.default_zone_b
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_web.image_id
      type     = var.vms_resources["db"].hdd_type
      size     = var.vms_resources["db"].hdd_size
    }
  }

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = false
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${data.vault_kv_secret_v2.voult_secrets.data["vms_ssh_root_key"]}"
  }

}