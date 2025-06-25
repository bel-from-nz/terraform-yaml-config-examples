environment         = "tst"
short_location_code = "ae"
location            = "australiaeast"

app_list = {
  a1 = {
    name_part      = "app1"
    address_spaces = ["10.21.0.0/24"]
    subnets = {
      s1 = {
        name_part                 = "app"
        address_spaces            = ["10.21.0.0/29"]
        delegation_enabled        = true
        delegations               = { web = { name = "Microsoft.Web.serverFarms", service = "Microsoft.Web/serverFarms" } }
        service_endpoints_enabled = false
        service_endpoints         = []
      }
    }
  }
  a2 = {
    name_part      = "app2"
    address_spaces = ["10.22.0.0/24"]
    subnets = {
      s1 = {
        name_part                 = "app"
        address_spaces            = ["10.22.0.0/29"]
        delegation_enabled        = false
        delegations               = {}
        service_endpoints_enabled = true
        service_endpoints         = ["Microsoft.Storage", "Microsoft.KeyVault"]
      }
    }
  }
}
