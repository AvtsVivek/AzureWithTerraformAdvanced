
# cd into the directory.
cd ./iac/2101100-vnet-vm-nsg

cd ../..

mkdir ssh-keys

cd ssh-keys

# Run the following in bash prompt. In powershell it will not work.
# If prompted for a password, just press enter to give an empty password.
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

# terraform show main.tfplan

terraform apply main.tfplan

# Once successfully applied, Review the resources.
# Download the topology diagram. Go to the created vnet and then diagram.
# Also look at subnets and corresponding security groups.

# Connect to the VM. Ensure the vm is running.
# Note the IP address, either from the output of the apply command or go to the porta.azure.com
# Run the following with the ip address.
# Run the following in bash prompt, NOT from POWERSHELL
# If you get the following permission denined, 
# azureuser@40.114.14.64: Permission denied (publickey,gssapi-keyex,gssapi-with-mic)
# then you are not in the correct directory.

ssh -i ssh-keys/terraform-azure.pem azureuser@4.236.141.33

# Now that you are in the VM, you can run the following commands.
hostname

# Switch to the root user.
sudo su -

cd /var/log

# Now look for cloud-init-output.log file.

# use the tail command to see the last 100 lines.
tail -100f cloud-init-output.log
# Review what all happened as the vm was booting.

ls -lrta

# Press Ctrl+C to comeout.

# check if the web server is running.
ps -ef | grep httpd

# look for port 80
netstat -lntp

cd /var/www/html

cd ./app1

ls -lrta

Now browse the vm. 

# use ip address or dns name. You can get it from the porta. 

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/app1/metadata.html

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/app1/index.html

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/app1/status.html

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/app1/hostname.html

# If you get Permission denied, from the below command, then run the 
# sudo su - 
# first and then run the below command.
cd /var/log/httpd/

tail -100f access_log

# Browse any of the following and then see the logs. First ensure correct dns name in the following commands.

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/app1/metadata.html

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/app1/index.html

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/app1/status.html

http://app1-vm-dsdumc.eastus.cloudapp.azure.com/app1/hostname.html

exit

exit

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
