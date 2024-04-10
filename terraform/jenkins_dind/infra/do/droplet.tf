resource "digitalocean_droplet" "droplet" {
    image = "debian-12-x64"
    name = "jenkins-server"
    region = "sfo3"
    size = "s-1vcpu-2gb"
    tags = ["build", "server", "jenkins"]
    ssh_keys = [
      data.digitalocean_ssh_key.mj-sandbox.id, data.digitalocean_ssh_key.ap-sandbox.id
    ]

  provisioner "remote-exec" {
    inline = ["echo Starting to provision..."]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }
  }

}

