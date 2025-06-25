locals {

  templatefile_vars = {
    env              = var.environment
    short_location   = var.short_location_code
    default_location = var.location
    app_list         = var.app_list
  }

  yaml_data_dir = "${path.root}/config"

  /*
    Fileset is based on DoubleStar : https://github.com/bmatcuk/doublestar

    This will find all yaml files in the yaml_data_dir and any subfolders
  */
  yaml_files = fileset(local.yaml_data_dir, "**/*.yaml")

  config_data_map = {
    for f in local.yaml_files :
    replace(split(".", f)[0], "/", "-") => yamldecode(templatefile("${local.yaml_data_dir}/${f}", local.templatefile_vars))
  }

  resource_groups = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.resource_groups : "${filekey}-${key}" => value
    }
    if try(contents.resource_groups, null) != null
  ]...)

  virtual_networks = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.virtual_networks : "${filekey}-${key}" => merge(
        value,
        { resource_group_name = local.resource_groups[value.resource_group_key].name }
      )
    }
    if try(contents.virtual_networks, null) != null
  ]...)

}
