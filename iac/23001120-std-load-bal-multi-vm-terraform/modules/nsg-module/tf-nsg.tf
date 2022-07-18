
variable "web_vmnic_inbound_ports_map" {
  type = map(string)
}

#   web_vmnic_inbound_ports_map = {
#     "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
#     "110" : "443",
#     "120" : "22"
#   }

resource "azurerm_network_security_rule" "web_vmnic_nsg_rule_inbound" {
  # count                       = var.web_linuxvm_instance_count
  for_each                    = var.web_vmnic_inbound_ports_map
  name                        = "Rule-Port-${each.key}-${each.value}-${var.web_linuxvm_instance_count_var}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  # network_security_group_name = element(azurerm_network_security_group.web_vmnic_nsg[*].name, count.index)
  # network_security_group_name = element(var.web_vmnic_nsg_names, var.web_linuxvm_instance_count_var)
  network_security_group_name = var.web_vmnic_nsg_name
}

# variable "web_vmnic_nsg_names" {
#   description = "value of web_vmnic_nsg_names"
#   type = list(string) 
# }

variable "web_vmnic_nsg_name" {
  description = "value of web_vmnic_nsg_name"
  type = string 
}

variable "web_linuxvm_instance_count_var" {
  description = "value of web_linuxvm_instance_count"
  type        = number
}

variable "resource_group_name" {
  description = "value of resource_group_name in which the security rule is to be created"
  type        = string
}