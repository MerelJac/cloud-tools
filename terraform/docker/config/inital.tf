resource "null_resource" "ConfigureAnsibleLabelVariable" {
  provisioner "local-exec" {
    command = "echo HELLO_WORLD"
  }

  provisioner "local-exec" {
    command = "echo ${var.docker-droplet.ipv4_address}"
  }
}