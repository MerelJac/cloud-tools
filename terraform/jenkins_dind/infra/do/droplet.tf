resource "digitalocean_droplet" "build-server" {
    image = "debian-12-x64"
    name = "build-server"
    region = "sfo3"
    size = "s-1vcpu-2gb"
    tags = ["build", "server", "jenkins"]
    ssh_keys = [
      data.digitalocean_ssh_key.mj-sandbox.id, data.digitalocean_ssh_key.ap-sandbox.id
    ]

  provisioner "remote-exec" {
    inline = ["echo Done!"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }
  }

  provisioner "file" {
    source      = "ansible/install-docker.sh"
    destination = "/usr/docker/jenkins_dind/install-docker.sh"

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }

  }

  provisioner "file" {
    source      = "ansible/docker-compose.yml"
    destination = "/usr/docker/jenkins_dind/docker-compose.yml"

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }

  }

  provisioner "remote-exec" {
    inline = ["cd /usr/docker/jenkins_dind && ./install-docker.sh &&  docker compose up"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }
  }

}

