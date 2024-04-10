resource "random_uuid" "force_config" {}

resource "null_resource" "jenkins_droplet" {
  triggers = {
    reconfigure = "${random_uuid.force_config.result}"
  }

  provisioner "local-exec" {
    command = join(" ", [
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook",
      "-u root -i '${module.do.raw_droplet.ipv4_address},'",
      "--private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}'",
      "ansible/install-docker.yml"
    ])
  }

  provisioner "local-exec" {
    command = join(" ", [
      "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook",
      "-u root -i '${module.do.raw_droplet.ipv4_address},'",
      "--private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}'",
      "ansible/run-compose-project.yml"
    ])
  }
}

output "server" {
  value = module.do.raw_droplet
}