
cd ../..

# cd into the directory.
cd ./iac/36001000-az-app-gateway-ssl-https-redirect-mysql

code . -r

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

terraform plan -out main.tfplan --var-file=secrets.tfvars

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

ssh -i ssh-keys/terraform-azure.pem azureuser@20.228.146.183

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

# Now telnet to my sql server. First get the my sql server name.

telnet hr-dev-mysql.mysql.database.azure.com 3306

# Now if you see something like this, then the connection is successful.

# Trying 40.71.8.203...
# Connected to hr-dev-mysql.mysql.database.azure.com.
# Escape character is '^]'.
# L
# 5.6.47.0□□□□□□□□□□□□!☻?§□□□□□□□□□□□□mysql_native_passwordConnection closed by foreign host.

# Now run the following command and when asked for password, enter the password. H@Sh1CoR3!
mysql -h hr-dev-mysql.mysql.database.azure.com -u dbadmin@hr-dev-mysql -p 

# Now you should see the following.
# mysql> 

show schemas;

use webappdb

show tables;

# If you are able to see something like the following, then the java application is successigully started and booted correctly..
# It has connected and created the database and tables.
# +--------------------+
# | Tables_in_webappdb |
# +--------------------+
# | role               |
# | user               |
# | user_role          |
# +--------------------+
# 3 rows in set (0.01 sec)

select * from user;

exit 
exit 

# Now as you are still in the bastion vm, you can run the following command to go into any of the vms in the vmss.
# First get the vm ip from vmss. Also ensure you are the tmp folder

# If not already, cd iinto the followng comand
cd /tmp 

# Now run the following command.
ssh -i terraform-azure.pem azureuser@10.1.1.4

sudo su -

cd /var/log

tail -100f cloud-init-output.log

# you should see somethng like
# Cloud-init v. 21.1-7.el8_5.3 finished at Sat, 30 Jul 2022 14:08:11 +0000. Datasource DataSourceAzure [seed=/dev/sr0].  Up 250.09 seconds
# What indicates that the vm is successfully booted, and then the java application is successfully downloaded and then started.

# Now run the following command to chcek java is running.

ps -ef | grep java

# You should see somehting like this.
# root        7292       1  0 14:08 ?        00:00:18 java -jar /home/azureuser/app3-usermgmt/usermgmt-webapp.war
# root        7610    7552  0 14:48 pts/0    00:00:00 grep --color=auto java

# Now run the following command to check the application is running.

cd /home/azureuser/app3-usermgmt

ls -lrta

# -rw-r--r--. 1 root      root      42639250 Dec  7  2021 usermgmt-webapp.war
# drwx------. 4 azureuser azureuser       95 Jul 30 14:08 ..
# drwxr-xr-x. 2 root      root            54 Jul 30 14:08 .
# -rw-r--r--. 1 root      root         19498 Jul 30 14:08 ums-start.log

more ums-start.log

# Try to connect to sql server.
# Now run the following command and when asked for password, enter the password. H@Sh1CoR3!
mysql -h hr-dev-mysql.mysql.database.azure.com -u dbadmin@hr-dev-mysql -p 

# Now you should see the following.
# mysql> 

show schemas;

use webappdb

show tables;

# If you are able to see something like the following, then the java application is successigully started and booted correctly..
# It has connected and created the database and tables.
# +--------------------+
# | Tables_in_webappdb |
# +--------------------+
# | role               |
# | user               |
# | user_role          |
# +--------------------+
# 3 rows in set (0.01 sec)

select * from user;

# Now form within the VM run the following command to list the network related stuff.

netstat -lntp

# tcp6       0      0 :::8080                 :::*                    LISTEN      7292/java



terraform state list

# To create diagram, run the following command.
code . -r 
# Ensure Azure Terraform extension is installed in VS Code
# Press F1 and Run the command AzureTerraform: Visualize. Graph.png will be generated.

# For the following command to work, you need to pass on the resource, or data source.
# This resource or data source is got from terraform state list command

# Finally, get the public ip of the auzre gateway, and add it in the hosts file.
# C:\Windows\System32\drivers\etc\hosts

# 168.61.50.167 terraformguru.com

# Now browse to the terraformguru.com and you should see the java application is running.
terraformguru.com

# Since we are using self signed certificate, we will get a warning. Ignore it. It will redirected to https.

# Now login with admin101 and password101 

# Now you can create users and verify in the database as well.

# Find out more about saml tracer and application effinity. See the video. 

exit
exit
exit

terraform state list

terraform state show azurerm_resource_group.rg

terraform show terraform.tfstate

terraform plan -destroy -out main.destroy.tfplan --var-file=secrets.tfvars

terraform show main.destroy.tfplan

terraform apply main.destroy.tfplan

Remove-Item -Recurse -Force .terraform/modules

Remove-Item -Recurse -Force .terraform

Remove-Item terraform.tfstate

Remove-Item terraform.tfstate.backup

Remove-Item main.tfplan

Remove-Item main.destroy.tfplan

Remove-Item .terraform.lock.hcl

