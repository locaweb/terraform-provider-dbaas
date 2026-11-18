# Locaweb Cloud DBaaS provider

Terraform and OpenTofu provider for managed databases on
[Locaweb Cloud](https://www.locaweb.com.br/locaweb-cloud/).

```terraform
terraform {
  required_providers {
    dbaas = {
      source  = "locaweb/dbaas"
      version = "~> 0.1"
    }
  }
}

provider "dbaas" {}
```

Run `terraform init` or `tofu init`. The provider authenticates with your
Locaweb Cloud customer API credentials through `CLOUDSTACK_API_URL`,
`CLOUDSTACK_API_KEY` and `CLOUDSTACK_SECRET_KEY`.

- Documentation: [docs](docs/index.md), also rendered by the
  [Terraform Registry](https://registry.terraform.io/providers/locaweb/dbaas/latest/docs)
  and [OpenTofu Registry](https://search.opentofu.org/provider/locaweb/dbaas/latest).
- Examples: [examples](examples).
- Releases are published for Linux (amd64, arm64), macOS (amd64, arm64) and
  Windows (amd64), with checksums signed by the Locaweb Cloud release key.

This repository distributes releases and documentation. Development happens in
Locaweb's internal repository; the provider is licensed under [MPL-2.0](LICENSE).
