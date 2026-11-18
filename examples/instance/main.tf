terraform {
  required_providers {
    dbaas = {
      source = "locaweb/dbaas"
    }
  }
}

# Supply customer API credentials through the environment or a CloudMonkey profile.
provider "dbaas" {}

variable "zone" {
  type        = string
  description = "Exact configured DBaaS zone name or UUID."
}

variable "instance_id" {
  type        = string
  description = "Existing authorized DBaaS instance ID."
}

data "dbaas_instance" "existing" {
  zone = var.zone
  id   = var.instance_id
}

# Connection metadata is null until the instance is Ready.
output "host" {
  value = try(data.dbaas_instance.existing.connection_info.host, null)
}

output "port" {
  value = try(data.dbaas_instance.existing.connection_info.port, null)
}

output "ca_certificate" {
  value = try(data.dbaas_instance.existing.connection_info.ca_certificate, null)
}
