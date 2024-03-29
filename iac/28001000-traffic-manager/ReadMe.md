## Introducing Azure Traffic Manager

- This example uses remote backend as againest local backend.

- Pre-requisite for this example is a remote storage.


- Follow [this example to create a remote storage](https://github.com/AvtsVivek/AzureWithTerraform/tree/main/iac/1800100-provision-remote-storage)

![Azure State Storage](./Images/PreRequisiteAzureStorage.jpg)

- Containers

![Azure State Storage](./Images/PreRequisiteAzureStorageContainers.jpg)



- This builds on from [the example 27001000-remote-storage](https://github.com/AvtsVivek/AzureWithTerraformAdvanced/tree/main/iac/27001000-remote-storage)


- Changed the sku in azurerm_linux_virtual_machine_scale_set from Standard_DS1_v2 to Standard_D2s_v5. This is because thats the one working for both eastus2 and westus2

- There seems to be a bug. The traffic manager is directing to only one region, either eastus2 or westus2. Not sure whats the problem. Or I may be totally wrong.

- This is what we are going to build.
![The layout](./Images/TrafficeManager1.jpg)

- And the layout will be as follows.
![The layout](./Images/TrafficeManagerLayout.jpg)

- Topology
![Topology](./Images/topology.svg)

- Traffice Manager
![Traffice Manager](./Images/TrafficeManagerAzureResource.jpg)

- Traffice Manager Endpoint
![Traffice Manager Endpoints](./Images/TrafficeManagerAzureResourceEndPoints.jpg)

