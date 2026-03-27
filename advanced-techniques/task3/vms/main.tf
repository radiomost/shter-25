resource "yandex_compute_instance" "vm" {
  count = var.instance_count

  name        = var.instance_name
  platform_id = "standard-v1"
  zone        = var.subnet_zones[count.index]

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_ids[count.index]
    nat       = var.public_ip
  }

  labels = var.labels

  metadata = var.metadata

  lifecycle {
    create_before_destroy = true
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}