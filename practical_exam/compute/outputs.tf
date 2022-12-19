# --- compute/outputs.tf ---

output "instance_name" {
  value = openstack_compute_instance_v2.instance.name
}