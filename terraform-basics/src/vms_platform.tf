
##########################
# netology-develop-platform-web
##########################

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


# Значения переменных вызывются из файла ~/.vaultrc
variable "vault_addr" {
  description = "Vault address"
  type        = string
}

variable "vault_role_id" {
  description = "Vault AppRole role_id"
  type        = string
  sensitive   = true
}

variable "vault_secret_id" {
  description = "Vault AppRole secret_id"
  type        = string
  sensitive   = true
}

variable "vm_web_family" {
  description = "Name OS"
  default     = "ubuntu-2004-lts"
  type        = string
}

variable "vm_web_instance_name" {
  description = "Instance name"
  default     = "netology-develop-platform-web"
  type        = string
}

variable "vm_web_platform_id" {
  description = "ID Platform"
  default     = "standard-v4a"  
  type        = string
}

# variable "vm_web_cores" {
#   description = "Кол-во ядер"
#   default     = 2  
#   type        = number
# }

# variable "vm_web_memory" {
#   description = "Объем RAM памяти"
#   default     = 1  
#   type        = number
# }

# variable "vm_web_core_fraction" {
#   description = "Доля ядра"
#   default     = 20  
#   type        = number
# }


##########################
# netology-develop-platform-db
##########################
variable "default_zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name_db" {
  type        = string
  default     = "develop_db"
  description = "VPC network & subnet name"
}

variable "default_cidr_db" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_family" {
  description = "Name OS"
  default     = "ubuntu-2004-lts"
  type        = string
}

variable "vm_db_instance_name" {
  description = "Instance name"
  default     = "netology-develop-platform-db"
  type        = string
}

variable "vm_db_platform_id" {
  description = "ID Platform"
  default     = "standard-v4a"  
  type        = string
}

# variable "vm_db_cores" {
#   description = "Кол-во ядер"
#   default     = 2  
#   type        = number
# }

# variable "vm_db_memory" {
#   description = "Объем RAM памяти"
#   default     = 2 
#   type        = number
# }

# variable "vm_db_core_fraction" {
#   description = "Доля ядра"
#   default     = 20  
#   type        = number
# }



variable "vms_resources" {
  description = "Конфигурация ресурсов ВМ в формате map(object)"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
}

variable "test" {
  description = "Вложенная структура серверов (список карт списков)"
  type        = list(map(list(string)))
}