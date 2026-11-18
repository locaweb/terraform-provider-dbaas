terraform {
  required_providers {
    dbaas = {
      source = "locaweb/dbaas"
    }
  }
}

# Reads CLOUDSTACK_API_URL, CLOUDSTACK_API_KEY, CLOUDSTACK_SECRET_KEY.
provider "dbaas" {}

variable "zone" {
  type        = string
  description = "Exact configured DBaaS zone name or UUID."
}

data "dbaas_zone" "selected" {
  zone = var.zone
}

data "dbaas_catalog" "selected" {
  zone = data.dbaas_zone.selected.id
}

data "dbaas_instances" "selected" {
  zone = data.dbaas_zone.selected.id
}

data "dbaas_quota" "selected" {
  zone = data.dbaas_zone.selected.id
}

output "engines" {
  value = data.dbaas_catalog.selected.engines
}

output "instances" {
  value = data.dbaas_instances.selected.instances
}

output "remaining_quota" {
  value = data.dbaas_quota.selected.remaining
}
