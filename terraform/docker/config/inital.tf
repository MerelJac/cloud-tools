module "webserver_cluster" {
  source = "../infra" 
}

resource "configured_droplet" "docker" {

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${webserver_cluster.ipv4_address},' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' ansible/wait-for-init.yml"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${webserver_cluster.ipv4_address},' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' ansible/install-docker.yml"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${webserver_cluster.ipv4_address},' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' ansible/run-compose-file.yml"
  }

}

