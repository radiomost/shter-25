# =============================================================================
# Модуль VPC
# =============================================================================
module "vpc_dev" {
  source    = "./vpc"
  env_name  = "develop"
  zone      = "ru-central1-a"
  cidr      = "10.0.1.0/24"
  folder_id = var.folder_id
  cloud_id  = var.cloud_id
}

# =============================================================================
# Модуль Marketing VM
# =============================================================================
module "marketing_vm" {
  source         = "./vms"
  env_name       = "marketing"
  instance_name  = "marketing-web"
  instance_count = 1
  network_id     = module.vpc_dev.network_id
  subnet_ids     = [module.vpc_dev.subnet_id]
  subnet_zones   = module.vpc_dev.subnet_zones
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  folder_id      = var.folder_id

  labels = {
    owner   = "i.ivanov"
    project = "marketing"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

# =============================================================================
# Модуль Analytics VM
# =============================================================================
module "analytics_vm" {
  source         = "./vms"
  env_name       = "analytics"
  instance_name  = "analytics-web"
  instance_count = 1
  network_id     = module.vpc_dev.network_id
  subnet_ids     = [module.vpc_dev.subnet_id]
  subnet_zones   = module.vpc_dev.subnet_zones
  image_family   = "ubuntu-2004-lts"
  public_ip      = true
  folder_id      = var.folder_id

  labels = {
    owner   = "i.ivanov"
    project = "analytics"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

# =============================================================================
# Шаблон cloud-init
# =============================================================================
data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-init.yml")
  vars = {
    ssh_public_key = var.public_key
  }
}

