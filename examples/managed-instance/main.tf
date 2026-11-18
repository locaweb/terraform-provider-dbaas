terraform {
  required_providers {
    dbaas = { source = "locaweb/dbaas" }
  }
}

provider "dbaas" {}

variable "zone" { type = string }
variable "engine_version" { type = string }
variable "plan" { type = string }
variable "topology" { type = string }
variable "storage_gib" { type = number }
variable "source_cidrs" { type = set(string) }

resource "dbaas_instance" "application" {
  name         = "application-db"
  zone         = var.zone
  engine       = "postgresql"
  version      = var.engine_version
  plan         = var.plan
  topology     = var.topology
  storage_gib  = var.storage_gib
  source_cidrs = var.source_cidrs

  lifecycle {
    prevent_destroy = true
  }
}

output "host" { value = dbaas_instance.application.connection_info.host }
output "port" { value = dbaas_instance.application.connection_info.port }
