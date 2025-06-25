locals {

  yaml_data_dir = "${path.root}/config"

  /*
    Fileset is based on DoubleStar : https://github.com/bmatcuk/doublestar

    This will find all yaml files in the yaml_data_dir and any subfolders
  */
  yaml_files = fileset(local.yaml_data_dir, "**/*.yaml")

  config_data_map = {
    for f in local.yaml_files :
    replace(split(".", f)[0], "/", "-") => yamldecode(file("${local.yaml_data_dir}/${f}"))
  }

}
