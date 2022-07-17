
cd ../..
# cd into the directory.
cd ./iac/23003000-std-load-bal-nat-multiple-vms

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

ssh -i ssh-keys/terraform-azure.pem azureuser@20.231.59.51

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

# Now ssh into the other linux vm(not the bastion, we are already on the bastion).
# First Note the IP address. 10.1.1.4. Go to the portal and find the vm. Then look at the IP address.
# Run the following with the ip address.
ssh -i terraform-azure.pem azureuser@10.1.1.4

hostname

sudo su -

# Verify the html folder where we have the app1 folder and index.html
cd /var/www/html

ls -lrta

cd ./app1

# This should have 4 files.

# -rw-r--r--. 1 root root   72 Jul 15 07:54 hostname.html
# -rw-r--r--. 1 root root   56 Jul 15 07:54 status.html
# -rw-r--r--. 1 root root  193 Jul 15 07:55 index.html
# drwxr-xr-x. 2 root root   85 Jul 15 07:55 .
# -rw-r--r--. 1 root root 2678 Jul 15 07:55 metadata.html

ls -lrta

cat index.html
cat hostname.html
cat status.html
cat metadata.html

curl -I http://localhost/app1/index.html
curl -I http://localhost/index.html
curl http://10.1.1.4

# You can try the following as well, to veryfy the connection in detail

# check if the web server is running.
ps -ef | grep httpd

# look for port 80
netstat -lntp

cd /var/www/html

cd ./app1

ls -lrta

Now browse the vm. 

# use ip address or dns name.

# This completes the connection from Baston host linux VM to Web VM verification

# Now verify the Azure Bastion Service connection to Web VM

# See the mageConnect-To-Web-Vm-Via-Bastion.jpg in the read me file
# Once connected, you can vrify the connection from the bastion host to the web vm in the same way as above.

exit
exit
exit
exit


# Get the ip address of the load balancer.
# Run the following command from bash command and NOT from powershell.
# If you get Permission denied (publickey,gssapi-keyex,gssapi-with-mic) error,
# then you are not in the right directory.

ssh -i ./ssh-keys/terraform-azure.pem -p 1022 azureuser@20.228.204.103

sudo su -

cd /var/www/html/

ls -lrt

cd app1

ls -lrt

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

