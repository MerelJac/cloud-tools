module "do" {
  source       = "../do"
  do_token     = var.do_token
  pvt_key      = var.pvt_key
  pub_key      = var.pub_key
}

resource "null_resource" "docker_compose_droplet" {
  provisioner "local-exec" {
    command = join(" ", [
                "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook",
                "-u root -i '${module.do.raw_droplet.ipv4_address},'",
                "--private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}'",
                "ansible/install-docker.yml"
              ])
  }
}

