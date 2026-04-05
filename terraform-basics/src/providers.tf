terraform {
    required_version = ">= 0.13"  
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.7.0"
    }
  }

  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "netology/devops/terraform.tfstate"
    region                      = "us-east-1"
    endpoint                    = "http://s3.rdmost.ru:9000"
    profile                     = "minio-truenas"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
    insecure                    = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = data.vault_kv_secret_v2.voult_secrets.data["ya_cloud_id"]
  folder_id                = data.vault_kv_secret_v2.voult_secrets.data["ya_folder_id"]
  zone                     = var.default_zone
  service_account_key_file = file ("/root/.authorized_key.json")
}


provider "vault" {
  address = var.vault_addr

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.vault_role_id
      secret_id = var.vault_secret_id
    }
  }
}