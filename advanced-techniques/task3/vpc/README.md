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
| [yandex_vpc_network.network](https://registry.terraform.io/providers/hashicorp/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnet](https://registry.terraform.io/providers/hashicorp/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR блок подсети | `string` | `"10.0.1.0/24"` | no |
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | ID\_CLOUD | `string` | n/a | yes |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Имя окружения (develop, stage, prod) | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | ID\_FOLDER | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Зона доступности | `string` | `"ru-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cidr_blocks"></a> [cidr\_blocks](#output\_cidr\_blocks) | CIDR блоки подсети |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID созданной сети |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | ID созданной подсети |
| <a name="output_subnet_zones"></a> [subnet\_zones](#output\_subnet\_zones) | Зона подсети |
