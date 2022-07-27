
- This example uses remote backend as againest local backend.

- Pre-requisite for this example is a remote storage.

- Follow [this example to create a remote storage](https://github.com/AvtsVivek/AzureWithTerraform/tree/main/iac/1800100-provision-remote-storage)

- This builds on from [the example 23009000-vm-auto-scale-tf-fixed](https://github.com/AvtsVivek/AzureWithTerraformAdvanced/tree/main/iac/23009000-vm-auto-scale-tf-fixed)

- Azure Linux VM Bastion host is commented out. tf8-01 to tf8-05 are all commented out. Also the following from terraform.tfvars file are also commented out.

```t
# bastion_service_subnet_name      = "AzureBastionSubnet"
# bastion_service_address_prefixes = ["10.1.101.0/27"]
```

- Add domain loable to public ip of load balancer. Required for Next demo when we implement Azure Traffic Manager 

```t
resource "azurerm_public_ip" "web_lbpublicip" {
  name                = "${local.resource_name_prefix}-lbpublicip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku = "Standard"
  tags = local.common_tags
  # "domain_name_label" required for Azure Traffic Manager
  domain_name_label = azurerm_resource_group.rg.name  
}
```

- Ensure the location is East Us 2. This is set in the terraform.tfvars file.

- Add LB Public ID related output in Web Load Balancer. This is used in `project-3-azure-traffic-manager` using `Terraform Remote State Datasource` in subsequent tut.
```t
# LB Public IP ID
output "web_lb_public_ip_address_id" {
  description = "Web Load Balancer Public Address Resource ID"
  value = azurerm_public_ip.web_lbpublicip.id
}
```

- If we want to make this simple, we can use the default auto scaling profile in vmss. So accordingly we can comment out tf7-07, tf7-08 and enable just tf7-06.



