terraform {
    required_version = ">= 0.13"  
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.129.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.7.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
  }
}
provider "yandex" {
    cloud_id                = var.cloud_id
    folder_id               = var.folder_id
    service_account_key_file = file ("/root/.authorized_key.json")
}

variable "public_key" {
  type        = string
  description = "Содержимое публичного SSH ключа"
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBeNpGEymQ8Rlhq6oUOW76e0JL8JiYDjsS6pPpDRK3AL root@DEVOPS"
}