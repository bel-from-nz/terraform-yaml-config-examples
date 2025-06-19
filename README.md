# Terraform YAML Config Tutorial

This tutorial will go over the use of YAML and terraform functions for [fileset](https://developer.hashicorp.com/terraform/language/functions/fileset), [yamldecode](https://developer.hashicorp.com/terraform/language/functions/yamldecode) and [templatefile](https://developer.hashicorp.com/terraform/language/functions/templatefile).

Yaml allows easy specification of maps, objects, etc to be decoded from files into locals and used in resource creation and configuration. This is not always required but can be usefull when trying to manage multiple resources with similar layout. For example, Virtual Machines where each yaml can represent a single configuration, or Application Gateway/Front Door where each yaml can represent an application configuration.

## Pre-requisite

- Have terraform [installed](https://developer.hashicorp.com/terraform/install)
- Clone this repos `git clone https://github.com/bel-from-nz/terraform-yaml-config-tutorial.git`

All stages of the tutorial use only local backend and simple providers like [hashicorp/local](https://registry.terraform.io/providers/hashicorp/local/latest) and [hashicorp/random](https://registry.terraform.io/providers/hashicorp/random/latest).

To run each stage:

- Change to the stage directory
- terraform init
- terraform plan
- terraform apply

Follow the README in each stage directory:

- [Stage1](https://github.com/bel-from-nz/terraform-yaml-config-tutorial/tree/main/yaml-stage1)
