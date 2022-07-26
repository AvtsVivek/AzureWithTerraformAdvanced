resource "azurerm_dns_zone" "example-public" {
  name                = "viveklearn.xyz"
  resource_group_name = azurerm_resource_group.rg.name
}
