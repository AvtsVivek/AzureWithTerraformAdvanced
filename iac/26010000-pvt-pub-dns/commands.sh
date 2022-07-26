
cd ../..

# cd into the directory.
cd ./iac/26010000-pvt-pub-dns

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

ssh -i ssh-keys/terraform-azure.pem azureuser@20.228.133.250 

# Now that you are in the VM, you can run the following commands.
hostname

# Switch to the root user.
sudo su -

# Now do ns lookup.
# Get the dns zone name, and then a record name.
# Ensure that this is resolved to the static IP address of the public ip of the web load balancer.
# 52.168.33.218 (hr-dev-lbpublicip)
nslookup viveklearn.xyz
nslookup app1.viveklearn.xyz
nslookup www.viveklearn.xyz

# Now do the curl command.
# You should get the following
# Welcome to Step By Step Tutes - AppVM App1 - VM Hostname: hr-dev-app-vmss000003
curl app1.viveklearn.xyz
curl www.viveklearn.xyz
curl viveklearn.xyz

# Finally, we want to connect to the web vmss instance from the public ip address of the load balancer.
# First go the web load balancer, and get the public ip address.
# 20.115.8.8 (hr-dev-lbpublicip)
# This gets the data fromo the app vm ss instance.
# Not the following
# Welcome to Step By Step Tutes - WebVM App1 - VM Hostname: hr-dev-web-vmss000000
# The following is what should. It should be App and not Web.
# It takes some time. 5-10 minutes.
# Welcome to Step By Step Tutes - AppVM App1 - VM Hostname: hr-dev-app-vmss000001
curl http://20.228.133.185
# Check the above from browser as well. Copy the ip address and past in browser

# Access App VM Pages (index.html page will be served from AppVM )
http://viveklearn.xyz
http://www.viveklearn.xyz
http://app1.viveklearn.xyz
http://viveklearn.xyz/appvm/index.html
http://www.viveklearn.xyz/appvm/index.html
http://app1.viveklearn.xyz/appvm/index.html

terraform state list

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

