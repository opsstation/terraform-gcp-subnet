# 1. General Information and Identifiers
variable "name" {
  type        = list(string)
  default     = []
  description = "The names of the subnets."
}

variable "multiple_subnets" {
  type        = bool
  default     = false
  description = "Set true for multiple subnets, false for single subnet"
}

variable "network" {
  type        = string
  default     = ""
  description = "The VPC network the subnets belong to."
}

variable "repository" {
  type        = string
  default     = "https://github.com/opsstation/terraform-gcp-subnet.git"
  description = "Terraform current module repo"
}

variable "managedby" {
  type        = string
  default     = "opsstation"
  description = "ManagedBy, opsstation."
}

# 2. Tags and Labels
variable "label_order" {
  type        = list(string)
  default     = ["name", "environment"]
  description = "Order of labels for organizing resources."
}

variable "extra_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for the resource."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g., `prod`, `dev`, `staging`)."
}

# 3. Subnetwork Configuration
variable "ip_cidr_range" {
  type        = list(string)
  default     = [""]
  description = "The range of internal addresses owned by this subnetwork."
}

variable "secondary_ip_ranges" {
  type = map(list(object({
    range_name    = string
    ip_cidr_range = string
  })))
  default     = {}
  description = "Secondary IP ranges for the subnetwork."
}

variable "region" {
  type        = string
  default     = ""
  description = "Google Cloud region for the subnetwork."
}

variable "description" {
  type        = string
  default     = ""
  description = "Optional description of the VPC."
}

variable "purpose" {
  type        = string
  default     = ""
  description = "Purpose of the resource (e.g., PRIVATE_RFC_1918, PRIVATE_SERVICE_CONNECT)."
}

variable "ipv6_access_type" {
  type        = string
  default     = "EXTERNAL"
  description = "IPv6 access type for the subnetwork."
}

variable "stack_type" {
  type        = string
  default     = "IPV4_ONLY"
  description = "Stack type (e.g., IPV4_ONLY, IPV6_ONLY, IPV4_IPV6)."
}

variable "private_ip_google_access" {
  type        = bool
  default     = true
  description = "Enable private IP Google access for the subnetwork."
}

variable "private_ipv6_google_access" {
  type        = bool
  default     = false
  description = "Enable private IPv6 Google access for the subnetwork."
}

# 4. Logging and Timeout Configuration
variable "log_config" {
  description = "Logging options for subnetwork flow logs."
  type = object({
    enable               = optional(bool, false)
    aggregation_interval = optional(string)
    flow_sampling        = optional(number)
    metadata             = optional(string)
    metadata_fields      = optional(list(string))
    filter_expr          = optional(string)
  })
  default = {
    enable               = false
    aggregation_interval = null
    flow_sampling        = null
    metadata             = null
    metadata_fields      = []
    filter_expr          = null
  }
}

variable "module_timeouts" {
  type        = any
  default     = {}
  description = "Timeout configurations for operations."
}

# 5. Router and NAT Configuration
variable "router_enabled" {
  type        = bool
  default     = true
  description = "Enable or disable the router."
}

variable "nat_ip_allocate_option" {
  description = "Specifies how NAT IPs should be allocated. Options are AUTO_ONLY or MANUAL_ONLY."
  type        = string
  default     = "AUTO_ONLY"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  type        = string
  default     = "LIST_OF_SUBNETWORKS"
  description = "NAT configuration per subnetwork."
}

variable "address_enabled" {
  type        = bool
  default     = false
  description = "Enable or disable address functionality."
}

variable "asn" {
  type        = number
  default     = 64514
  description = "Local BGP Autonomous System Number (ASN)."
}

variable "ip_version" {
  type        = string
  default     = "IPV4"
  description = "IP version (IPV4 or IPV6)."
}

variable "udp_idle_timeout_sec" {
  type        = number
  default     = 30
  description = "Timeout for UDP connections (in seconds)."
}

variable "icmp_idle_timeout_sec" {
  type        = number
  default     = 30
  description = "Timeout for ICMP connections (in seconds)."
}

variable "routes" {
  description = "Map of routes to be created"
  type = map(object({
    description            = string
    tags                   = string
    destination_range      = string
    next_hop_internet      = string
    next_hop_ip            = string
    next_hop_instance      = string
    next_hop_instance_zone = string
    next_hop_vpn_tunnel    = string
    next_hop_ilb           = string
    priority               = number
  }))

  default = {
    "route" = {
      description            = "Subnet route to example"
      tags                   = "test1 , test2"
      destination_range      = "0.0.0.0/0" # This defines the destination for the static route
      next_hop_internet      = "true"      # Use default internet gateway
      next_hop_ip            = null        # Empty string as default
      next_hop_instance      = null        # Empty string as default
      next_hop_instance_zone = null        # Empty string as default
      next_hop_vpn_tunnel    = null        # Empty string as default
      next_hop_ilb           = null        # Empty string as default
      priority               = 1000        # Priority for the route
    }
  }
}

variable "bgp_advertise_mode" {
  type        = string
  default     = "CUSTOM"
  description = "BGP advertisement mode (DEFAULT or CUSTOM)."
}

variable "bgp_advertised_groups" {
  type        = list(string)
  default     = []
  description = "List of prefix groups to advertise in custom mode."
}

variable "bgp_advertised_ip_ranges" {
  type = list(object({
    range       = string
    description = string
  }))
  default     = []
  description = "List of individual IP ranges to advertise in custom mode."
}

variable "bgp_keepalive_interval" {
  type        = number
  default     = 20
  description = "Interval in seconds between BGP keepalive messages."
}

variable "encrypted_interconnect_router" {
  type        = bool
  default     = true
  description = "Indicates if the router is dedicated for encrypted VLAN attachments."
}

# 8. Address Configuration
variable "address" {
  type        = list(string)
  default     = []
  description = "List of addresses."
}

variable "address_type" {
  type        = string
  default     = "EXTERNAL"
  description = "Type of address to reserve (INTERNAL or EXTERNAL)."
}

variable "network_tier" {
  type        = string
  default     = "PREMIUM"
  description = "Networking tier (PREMIUM or STANDARD)."
}

variable "subnetwork" {
  type        = string
  default     = null
  description = "URL of the subnetwork to reserve the address in."
}

variable "ipv6_endpoint_type" {
  type        = bool
  default     = null
  description = "Endpoint type of the address (VM or NETLB)."
}

variable "labels" {
  type        = map(string)
  default     = {} # Example key-value pair
  description = "Labels to apply to the address."
}

# 9. NAT Configuration
variable "drain_nat_ips" {
  description = "A list of URLs of the IP resources to be drained. These IPs must be valid static external IPs that have been assigned to the NAT."
  type        = list(string)
  default     = []
}

variable "tcp_established_idle_timeout_sec" {
  type        = number
  default     = 1200
  description = "Timeout for TCP established connections (in seconds)."
}

variable "tcp_transitory_idle_timeout_sec" {
  type        = number
  default     = 30
  description = "Timeout for TCP transitory connections (in seconds)."
}

variable "tcp_time_wait_timeout_sec" {
  type        = number
  default     = 120
  description = "Timeout for TCP connections in TIME_WAIT state (in seconds)."
}

variable "log_enable" {
  type        = bool
  default     = true
  description = "Enable or disable logging for NAT."
}

variable "log_filter" {
  type        = string
  default     = "ALL"
  description = "Log filtering option (ERRORS_ONLY, TRANSLATIONS_ONLY, ALL)."
}