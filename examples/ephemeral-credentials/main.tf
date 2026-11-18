terraform {
  required_providers {
    dbaas = { source = "locaweb/dbaas" }
  }
}

provider "dbaas" {}

variable "zone" { type = string }
variable "instance_id" { type = string }
variable "public_ca_file" {
  type        = string
  description = "Absolute local path to the public CA bundle trusted for this PostgreSQL endpoint."
}

ephemeral "dbaas_instance_credentials" "application" {
  zone        = var.zone
  instance_id = var.instance_id
}

# Runs once on creation. No credential value becomes an ordinary resource input.
resource "terraform_data" "connection_check" {
  provisioner "local-exec" {
    command = "psql -X -qAt -v ON_ERROR_STOP=1 -c 'SELECT 1'"
    environment = {
      PGHOST        = ephemeral.dbaas_instance_credentials.application.host
      PGPORT        = tostring(ephemeral.dbaas_instance_credentials.application.port)
      PGDATABASE    = ephemeral.dbaas_instance_credentials.application.database
      PGUSER        = ephemeral.dbaas_instance_credentials.application.username
      PGPASSWORD    = ephemeral.dbaas_instance_credentials.application.password
      PGSSLMODE     = "verify-full"
      PGSSLROOTCERT = var.public_ca_file
    }
  }
}
