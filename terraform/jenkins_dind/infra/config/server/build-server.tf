module "init" {
  source       = "../init"
  do_token     = var.do_token
  pvt_key      = var.pvt_key
  pub_key      = var.pub_key
}

resource "random_uuid" "force_config" {}

resource "null_resource" "jenkins_droplet" {
  triggers = {
    reconfigure = "${random_uuid.force_config.result}"
  }

  depends_on = [
    module.init.initial_config_done
  ]

  provisioner "local-exec" {
    command = join(" ", [
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook",
      "-u root -i '${module.init.initialized_droplet.ipv4_address},'",
      "--private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}'",
      "ansible/install-docker.yml"
    ])
  }

  provisioner "local-exec" {
    command = join(" ", [
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook",
      "-u root -i '${module.init.initialized_droplet.ipv4_address},'",
      "--private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}'",
      "ansible/run-compose-project.yml"
    ])
  }
}

output "server" {
  value = module.init.initialized_droplet
}