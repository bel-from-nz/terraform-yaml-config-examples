# Yaml Example 4

This example will continue from example 3 but add in more complicated template language elements

``` bash

terraform plan -var-file="environments/dev.terraform.tfvars"
terraform plan -var-file="environments/test.terraform.tfvars"
```

The template language uses terraform statements such as the for:

```yaml

  %{~ for key, data in app_list ~}
  rg_${key}:
    name: rg-${data.name_part}-${env}-${short_location}-01
    location: ${default_location}
  %{~ endfor ~}

```

Also the conditional `if`:

```yaml
  %{~ if subnet.service_endpoints_enabled ~}
  service_endpoints:
    %{~ for se in subnet.service_endpoints ~}
    - ${se}
    %{~ endfor ~}
  %{~ endif ~}
```

Functions from terraform language can also be used:

```yaml

## lower function is used here assuming the environment was Dev
name: az-${lower(environment)}-01

## this is using the split function
sub_id: ${split("/", resource_id)[2]}

## also replace
name: test-${replace(key,"_","-")}

```