variable "env_name" {
  type        = string
  description = "Имя окружения"
}

variable "instance_name" {
  type        = string
  description = "Имя виртуальной машины"
}

variable "instance_count" {
  type        = number
  description = "Количество ВМ"
  default     = 1
}

variable "network_id" {
  type        = string
  description = "ID сети"
}

variable "subnet_ids" {
  type        = list(string)
  description = "ID подсетей"
}

variable "subnet_zones" {
  type        = list(string)
  description = "Зоны подсетей"
}

variable "image_family" {
  type        = string
  description = "Семейство образа ОС"
  default     = "ubuntu-2004-lts"
}

variable "public_ip" {
  type        = bool
  description = "Наличие внешнего IP"
  default     = true
}

variable "labels" {
  type        = map(string)
  description = "Метки для ВМ"
  default     = {}
}

variable "metadata" {
  type        = map(string)
  description = "Метаданные ВМ"
  default     = {}
}

variable "folder_id" {
  type        = string
  description = "ID_FOLDER"
}