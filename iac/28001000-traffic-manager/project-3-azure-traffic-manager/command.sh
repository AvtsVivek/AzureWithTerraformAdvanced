
cd ../..

# cd into the directory.
cd ./iac/28001000-traffic-manager/project-3-azure-traffic-manager

terraform fmt

terraform init

terraform validate

terraform plan -out main.tfplan

terraform show main.tfplan

terraform apply main.tfplan

terraform state list

# To create diagram, run the following command.
code . -r 
# Ensure Azure Terraform extension is installed in VS Code
# Press F1 and Run the command AzureTerraform: Visualize. Graph.png will be generated.

# For the following command to work, you need to pass on the resource, or data source.
# This resource or data source is got from terraform state list command
terraform state list

terraform state show azurerm_resource_group.rg

terraform show terraform.tfstate

terraform plan -destroy -out main.destroy.tfplan

terraform show main.destroy.tfplan

terraform apply main.destroy.tfplan

Remove-Item -Recurse -Force .terraform/modules

Remove-Item -Recurse -Force .terraform

Remove-Item terraform.tfstate

Remove-Item terraform.tfstate.backup

Remove-Item main.tfplan

Remove-Item main.destroy.tfplan

Remove-Item .terraform.lock.hcl

