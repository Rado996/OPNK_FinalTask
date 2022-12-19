# --- compute/main.tf ---

resource "openstack_networking_secgroup_v2" "security_group" {
  name        = "secgroup-${var.project}"
  description = "Security group"
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  description       = "All ICMP"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "sudp" {
  description       = "ALL UDP"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

resource "openstack_networking_secgroup_rule_v2" "tcp" {
  description       = "ALL TCP"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# get id of available flavor
data "openstack_compute_flavor_v2" "flavor_id" {
  name = var.flavor_name
}

# get id of available image
data "openstack_images_image_v2" "image_id" {
  name = ubuntu_server_20.04_Openstack
}

resource "openstack_compute_instance_v2" "instance" {
  name            = "${var.project}-${var.environment}-instance"
  image_id        = data.openstack_images_image_v2.image_id.id
  flavor_id       = data.openstack_compute_flavor_v2.flavor_id.id
  key_pair        = var.key_name
  security_groups = [openstack_networking_secgroup_v2.security_group.name]

  user_data = var.user_data

  network {
    name = "ext-net"
  }
}