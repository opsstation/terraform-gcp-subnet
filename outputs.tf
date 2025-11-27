# Outputs for google_compute_subnetwork
output "subnet_id" {
  description = "The ID of the GCP subnetwork."
  value       = join("", google_compute_subnetwork.subnetwork[*].id)
}

output "subnet_self_link_private" {
  description = "The self-link of the GCP private subnetwork."
  value       = length(google_compute_subnetwork.subnetwork) > 1 ? google_compute_subnetwork.subnetwork[1].self_link : null
}

output "subnet_self_link_public" {
  description = "The self-link of the GCP public subnetwork."
  value = (
    local.public_subnet_key != null
    ? local.subnet_map[local.public_subnet_key]
    : google_compute_subnetwork.subnetwork[0].self_link
  )
}

output "subnet_name" {
  description = "The name of the GCP subnetwork."
  value       = join("", google_compute_subnetwork.subnetwork[*].name)
}

output "subnet_creation_timestamp" {
  description = "The timestamp when the GCP subnetwork was created."
  value       = join("", google_compute_subnetwork.subnetwork[*].creation_timestamp)
}

output "subnet_gateway_address" {
  description = "The gateway address of the GCP subnetwork."
  value       = join("", google_compute_subnetwork.subnetwork[*].gateway_address)
}

output "subnet_ipv6_cidr_range" {
  description = "The IPv6 CIDR range of the GCP subnetwork."
  value       = join("", google_compute_subnetwork.subnetwork[*].ipv6_cidr_range)
}

output "subnet_external_ipv6_prefix" {
  description = "The external IPv6 prefix of the GCP subnetwork."
  value       = join("", google_compute_subnetwork.subnetwork[*].external_ipv6_prefix)
}


# Outputs for google_compute_route
output "route_id" {
  description = "The name of the GCP route."
  value       = [for r in google_compute_route.route : r.name]
}

output "route_next_hop_network" {
  description = "The next hop network of the GCP route."
  value       = [for r in google_compute_route.route : r.next_hop_gateway]
}

output "route_self_link" {
  description = "The self-link of the GCP route."
  value       = [for r in google_compute_route.route : r.self_link]
}

# Outputs for google_compute_router
output "router_id" {
  description = "The ID of the GCP router."
  value       = [for r in google_compute_router.router : r.id]
}

output "router_creation_timestamp" {
  description = "The timestamp when the GCP router was created."
  value       = join("", google_compute_router.router[*].creation_timestamp)
}

output "router_self_link" {
  description = "The self-link of the GCP router."
  value       = join("", google_compute_router.router[*].self_link)
}

# Outputs for google_compute_address
output "address_name" {
  description = "The name of the GCP address."
  value       = length(google_compute_address.address) > 0 ? join("", google_compute_address.address[*].name) : ""
}

output "address_project" {
  description = "The project of the GCP address."
  value       = length(google_compute_address.address) > 0 ? join("", google_compute_address.address[*].project) : ""
}

output "address_region" {
  description = "The region of the GCP address."
  value       = length(google_compute_address.address) > 0 ? join("", google_compute_address.address[*].region) : ""
}

output "address_id" {
  description = "The ID of the GCP address."
  value       = length(google_compute_address.address) > 0 ? join("", google_compute_address.address[*].id) : ""
}

output "address_self_link" {
  description = "The self_link of the GCP address."
  value       = length(google_compute_address.address) > 0 ? join("", google_compute_address.address[*].self_link) : ""
}

output "address_users" {
  description = "The resources using this address."
  value       = length(google_compute_address.address) > 0 ? google_compute_address.address[0].users : []
}

output "address_label_fingerprint" {
  description = "The fingerprint used for optimistic locking."
  value       = length(google_compute_address.address) > 0 ? join("", google_compute_address.address[*].label_fingerprint) : ""
}

output "address_terraform_labels" {
  description = "Labels that are directly configured on the resource."
  value       = length(google_compute_address.address) > 0 ? join(", ", [for k, v in google_compute_address.address[0].terraform_labels : "${k}=${v}"]) : ""
}

output "address_effective_labels" {
  description = "All labels (key/value pairs) currently applied to the resource."
  value       = length(google_compute_address.address) > 0 ? join(", ", [for k, v in google_compute_address.address[0].effective_labels : "${k}=${v}"]) : ""
}

output "address_creation_timestamp" {
  description = "Creation timestamp of the GCP address in RFC3339 format."
  value       = length(google_compute_address.address) > 0 ? join("", google_compute_address.address[*].creation_timestamp) : ""
}

# Outputs for google_compute_router_nat
output "router_nat_id" {
  description = "The project of the GCP router NAT configuration."
  value       = join("", google_compute_router_nat.nat[*].id)
}

output "router_nat_name" {
  description = "The name of the GCP router NAT configuration."
  value       = join("", google_compute_router_nat.nat[*].name)
}

output "router_nat_router" {
  description = "The router associated with the GCP router NAT configuration."
  value       = join("", google_compute_router_nat.nat[*].router)
}

output "router_nat_region" {
  description = "The region of the GCP router NAT configuration."
  value       = join("", google_compute_router_nat.nat[*].region)
}