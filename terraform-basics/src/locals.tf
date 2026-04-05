locals {
  vm_names = {
    web = "${var.vpc_name}-web-${split("-", var.default_zone)[0]}-dev"
    db  = "${var.vpc_name}-db-${split("-", var.default_zone_b)[0]}-dev"
  }

  # Опционально: можно вынести и другие повторяющиеся значения
  common_metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${data.vault_kv_secret_v2.voult_secrets.data["vms_ssh_root_key"]}"
  }
}