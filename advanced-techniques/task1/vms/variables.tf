variable "cloud_id" {
  type    = string
  default = "ваш_cloud_id"
}

variable "folder_id" {
  type    = string
  default = "ваш_folder_id"
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "public_key" {
  type        = string
  description = "Содержимое публичного SSH ключа"
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBeNpGEymQ8Rlhq6oUOW76e0JL8JiYDjsS6pPpDRK3AL root@DEVOPS"
}
