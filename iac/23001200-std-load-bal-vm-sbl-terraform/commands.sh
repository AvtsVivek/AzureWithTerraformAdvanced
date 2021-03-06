
# cd into the directory.
cd ./iac/23002000-std-load-bal-terraform

cd ../..

terraform fmt

terraform init

terraform validate

terraform plan -out main.tfplan

terraform show main.tfplan

terraform apply main.tfplan

# Once successfully applied, Review the resources.
# Download the topology diagram. Go to the created vnet and then diagram.
# Also look at subnets and corresponding security groups.
# You can also download load balancer topology diagram. In the portal 
# you can see the topology diagram: Go to loadbalancer -> Monitoring and then click on isights. 

# Get the ip address of the load balancer.
# Run the following command from bash command and NOT from powershell.
# If you get Permission denied (publickey,gssapi-keyex,gssapi-with-mic) error,
# then you are not in the right directory.

# NAT Rules are NOT added, so the following will not work.
ssh -i ./ssh-keys/slb-demo1-ssk-keys.pem -p 1022 azureuser@20.124.60.147

terraform state list

# To create diagram, run the following command.
code . -r 
# Ensure Azure Terraform extension is installed in VS Code
# Press F1 and Run the command AzureTerraform: Visualize. Graph.png will be generated.

# For the following command to work, you need to pass on the resource, or data source.
# This resource or data source is got from terraform state list command
terraform state show 

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


