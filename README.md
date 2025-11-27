# 🏗️ Terraform-google-Subnet

[![OpsStation](https://img.shields.io/badge/Made%20by-OpsStation-blue?style=flat-square&logo=terraform)](https://www.opsstation.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.13%2B-purple.svg?logo=terraform)](#)
[![CI](https://github.com/OpsStation/terraform-multicloud-labels/actions/workflows/ci.yml/badge.svg)](https://github.com/OpsStation/terraform-multicloud-labels/actions/workflows/ci.yml)
[![Latest Release](https://img.shields.io/github/release/opsstation/terraform-gcp-vpc.svg)](https://github.com/opsstation/terraform-gcp-vpc/releases/latest)

> 🌩️ **A production-grade, reusable GCP Subnet module by [OpsStation](https://www.opsstation.com)**
> Designed for reliability, performance, and security — following GCP networking best practices.
---

## 🏢 About OpsStation

**OpsStation** delivers **Cloud & DevOps excellence** for modern teams:
- 🚀 **Infrastructure Automation** with Terraform, Ansible & Kubernetes
- 💰 **Cost Optimization** via scaling & right-sizing
- 🛡️ **Security & Compliance** baked into CI/CD pipelines
- ⚙️ **Fully Managed Operations** across GCP, Azure, and AWS

> 💡 Need enterprise-grade DevOps automation?
> 👉 Visit [**www.opsstation.com**](https://www.opsstation.com) or email **hello@opsstation.com**

---
🌟 Features

✅ Creates Subnet networks and subnets with full configuration options (custom MTU, routing mode, IPv6, and more)

✅ Supports auto or custom subnet modes with conditional resource creation

✅ Integrated with Google Cloud IAM and project data using google_client_config

✅ Optional Shared Subnet support (host/service project configuration)

✅ Supports **custom labels** using [OpsStation multicloud module](https://registry.terraform.io/modules/opsstation/labels/multicloud/latest)

✅ Supports private/public subnet logic, NAT setup, and external IP allocation

✅ Configurable router, route, and log settings

✅ Modular and reusable for multiple environments (dev, stage, prod)

---


## ⚙️ Usage Example

## Example: single


```hcl
module "subnet" {
  source        = "opsstation/subnet/gcp"
  version       = "1.0.1"
  name          = ["dev"]
  environment   = "test"
  region        = "asia-northeast1"
  network       = module.vpc.vpc_id
  ip_cidr_range = ["10.10.1.0/24"]
  log_config = {
    enable               = true
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    metadata_fields      = []
    filter_expr          = null
  }
}
```

## Example: public-private

```hcl
module "subnet" {
  source           = "opsstation/subnet/gcp"
  version          = "1.0.1"
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
log_config = {
  enable               = true
  aggregation_interval = "INTERVAL_5_MIN"
  flow_sampling        = 0.5
  metadata             = "INCLUDE_ALL_METADATA"
  metadata_fields      = []
  filter_expr          = null
}
}

```

### ☁️ Outputs (GCP Subnet Module)

| Name                          | Description                                    |
| ----------------------------- | ---------------------------------------------- |
| `subnet_id`                   | The ID of the GCP subnetwork.                  |
| `subnet_name`                 | The name of the GCP subnetwork.                |
| `subnet_creation_timestamp`   | The timestamp when the subnetwork was created. |
| `subnet_gateway_address`      | The gateway address of the subnetwork.         |
| `subnet_ipv6_cidr_range`      | The IPv6 CIDR range of the subnetwork.         |
| `subnet_external_ipv6_prefix` | The external IPv6 prefix of the subnetwork.    |
| `subnet_self_link`            | The self-link of the subnetwork.               |

### 🛣️ Outputs (GCP  Route  Module)

| Name                     | Description                                   |
| ------------------------ | --------------------------------------------- |
| `route_id`               | The name of the GCP route.                    |
| `route_next_hop_network` | The next hop network or gateway of the route. |
| `route_self_link`        | The self-link of the GCP route.               |


### ⚙️ Outputs (GCP Router Module)

| Name                        | Description                           |
| --------------------------- | ------------------------------------- |
| `router_id`                 | The ID of the GCP Cloud Router.       |
| `router_creation_timestamp` | The creation timestamp of the router. |
| `router_self_link`          | The self-link of the router.          |


### 🌍 Outputs (GCP Address (IP) Module)

| Name                         | Description                                     |
| ---------------------------- | ----------------------------------------------- |
| `address_name`               | The name of the reserved IP address.            |
| `address_project`            | The project in which the address is created.    |
| `address_region`             | The region of the address.                      |
| `address_id`                 | The ID of the reserved IP address.              |
| `address_self_link`          | The self-link of the address.                   |
| `address_users`              | The resources currently using the address.      |
| `address_label_fingerprint`  | The label fingerprint for optimistic locking.   |
| `address_terraform_labels`   | The directly configured labels on the resource. |
| `address_effective_labels`   | All effective labels applied on the resource.   |
| `address_creation_timestamp` | The creation timestamp of the address.          |

### 🚦 Outputs (GCP Router NAT Module)

| Name                | Description                                       |
| ------------------- | ------------------------------------------------- |
| `router_nat_id`     | The ID of the router NAT configuration.           |
| `router_nat_name`   | The name of the router NAT configuration.         |
| `router_nat_router` | The router associated with the NAT configuration. |
| `router_nat_region` | The region of the router NAT configuration.       |

---
### ☁️ Tag Normalization Rules (GCP)

| Cloud | Case      | Allowed Characters | Example                            |
|--------|-----------|------------------|------------------------------------|
| **GCP** | TitleCase | Any              | `Name`, `Environment`, `CostCenter` |