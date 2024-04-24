module "dns" {
  source       = "./infra/dns"
  do_token     = var.do_token
  pvt_key      = var.pvt_key
  pub_key      = var.pub_key
}

resource "null_resource" "MainTF" {
  provisioner "local-exec" {
    command = "echo Finished provisioning."
  }
}