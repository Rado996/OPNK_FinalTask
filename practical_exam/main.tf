# --- root/main.tf ---

data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

data "cloudinit_config" "user_data" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    filename     = "userdata_base"
    content      = file("${path.module}/scripts/base.sh")
  }

    part {
    content_type = "text/x-shellscript"
    filename     = "userdata_helm"
    content      = file("${path.module}/scripts/start.sh")
  }
}

resource "openstack_compute_keypair_v2" "keypair" {
  name = "${local.project}-${var.environment}-keypair"
}

resource "local_file" "private_key" {
  content         = openstack_compute_keypair_v2.keypair.private_key
  filename        = "${path.module}/${openstack_compute_keypair_v2.keypair.name}.pem"
  file_permission = "0400"
}

module "instance" {
  source        = "./compute"
  project       = local.project
  environment   = var.environment
  my_ip  = data.http.my_ip.response_body
  key_name = openstack_compute_keypair_v2.keypair.name
  flavor_name   = var.flavor_name
  user_data     = data.cloudinit_config.user_data.rendered
}