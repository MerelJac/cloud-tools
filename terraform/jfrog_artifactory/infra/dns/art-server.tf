module "server" {
  source       = "../config/server"
  do_token     = var.do_token
  pvt_key      = var.pvt_key
  pub_key      = var.pub_key
}

resource "digitalocean_record" "artifactory" {
  domain = "dops.stairways.ai"
  type   = "A"
  name   = "artifactory.mjs"
  value  = "${module.server.server.ipv4_address}"
}

output "art_alias" {
  value = digitalocean_record.artifactory
}

resource "digitalocean_record" "jfrog" {
  domain = "dops.stairways.ai"
  type   = "A"
  name   = "jfrog.mjs"
  value  = "${module.server.server.ipv4_address}"
}

output "jfrog_alias" {
  value = digitalocean_record.jfrog
}

resource "digitalocean_record" "art-traefik" {
  domain = "dops.stairways.ai"
  type   = "A"
  name   = "art-traefik.mjs"
  value  = "${module.server.server.ipv4_address}"
}

output "art-traefik_alias" {
  value = digitalocean_record.art-traefik
}
