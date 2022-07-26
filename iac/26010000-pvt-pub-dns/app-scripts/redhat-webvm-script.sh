#!/bin/sh
#sudo yum update -y
# httpd is the web server, apachi server.
sudo yum install -y httpd

# The following command will enable the apache server, whenever the system is rebooted.
sudo systemctl enable httpd

# The following command will start the apache server, whenever the system is rebooted.
sudo systemctl start httpd  

# In these redhat vms, there is a default firewalld running, so we want to stop it.
sudo systemctl stop firewalld

# In these redhat vms, there is a default firewalld running, so we want to stop it and then disalbe it.
sudo systemctl disable firewalld

# Full permissions to /var
sudo chmod -R 777 /var/www/html 

# The host name will be made available in the index page by the following command.
sudo echo "Welcome to Step By Step Tutes - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html

sudo mkdir /var/www/html/webvm

sudo echo "Welcome to Step By Step Tutes - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/webvm/hostname.html

# When we are using applictions gateway load balancer, when we are doing http prob, we can use the following status.html file.
sudo echo "Welcome to Step By Step Tutes - WebVM App1 - App Status Page" > /var/www/html/webvm/status.html

# Some fancy html stuff to make the index.html file look nice.
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/webvm/index.html

# Not clear why 169.254.169.254 is hardcoded. Not clear about this.
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/webvm/metadata.html

# Need to find more about the following.
sudo sh -c 'echo -e "[azure-cli] 
name=Azure CLI 
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
sudo yum install -y azure-cli
sudo cd /etc/httpd/conf.d
sudo az storage blob download -c ${azurerm_storage_container.httpd_files_container.name} -f /etc/httpd/conf.d/app1.conf -n app1.conf --account-name ${azurerm_storage_account.storage_account.name} --account-key ${azurerm_storage_account.storage_account.primary_access_key}
sudo systemctl reload httpd
/usr/sbin/setsebool -P httpd_can_network_connect 1 