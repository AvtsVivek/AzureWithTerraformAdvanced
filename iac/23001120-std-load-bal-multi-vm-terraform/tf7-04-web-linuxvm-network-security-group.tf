
resource "azurerm_network_security_group" "web_vmnic_nsg" {
  count               = var.web_linuxvm_instance_count
  name                = "${azurerm_network_interface.web_linuxvm_nic[count.index].name}-nsg-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

locals {
  web_vmnic_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  }

}

module "azurerm_network_security_rule_inbound" {
  count                          = var.web_linuxvm_instance_count
  source                         = "./modules/nsg-module" # Mandatory
  web_vmnic_inbound_ports_map    = local.web_vmnic_inbound_ports_map
  resource_group_name            = azurerm_resource_group.rg.name
  web_linuxvm_instance_count_var = count.index
  web_vmnic_nsg_name             = azurerm_network_security_group.web_vmnic_nsg[count.index].name
}

# Resource-3: Associate NSG and Linux VM NIC
resource "azurerm_network_interface_security_group_association" "web_vmnic_nsg_associate" {
  count                     = var.web_linuxvm_instance_count
  depends_on                = [module.azurerm_network_security_rule_inbound]
  network_interface_id      = element(azurerm_network_interface.web_linuxvm_nic[*].id, count.index)
  network_security_group_id = element(azurerm_network_security_group.web_vmnic_nsg[*].id, count.index)
  # [count.index] will also work here.
}
