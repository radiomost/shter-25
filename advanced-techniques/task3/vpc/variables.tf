variable "env_name" {
  type        = string
  description = "Имя окружения (develop, stage, prod)"
}

variable "zone" {
  type        = string
  description = "Зона доступности"
  default     = "ru-central1-a"
}

variable "cidr" {
  type        = string
  description = "CIDR блок подсети"
  default     = "10.0.1.0/24"
}

variable "folder_id" {
  type        = string
  description = "ID_FOLDER"
}

variable "cloud_id" {
  type        = string
  description = "ID_CLOUD"
}