locals {
  ssh_public_key = file(pathexpand(var.public_key_path))
}