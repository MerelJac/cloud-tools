module "droplet" {
  source       = "./infra/config"
  do_token     = var.do_token
  pvt_key      = var.pvt_key
  pub_key      = var.pub_key
}

resource "null_resource" "MainTF" {
  provisioner "local-exec" {
    command = "echo Finished provisioning."
  }

  provisioner "local-exec" {
    command = "echo ${module.droplet.server.ipv4_address}"
  }

}