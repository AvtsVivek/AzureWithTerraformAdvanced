# Linux VM Input Variables Placeholder file.

variable "web_linuxvm_instance_count" {
  description = "Web Linux VM Instance Count"
  type        = number
  default     = 1
}

# variable "vm-count" {
#   description = "Number of VMs to create"
#   type        = set(string)
#   default     = ["one", "two", "three"]
# }

# locals {
#   vm_count = [
#     "one",
#     "two",
#     "three",
#   ]


# vm_count_port_maps = flatten([
#   for vm in local.vm_count : [
#     for port_map in local.web_vmnic_inbound_ports_map : {
#       port     = port_map.port
#       priority = port_map.priority
#       vm       = vm
#     }
#   ]
# ])

#}

# output "print_the_local_schemas" {
#   value = [for schema in local.vm_count : schema]
# }

# output "print_the_local_schema_privileges" {
#   value = [for vm_port_map in local.vm_count_port_maps : vm_port_map]
# }