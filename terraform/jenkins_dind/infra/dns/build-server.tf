module "server" {
  source       = "../config/server"
  do_token     = var.do_token
  pvt_key      = var.pvt_key
  pub_key      = var.pub_key
}

resource "digitalocean_record" "web" {
  domain = "dops.stairways.ai"
  type   = "A"
  name   = "jenkins.mjs"
  value  = "${module.server.server.ipv4_address}"
}

resource "digitalocean_record" "service" {
  domain = "dops.stairways.ai"
  type   = "A"
  name   = "traefik.mjs"
  value  = "${module.server.server.ipv4_address}"
}

output "web_alias" {
  value = digitalocean_record.web
}

output "service_alias" {
  value = digitalocean_record.service
}