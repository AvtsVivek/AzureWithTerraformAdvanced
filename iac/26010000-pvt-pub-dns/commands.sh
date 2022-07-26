
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
# Ensure that this is resolved to the static IP address of the private app load balancer.
# We have hard coded to 10.1.11.241
nslookup viveklearn.xyz
nslookup app1.viveklearn.xyz
nslookup www.viveklearn.xyz

# Now do the curl command.
# You should get the following
# Welcome to Step By Step Tutes - AppVM App1 - VM Hostname: hr-dev-app-vmss000003
curl applb.viveklearn.xyz

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

# Now from within the bastion vm, cd into tmp
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

# Now we want to connect to web vm ss instance. 
# Go to the web vm ss, and go to instances. Ensure they are running.
# Click on any of them, overview, then pick the private ip address.

ssh -i ./terraform-azure.pem azureuser@10.1.1.4 

hostname

sudo su -

cd /etc/httpd/conf.d

ls -lrta

cat app1.conf
# Now verify the following.
# The following is commented out.
# ProxyPass / http://10.1.11.241/
# ProxyPassReverse / http://10.1.11.241/

# And the following should be enabled(uncommented).
# ProxyPass / http://applb.stepbystep.com/
# ProxyPassReverse / http://applb.stepbystep.com/ 

# Finally check for ns lookup
nslookup applb.stepbystep.com

tail -100f cloud-init-output.log

cd /var/www/html

ls -lrta

cat index.html

cd appvm

ls -lrta

cat hostname.html

exit
exit

curl http://10.1.11.4 # Must be the public ip address of the app vmss instance.
curl http://10.1.11.7

# Now from inside of the bastion host, to the app vmss instance, via the load balancer.
# First get the ip address of the internal load balancer. This is a static one and is hardcoded to 10.1.11.241

curl http://10.1.11.241


# Now from the bastion host, to the app vmss (not the web vmss)
# Now we want to connect to web vm ss instance. 
# Go to the web vm ss, and go to instances. Ensure they are running.
# Click on any of them, overview, then pick the private ip address.

ssh -i ./terraform-azure.pem azureuser@10.1.1.5

hostname

sudo su -

cd /var/log

ls -lrta

tail -100f cloud-init-output.log

cd /var/www/html

ls -lrta

cat index.html

cd webvm

ls -lrta

cd /etc/httpd/conf.d

ls -lrta

cat app1.conf

# From the web servier(Web Vmss) to the app server(App Vmss).
# WE aer able to do this because of root proxy.
# We just saw the file conf.d: cat app1.conf. Find the following in conf.d file.
# ProxyPass /webvm !

curl http://10.1.11.4 # Must be the public ip address of the app vmss instance.
curl http://10.1.11.7

# But if we try, this is not routed to app vmss instance.
# This is handled by the webvm it self.
# This is again because of the conf.d file.

curl http://10.1.11.7/webvm/index.html

exit
exit

curl http://10.1.11.7

# Finally, we want to connect to the web vmss instance from the public ip address of the load balancer.
# First go the web load balancer, and get the public ip address.
# 52.234.143.205 (hr-dev-lbpublicip)
# This gets the data fromo the app vm ss instance.
curl http://52.234.143.205

# But if you do the follwing, you get the response from web vm and not app vm.
# This is again because of # ProxyPass /webvm ! in the conf.d file.
curl http://52.234.143.205/webvm

# Try the same with browser as well.
http://52.234.143.205/webvm
http://52.234.143.205/appvm
http://52.234.143.205

# Also try the following in the browser
http://52.234.143.205/appvm/metadata.html
http://52.234.143.205/webvm/metadata.html



exit 
exit 


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

