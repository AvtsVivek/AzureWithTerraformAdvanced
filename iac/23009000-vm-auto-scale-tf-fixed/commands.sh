
cd ../..

# cd into the directory.
cd ./iac/23009000-vm-auto-scale-tf-fixed

cd ssh-keys

# Run the following in bash prompt. In pwershell it will not work.
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@myserver" \
    -f terraform-azure.pem 

Get-ChildItem . 

Get-ChildItem ./ssh-keys

cd ssh-keys

Rename-Item ./terraform-azure.pem.pub ./terraform-azure.pub

cd ..

terraform fmt

terraform init

terraform validate

terraform plan -out main.tfplan

terraform show main.tfplan

terraform apply main.tfplan

# Once successfully applied, Review the resources.
# First Baston host linux VM.
# Download the topology diagram. Go to the created vnet and then diagram.
# Also look at subnets and corresponding security groups.

# Connect to the bastion VM(hr-dev-bastion-linuxvm). Ensure the vm is running.
# Note the IP address of the bastion vm.
# Run the following with the ip address.
# Run the following in bash prompt, not in the powershell.
# If you get the following permission denined, 
# azureuser@40.114.14.64: Permission denied (publickey,gssapi-keyex,gssapi-with-mic)
# then you are not in the correct directory.

ssh -i ssh-keys/terraform-azure.pem azureuser@20.124.27.249

# Now that you are in the VM, you can run the following commands.
hostname

# Switch to the root user.
sudo su -

cd /tmp

# Look for the file terraform-azure.pem. It should have readonly permissions.
# -r--------.  1 azureuser azureuser 3247 Jul 15 07:49 terraform-azure.pem
# Its given only read permissions. Thats because of the following. tf8-03-move-ssh-key-to-bastion-host.tf

## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
#   provisioner "remote-exec" {
#     inline = [
#       "sudo chmod 400 /tmp/terraform-azure.pem"
#     ]
#   }

ls -lrta



# Verify the html folder where we have the app1 folder and index.html
cd /var/www/html

ls -lrta

# This should have 1 file.
cat index.html

# Apachi bench tool is installed. Verify it.
which ab

# Run the Load Test using Apache Bench.
# Get the ip address of the load balancer. Note this is different from the bastion host.
# 20.119.70.164
# Reference 
# https://httpd.apache.org/docs/2.4/programs/ab.html

ab --help

# -k              Use HTTP KeepAlive feature
# -n requests     Number of requests to perform
# -c concurrency  Number of multiple requests to make at a time
# -t timelimit    Seconds to max. to spend on benchmarking
#                 This implies -n 50000

ab -k -t 1200 -n 9050000 -c 100 http://<Web-LB-Public-IP>/index.html
ab -k -t 1200 -n 9050000 -c 100 http://20.119.70.164/index.html

exit 
exit 


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

