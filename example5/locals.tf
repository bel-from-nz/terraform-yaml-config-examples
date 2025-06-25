locals {

  env_code       = lower(var.environment)
  default_suffix = "${local.env_code}-${var.short_location_code}-01"

  waf_name_pattern = "fdfp%s${replace(local.default_suffix, "-", "")}" ## Front door WAF is alphanumerics only


  yaml_data_dir = "${path.root}/environments/${var.environment}"

  /*
    Fileset is based on DoubleStar : https://github.com/bmatcuk/doublestar

    This will find all yaml files in the yaml_data_dir and any subfolders
  */
  yaml_files = fileset(local.yaml_data_dir, "**/*.yaml")

  config_data_map = {
    for f in local.yaml_files :
    replace(split(".", f)[0], "/", "-") => yamldecode(file("${local.yaml_data_dir}/${f}"))
  }

  front_door_firewall_policies = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.front_door_firewall_policies : "${filekey}-${key}" => {
        name                       = format(local.waf_name_pattern, value.name_part)
        resource_group_name        = var.resource_group_name
        sku_name                   = "Premium_AzureFrontDoor"
        enabled                    = true
        mode                       = value.mode
        request_body_check_enabled = try(value.request_body_check_enabled, true)
        redirect_url               = try(value.redirect_url, null)
        custom_rules               = try(value.custom_rules, {})
        managed_rules              = try(value.managed_rules, {})
      }
    }
    if try(contents.front_door_firewall_policies, null) != null
  ]...)

  front_door_security_policies = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.front_door_security_policies : "${filekey}-${key}" => value
    }
    if try(contents.front_door_security_policies, null) != null
  ]...)

  front_door_secrets = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.front_door_secrets : "${filekey}-${key}" => value
    }
    if try(contents.front_door_secrets, null) != null
  ]...)

  front_door_custom_domains = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.front_door_custom_domains : "${filekey}-${key}" => value
    }
    if try(contents.front_door_custom_domains, null) != null
  ]...)

  front_door_endpoints = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.front_door_endpoints : "${filekey}-${key}" => value
    }
    if try(contents.front_door_endpoints, null) != null
  ]...)

  front_door_origin_groups = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.front_door_origin_groups : "${filekey}-${key}" => value
    }
    if try(contents.front_door_origin_groups, null) != null
  ]...)

  front_door_origins = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.front_door_origins : "${filekey}-${key}" => value
    }
    if try(contents.front_door_origins, null) != null
  ]...)

  front_door_routes = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.front_door_routes : "${filekey}-${key}" => value
    }
    if try(contents.front_door_routes, null) != null
  ]...)

  front_door_rule_sets = flatten([
    for filekey, contents in local.config_data_map : [
      for key, value in contents.front_door_rule_sets : value
    ]
    if try(contents.front_door_rule_sets, null) != null
  ])

  front_door_rules = merge([
    for filekey, contents in local.config_data_map : {
      for key, value in contents.front_door_rules : "${filekey}-${key}" => value
    }
    if try(contents.front_door_rules, null) != null
  ]...)

}
