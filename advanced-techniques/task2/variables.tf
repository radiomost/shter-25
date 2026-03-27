variable "cloud_id" {
  type    = string
  default = "ваш_cloud_id"
}

variable "folder_id" {
  type    = string
  default = "ваш_folder_id"
}

variable "public_key" {
  type        = string
  description = "SSH публичный ключ"
}