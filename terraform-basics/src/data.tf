data "vault_kv_secret_v2" "voult_secrets" {
  mount = "secret"
  name  = "my-app/proxmox/yandex-cloud/netology"
}