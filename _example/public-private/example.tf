provider "google" {
  project = "opsstation-474608"
  region  = "us-west1"
  zone    = "asia-northeast1-a"
}

module "vpc" {
  source                                    = "opsstation/vpc/gcp"
  version                                   = "1.0.1"
  name                                      = "vpc"
  environment                               = "OpsStation"
  label_order                               = ["name", "environment"]
  mtu                                       = 1460
  routing_mode                              = "REGIONAL"
  network_enabled                           = true
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  delete_default_routes_on_create           = false
}


#===============================(subnet)=================================
module "subnet" {
  source = "../.."
  name = [
    "subnet-public-1",
    "subnet-public-2",
    "subnet-public-3",
    "subnet-private-1",
    "subnet-private-2",
    "subnet-private-3"
  ]
  environment      = "nonprod"
  region           = "asia-northeast1"
  subnet_type      = ["public", "public", "public", "private", "private", "private"]
  network          = module.vpc.vpc_id
  ip_cidr_range    = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
  multiple_subnets = true
}
