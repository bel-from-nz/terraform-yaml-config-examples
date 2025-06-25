# Terraform YAML Config Examples

These examples will go over the use of YAML and terraform functions for [fileset](https://developer.hashicorp.com/terraform/language/functions/fileset), [yamldecode](https://developer.hashicorp.com/terraform/language/functions/yamldecode) and [templatefile](https://developer.hashicorp.com/terraform/language/functions/templatefile).

Yaml allows easy specification of maps, objects, etc to be decoded from files into locals and used in resource creation and configuration. This is not always required but can be usefull when trying to manage multiple resources with similar layout. For example, Virtual Machines where each yaml can represent a single configuration, or Application Gateway/Front Door where each yaml can represent an application configuration.

## Pre-requisite

- Have terraform [installed](https://developer.hashicorp.com/terraform/install)
- Clone this repos `git clone https://github.com/bel-from-nz/terraform-yaml-config-examples.git`

To demonstrate each example:

- Change to the example directory
- terraform init
- terraform plan
  - if there are tfvar files then follow the readme directions
- terraform apply

Follow the README in each example directory:

- [Example 1](https://github.com/bel-from-nz/terraform-yaml-config-examples/blob/main/example1/README.md)
- [Example 2](https://github.com/bel-from-nz/terraform-yaml-config-examples/blob/main/example2/README.md)
- [Example 3](https://github.com/bel-from-nz/terraform-yaml-config-examples/blob/main/example3/README.md)
- [Example 4](https://github.com/bel-from-nz/terraform-yaml-config-examples/blob/main/example4/README.md)
