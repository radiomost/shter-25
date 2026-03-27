terraform {
    required_version = ">= 0.13"  
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.7.0"
    }
  }
}
provider "yandex" {
    cloud_id                = var.cloud_id
    folder_id               = var.folder_id
    service_account_key_file = file ("/root/.authorized_key.json")
}
