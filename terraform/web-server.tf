resource "digitalocean_droplet" "web-server" {
    image = "debian-12-x64"
    name = "web-server"
    region = "sfo3"
    size = "s-1vcpu-512mb-10gb"
    tags = ["web", "server"]
    ssh_keys = [
      data.digitalocean_ssh_key.mj-sandbox.id
    ]
}

resource "digitalocean_droplet" "net-server" {
    image = "debian-12-x64"
    name = "net-server"
    region = "sfo3"
    size = "s-1vcpu-512mb-10gb"
    tags = ["net", "server"]
    ssh_keys = [
      data.digitalocean_ssh_key.mj-sandbox.id
    ]
}