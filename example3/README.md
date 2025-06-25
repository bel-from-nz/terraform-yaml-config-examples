# Yaml Example 3

This example will continue from example 2 but add in template variables for [templatefile](https://developer.hashicorp.com/terraform/language/functions/templatefile) replacements.

Also environments will be added to demonstrate the ability to have yaml config files modified based on environment variables.

``` bash

terraform plan -var-file="environments/dev.terraform.tfvars"
terraform plan -var-file="environments/test.terraform.tfvars"
```

This example also demonstrates the use of keys to reference other elements in the config.

```yaml
resource_groups:
  rg1:
    name: rg-app1-${environment}-${short_location}-01
    location: ${default_location}

## key is file name then map key to in this case the file is app1 and the resource group map key is rg1
## this allows the key to be used to reference information in the resource_groups list
virtual_networks:
  v1:
    name: vnet-app1-${environment}-${short_location}-01
    resource_group_key: app1-rg1
```

This uses a merge in the locals to combine the virtual_networks map with the resource group name. This can also be used to reference any other map such as output from a foreach resource creation or data fetch. Note that in a merge of two maps any duplicate keys are replaced by the later item in the merge.

```HCL
    for key, value in contents.virtual_networks : "${filekey}-${key}" => merge(
      value,
      { resource_group_name = local.resource_groups[value.resource_group_key].name }
    )
```
