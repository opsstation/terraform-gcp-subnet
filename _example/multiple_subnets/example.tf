provider "google" {
  project = "opsstation"
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
  name             = ["subnet-a", "subnet-b"]
  environment      = "test"
  region           = "asia-northeast1"
  network          = module.vpc.vpc_id
  ip_cidr_range    = ["10.10.1.0/24", "10.10.5.0/24"]
  multiple_subnets = true
}