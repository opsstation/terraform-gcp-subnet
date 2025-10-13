module "labels" {
  source      = "git::git@github.com:opsstation/terraform-gcp-labels.git?ref=update/module"
  count       = length(var.name) > 0 ? length(var.name) : 0
  name        = var.name[count.index]
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
  repository  = var.repository
  extra_tags  = var.extra_tags
}


data "google_client_config" "current" {
}
#####==============================================================================
##### Each VPC network is subdivided into subnets, and each subnet is contained
##### within a single region. You can have more than one subnet in a region for
##### a given VPC network.
#####==============================================================================
#tfsec:ignore:google-compute-enable-vpc-flow-logs
resource "google_compute_subnetwork" "subnetwork" {
  count = var.multiple_subnets == true ? (length(var.name) > 0 && length(var.ip_cidr_range) > 0 ? min(length(var.name), length(var.ip_cidr_range)) : 0) : 1

  name          = var.multiple_subnets == true ? "${var.name[count.index]}-${module.labels[count.index].environment}" : "${var.name[0]}-${module.labels[0].environment}"
  project       = data.google_client_config.current.project
  network       = var.network
  region        = var.region
  description   = var.description
  purpose       = var.purpose
  stack_type    = var.stack_type
  ip_cidr_range = var.multiple_subnets == true ? var.ip_cidr_range[count.index] : var.ip_cidr_range[0]

  ipv6_access_type           = var.stack_type == "IPV4_ONLY" ? null : var.ipv6_access_type
  private_ip_google_access   = var.private_ip_google_access == true ? true : false
  private_ipv6_google_access = var.private_ipv6_google_access == true ? true : "DISABLE_GOOGLE_ACCESS"

  dynamic "secondary_ip_range" {
    for_each = var.multiple_subnets == true && contains(keys(var.secondary_ip_ranges), var.name[count.index]) ? var.secondary_ip_ranges[var.name[count.index]] : []
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }

  dynamic "log_config" {
    for_each = var.log_config.enable == true ? [var.log_config] : []
    content {
      aggregation_interval = var.log_config.aggregation_interval
      flow_sampling        = var.log_config.flow_sampling
      metadata             = var.log_config.metadata
      metadata_fields      = var.log_config.metadata_fields
      filter_expr          = var.log_config.filter_expr
    }
  }

  dynamic "timeouts" {
    for_each = try([var.module_timeouts.google_compute_subnetwork], [])
    content {
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}

#####==============================================================================
##### Route resource
#####==============================================================================
resource "google_compute_route" "route" {
  count       = var.router_enabled == true ? (var.multiple_subnets == true ? length(var.name) : 1) : 0
  project     = data.google_client_config.current.project
  network     = var.network
  name        = var.multiple_subnets == true ? "${var.name[count.index]}-route-${module.labels[count.index].environment}" : "${var.name[0]}-route-${module.labels[0].environment}"
  description = lookup(var.routes[element(keys(var.routes), count.index)], "description", null)
  tags        = null
  dest_range  = lookup(var.routes[element(keys(var.routes), count.index)], "destination_range", null)

  next_hop_gateway       = lookup(var.routes[element(keys(var.routes), count.index)], "next_hop_internet", "false") == "true" ? "default-internet-gateway" : null
  next_hop_ip            = lookup(var.routes[element(keys(var.routes), count.index)], "next_hop_ip", null)
  next_hop_instance      = lookup(var.routes[element(keys(var.routes), count.index)], "next_hop_instance", null)
  next_hop_instance_zone = lookup(var.routes[element(keys(var.routes), count.index)], "next_hop_instance_zone", null)
  next_hop_vpn_tunnel    = lookup(var.routes[element(keys(var.routes), count.index)], "next_hop_vpn_tunnel", null)
  next_hop_ilb           = lookup(var.routes[element(keys(var.routes), count.index)], "next_hop_ilb", null)
  priority               = lookup(var.routes[element(keys(var.routes), count.index)], "priority", null)
}

#####==============================================================================
##### Router resource
#####==============================================================================
resource "google_compute_router" "router" {
  count       = var.multiple_subnets == true ? length(var.name) : 1
  name        = var.multiple_subnets == true ? format("%s-router", module.labels[count.index].id) : format("%s-router", module.labels[0].id)
  project     = data.google_client_config.current.project
  region      = var.region
  network     = var.network
  description = var.description

  bgp {
    asn                = var.asn
    advertise_mode     = var.bgp_advertise_mode
    advertised_groups  = var.bgp_advertised_groups
    keepalive_interval = var.bgp_keepalive_interval

    dynamic "advertised_ip_ranges" {
      for_each = var.bgp_advertised_ip_ranges
      content {
        range       = advertised_ip_ranges.value.range
        description = advertised_ip_ranges.value.description
      }
    }
  }

  encrypted_interconnect_router = var.encrypted_interconnect_router == true ? true : false
}

#####==============================================================================
##### Address resource
#####==============================================================================
resource "google_compute_address" "address" {
  count        = var.address_enabled == true ? (var.multiple_subnets == true ? length(var.name) : 1) : 0
  name         = var.multiple_subnets == true ? format("%s-address", module.labels[count.index].id) : format("%s-address", module.labels[0].id)
  ip_version   = var.ip_version
  project      = data.google_client_config.current.project
  region       = var.region
  address      = length(var.address) > 0 ? (var.multiple_subnets == true ? element(var.address, count.index) : element(var.address, 0)) : null
  address_type = var.address_type
  labels       = var.labels
  description  = try(element(var.description, count.index), null)

  network    = var.address_type == "INTERNAL" ? var.network : null
  subnetwork = var.address_type == "INTERNAL" ? (var.multiple_subnets == true ? var.subnetwork : var.subnetwork[0]) : null
  purpose    = var.address_type == "INTERNAL" ? var.purpose : null

  ipv6_endpoint_type = var.ip_version == "IPV6" ? var.ipv6_endpoint_type : null
  network_tier       = var.address_type == "EXTERNAL" ? var.network_tier : null
}

#####==============================================================================
##### NAT resource
#####==============================================================================
resource "google_compute_router_nat" "nat" {
  count                  = var.multiple_subnets == true ? length(var.name) : 1
  name                   = var.multiple_subnets == true ? format("%s-router-nat", module.labels[count.index].id) : format("%s-router-nat", module.labels[0].id)
  router                 = google_compute_router.router[count.index].name
  region                 = var.region
  project                = data.google_client_config.current.project
  nat_ip_allocate_option = var.nat_ip_allocate_option

  nat_ips                            = var.nat_ip_allocate_option == "MANUAL_ONLY" && var.address_enabled == true ? compact([google_compute_address.address[count.index].self_link]) : []
  drain_nat_ips                      = var.drain_nat_ips
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  udp_idle_timeout_sec               = var.udp_idle_timeout_sec
  icmp_idle_timeout_sec              = var.icmp_idle_timeout_sec
  tcp_established_idle_timeout_sec   = var.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec    = var.tcp_transitory_idle_timeout_sec
  tcp_time_wait_timeout_sec          = var.tcp_time_wait_timeout_sec

  log_config {
    enable = var.log_enable == true ? true : false
    filter = var.log_filter
  }

  subnetwork {
    name                    = google_compute_subnetwork.subnetwork[count.index].self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
