# Create a VM with a network security group

 - This example builds from [2101100-vnet-vm-nsg](https://github.com/AvtsVivek/AzureWithTerraformAdvanced/tree/main/iac/2101100-vnet-vm-nsg)

- A storage account is needed to store the terraform state files. So follow [this example to create a remote storage](https://github.com/AvtsVivek/AzureWithTerraform/tree/main/iac/1800100-provision-remote-storage)

- Azure State Storage

![Azure State Storage](./Images/PreRequisiteAzureStorage.jpg)

- Containers

![Azure State Storage](./Images/PreRequisiteAzureStorageContainers.jpg)


## Creating service connection in azure devops.

- Go to your project, and click project settings. Then select service connections.

![Project Settings](./Images/NewServiceConnection.jpg)


- Select Azure Resource Manager, then scroll down and clieck next button at the bottom.
![Select Azure Resource Manager](./Images/NewServiceConnection2.jpg)

- Select sp.
![Select Service Princpal](./Images/NewServiceConnection3.jpg)


- Give a name such as **terraform-iac-devops1**. 
![Name the s c](./Images/NewServiceConnection4.jpg)

## Build the Release pipeline

- Release Pipeline 
![Relesae pipeline](./Images/ReleasePipeline.jpg)

- Release Pipeline2 
![Relesae pipeline](./Images/ReleasePipeline2.jpg)

- Release Pipeline3 
![Relesae pipeline](./Images/ReleasePipeline3.jpg)

- Release Pipeline4 
![Relesae pipeline](./Images/ReleasePipeline4.jpg)

- Release Pipeline5 
![Relesae pipeline](./Images/ReleasePipeline5.jpg)

- Release Pipeline6 
![Relesae pipeline](./Images/ReleasePipeline6.jpg)

