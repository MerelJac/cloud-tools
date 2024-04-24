module "do" {
  source       = "../../do"
  do_token     = var.do_token
  pvt_key      = var.pvt_key
  pub_key      = var.pub_key
}

resource "null_resource" "initial_droplet_config" {
  provisioner "local-exec" {
    command = join(" ", [
                "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook",
                "-u root -i '${module.do.raw_droplet.ipv4_address},'",
                "--private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}'",
                "ansible/wait-for-init.yml"
              ])
  }
}

output "initialized_droplet" {
  value = module.do.raw_droplet
}

output "initial_config_done" {
  value = null_resource.initial_droplet_config
}