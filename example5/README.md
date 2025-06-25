# Yaml Example 5

This shows a more realistic example with the use of configuration for apps using a shared Azure Front Door.

This exerpt is a sample of what can be used to pass values to the [AVM module for AFD](https://github.com/Azure/terraform-azurerm-avm-res-cdn-profile).

``` bash
terraform plan -var-file="environments/nonprod/nonprod.terraform.tfvars"
```

The folder structure for environments represents a single AFD per env. So a nonprod shared AFD. Within this is the shared configuration such as a supplied certificate. Then within each sub folder is the configuration for a single application to use AFD. It is flexible in that the elements can be exluded or added with use of the try function to test for missing optional elements. If a new application is required then another folder with configuration can be added to the nonprod folder.

The folder structure and file names are arbitary and can be specified in any pattern.
