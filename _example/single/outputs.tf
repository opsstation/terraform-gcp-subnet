output "subnet_id" {
  description = "The ID of the GCP subnetwork."
  value       = module.subnet.subnet_id
}

output "subnet_name" {
  description = "The name of the GCP subnetwork."
  value       = module.subnet.subnet_name
}

output "subnet_creation_timestamp" {
  description = "The timestamp when the GCP subnetwork was created."
  value       = module.subnet.subnet_creation_timestamp
}

output "subnet_gateway_address" {
  description = "The gateway address of the GCP subnetwork."
  value       = module.subnet.subnet_gateway_address
}

output "subnet_ipv6_cidr_range" {
  description = "The IPv6 CIDR range of the GCP subnetwork."
  value       = module.subnet.subnet_ipv6_cidr_range
}

output "subnet_external_ipv6_prefix" {
  description = "The external IPv6 prefix of the GCP subnetwork."
  value       = module.subnet.subnet_external_ipv6_prefix
}

output "subnet_self_link_public" {
  description = "The self-link of the GCP public subnetwork."
  value       = module.subnet.subnet_self_link_public
}

output "subnet_self_link_priavte" {
  description = "The self-link of the GCP priavte subnetwork."
  value       = module.subnet.subnet_self_link_private
}

output "route_id" {
  description = "The ID of the GCP route associated with the subnetwork."
  value       = module.subnet.route_id
}

output "route_next_hop_network" {
  description = "The next hop network of the GCP route associated with the subnetwork."
  value       = module.subnet.route_next_hop_network
}

output "route_self_link" {
  description = "The self-link of the GCP route associated with the subnetwork."
  value       = module.subnet.route_self_link
}

output "router_id" {
  description = "The ID of the GCP router associated with the subnetwork."
  value       = module.subnet.router_id
}

output "router_creation_timestamp" {
  description = "The timestamp when the GCP router associated with the subnetwork was created."
  value       = module.subnet.router_creation_timestamp
}

output "router_self_link" {
  description = "The self-link of the GCP router associated with the subnetwork."
  value       = module.subnet.router_self_link
}

output "address_name" {
  description = "The name of the GCP address associated with the subnetwork."
  value       = module.subnet.address_name
}

output "address_project" {
  description = "The project of the GCP address associated with the subnetwork."
  value       = module.subnet.address_project
}

output "address_region" {
  description = "The region of the GCP address associated with the subnetwork."
  value       = module.subnet.address_region
}

output "address_id" {
  description = "The ID of the GCP address in the format: projects/{{project}}/regions/{{region}}/addresses/{{name}}"
  value       = module.subnet.address_id
}

output "address_self_link" {
  description = "The self_link of the GCP address resource."
  value       = module.subnet.address_self_link
}

output "address_users" {
  description = "The resources using this address."
  value       = module.subnet.address_users
}

output "address_label_fingerprint" {
  description = "The fingerprint used for optimistic locking."
  value       = module.subnet.address_label_fingerprint
}

output "address_terraform_labels" {
  description = "Labels configured directly on the resource and default labels."
  value       = module.subnet.address_terraform_labels
}

output "address_effective_labels" {
  description = "All labels (key/value pairs) present on the resource."
  value       = module.subnet.address_effective_labels
}

output "address_creation_timestamp" {
  description = "Creation timestamp of the GCP address in RFC3339 format."
  value       = module.subnet.address_creation_timestamp
}

output "router_nat_name" {
  description = "The name of the GCP router NAT configuration associated with the subnetwork."
  value       = module.subnet.router_nat_name
}

output "router_nat_router" {
  description = "The router associated with the GCP router NAT configuration."
  value       = module.subnet.router_nat_router
}

output "router_nat_id" {
  description = "The ID of the GCP router NAT configuration."
  value       = module.subnet.router_nat_id
}

output "router_nat_region" {
  description = "The region of the GCP router NAT configuration."
  value       = module.subnet.router_nat_region
}