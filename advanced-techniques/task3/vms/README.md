## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_compute_instance.vm](https://registry.terraform.io/providers/hashicorp/yandex/latest/docs/resources/compute_instance) | resource |
| [yandex_compute_image.ubuntu](https://registry.terraform.io/providers/hashicorp/yandex/latest/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Имя окружения | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | ID\_FOLDER | `string` | n/a | yes |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | Семейство образа ОС | `string` | `"ubuntu-2004-lts"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Количество ВМ | `number` | `1` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Имя виртуальной машины | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Метки для ВМ | `map(string)` | `{}` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Метаданные ВМ | `map(string)` | `{}` | no |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID сети | `string` | n/a | yes |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | Наличие внешнего IP | `bool` | `true` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | ID подсетей | `list(string)` | n/a | yes |
| <a name="input_subnet_zones"></a> [subnet\_zones](#input\_subnet\_zones) | Зоны подсетей | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | FQDN виртуальных машин |
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | ID виртуальных машин |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | Внешние IP адреса |
