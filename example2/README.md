# Yaml Example 2

This example will show multiple files representing the same object and showing how these are merged into terraform objects.

Two config files have simple settings for tags, resource groups and virtual networks. Adding to the locals to merge the lists from each file.

The `config_data_map` shows two file lists with keys of app1 and app2 with `resource_groups` in the outputs.

The merge is done in the for loop through this data map and uses the filename key as part of the key to keep the map keys unique.

```hcl
  resource_groups = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.resource_groups : "${filekey}-${key}" => value
    }
    if try(contents.resource_groups, null) != null
  ]...)

```

The [merge](https://developer.hashicorp.com/terraform/language/functions/merge) function will merge the map contents and the for loops will filter out lists required. The first for is looping though the config data map looking for the resource_groups content if it exists. Then the inner loop is setting the map key to be the filename and the resource_groups key as the final key to that data.

So instead of the config data map of app1 --> resource_groups --> rg1 nesting the resource_groups map will have app1-rg1 and app2-rg1 as keys.

Data Map:

```hcl
  app1 = {
    resource_groups = {
      rg1 = {
        location = "australiaeast"
        name     = "rg-app1-dev-ae-01"
      }
    }
  }
  app2 = {
    resource_groups = {
      rg1 = {
        location = "australiaeast"
        name     = "rg-app2-dev-ae-01"
      }
    }
  }

```

resource_groups map:

```hcl
  resource_groups = {
    app1-rg1 = {
      location = "australiaeast"
      name     = "rg-app1-dev-ae-01"
    }
    app2-rg1 = {
      location = "australiaeast"
      name     = "rg-app2-dev-ae-01"
    }
  }
```

Now this resource_groups map can be used in a foreach to create resource groups.