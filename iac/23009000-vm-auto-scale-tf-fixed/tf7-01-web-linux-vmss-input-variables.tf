# Linux VM Input Variables Placeholder file.
variable "web_vmss_nsg_inbound_ports" {
  description = "Web VMSS NSG Inbound Ports"

  type = list(string)

  # The following can also be used instead of the above. 
  #type        = set(string)

  default = [22, 80, 443]
}

