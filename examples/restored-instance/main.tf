terraform {
  required_providers {
    dbaas = { source = "locaweb/dbaas" }
  }
}

provider "dbaas" {}

variable "zone" { type = string }
variable "source_instance_id" { type = string }
# Record the source settings for this restore. The destination is independently
# managed afterward; do not continuously copy future source changes into it.
variable "engine" { type = string }
variable "engine_version" { type = string }
variable "plan" { type = string }
variable "topology" { type = string }
variable "storage_gib" { type = number }
variable "source_cidrs" { type = set(string) }
variable "target_time" {
  type        = string
  default     = null
  description = "Optional catalog-supported RFC3339 recovery time. Null selects latest recovery."
}

resource "dbaas_instance" "restored" {
  name         = "restored-application-db"
  zone         = var.zone
  engine       = var.engine
  version      = var.engine_version
  plan         = var.plan
  topology     = var.topology
  storage_gib  = var.storage_gib
  source_cidrs = var.source_cidrs
  restore = {
    source_instance_id = var.source_instance_id
    target_time        = var.target_time
  }
  lifecycle {
    prevent_destroy = true
  }
}
