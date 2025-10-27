provider "google" {
  project = "opsstation-474608"
  region  = "us-west1"
  zone    = "asia-northeast1-a"
}

module "vpc" {
  source                                    = "git::git@github.com:opsstation/terraform-gcp-vpc.git?ref=feat/release-1"
  name                                      = "dev"
  environment                               = "test"
  routing_mode                              = "REGIONAL"
  mtu                                       = 1500
  network_firewall_policy_enforcement_order = "BEFORE_CLASSIC_FIREWALL"
}

#===============================(subnet)=================================
module "subnet" {
  source           = "../.."
  name             = ["subnet-public-1", "subnet-public-2", "subnet-public-3", "subnet-private-1", "subnet-private-2", "subnet-private-3"]
  environment      = "nonprod"
  region           = "asia-northeast1"
  subnet_type      = ["public", "public", "public", "private", "private", "private"]
  network          = module.vpc.vpc_id
  ip_cidr_range    = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
  multiple_subnets = true
}
