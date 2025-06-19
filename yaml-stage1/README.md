# Yaml Stage 1

Simple yaml setup to demonstrate the objects to be read in and decoded.

Add any object types to the yaml files or add additional ones.

In the `locals.tf` file the `fileset` command is reading in any yaml files from the config directory.

The `config_data_map` loop is iterating over the files found and using the filename as the key to the map of file content and using `yamldecode` to parse the file data into terraform objects.

The key is `<directory>-<subdirectory>-filename`. So if there isn't a directory the key is just `filename`.

So for the yaml files in this stage the keys will be:

- lists
- object
- mapdir-maps

Within these files are the layout of the objects:

- lists
  - fruits - is a simple list
  - fruit-objects - is a list of objects
- object
  - contains a simple object
- mapdir-maps
  - string - is a simple map of strings
  - object - is a map of objects
  - nested - is a map of objects with a nested map
