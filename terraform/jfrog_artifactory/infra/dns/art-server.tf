module "server" {
  source       = "../config/server"
  do_token     = var.do_token
  pvt_key      = var.pvt_key
  pub_key      = var.pub_key
}

resource "digitalocean_record" "web" {
  domain = "dops.stairways.ai"
  type   = "A"
  name   = "artifactory.mjs"
  value  = "${module.server.server.ipv4_address}"
}

output "web_alias" {
  value = digitalocean_record.web
}