terraform {
  required_version = ">= 0.13"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.129.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
  }
}