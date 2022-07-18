
# resource "azurerm_resource_group" "myrg" {
#   for_each = var.environment
#   name     = "myrg-${each.key}-${var.resoure_group_name_suffix}"
#   location = var.resoure_group_location
# }



# Resource-3 (Optional): Create Network Security Group and Associate to Linux VM Network Interface
# Resource-1: Create Network Security Group (NSG)
resource "azurerm_network_security_group" "web_vmnic_nsg" {
  count               = var.web_linuxvm_instance_count
  name                = "${azurerm_network_interface.web_linuxvm_nic[count.index].name}-nsg-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource-2: Create NSG Rules
## Locals Block for Security Rules
locals {
  web_vmnic_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  }

  # web_vmnic_inbound_ports_map = {
  #   object1 = {
  #     priority = 100,
  #     port     = 80
  #   },
  #   object2 = {
  #     priority = 110,
  #     port     = 443
  #   },
  #   object3 = {
  #     priority = 120,
  #     port     = 22
  #   },
  # }


}

## NSG Inbound Rule for WebTier Subnets


# resource "azurerm_network_security_rule" "web_vmnic_nsg_rule_inbound" {
#   count                       = var.web_linuxvm_instance_count
#   for_each                    = local.web_vmnic_inbound_ports_map
#   name                        = "Rule-Port-${each.value}"
#   priority                    = each.key
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = each.value
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.rg.name
#   network_security_group_name = element(azurerm_network_security_group.web_vmnic_nsg[*].name, count.index)
# }

module "azurerm_network_security_rule_inbound" {
  count  = var.web_linuxvm_instance_count
  source = "./modules/nsg-module" # Mandatory
  #resource_group_location  = "eastus"
  #resource_group_name      = "myrg1"
  web_vmnic_inbound_ports_map    = local.web_vmnic_inbound_ports_map
  resource_group_name            = azurerm_resource_group.rg.name
  web_linuxvm_instance_count_var = count.index
  # web_vmnic_nsg_names            = azurerm_network_security_group.web_vmnic_nsg
  web_vmnic_nsg_name = azurerm_network_security_group.web_vmnic_nsg[count.index].name
}

# variable "azurerm_network_security_group_web_vmnic_nsg_names" {
#   description = "value of web_vmnic_nsg_names"
#   type = list(string) 
#   default = azurerm_network_security_group.web_vmnic_nsg[*]
# }

# variable "web_vmnic_nsg_names" {
#   description = "value of web_vmnic_nsg_names"
#   type = list(string) 
#   # default = azurerm_network_security_group.web_vmnic_nsg[*]
# }


# Resource-3: Associate NSG and Linux VM NIC
resource "azurerm_network_interface_security_group_association" "web_vmnic_nsg_associate" {
  count      = var.web_linuxvm_instance_count
  depends_on = [module.azurerm_network_security_rule_inbound]
  # network_interface_id      = azurerm_network_interface.web_linuxvm_nic.id
  network_interface_id      = element(azurerm_network_interface.web_linuxvm_nic[*].id, count.index)
  network_security_group_id = element(azurerm_network_security_group.web_vmnic_nsg[*].id, count.index)
  # [count.index] will also work here.
}
