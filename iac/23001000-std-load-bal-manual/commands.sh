
# cd into the directory.
cd ./iac/23001000-std-load-bal-manual

cd ../..


# Download the ssh key from the azure portal. 
# In the resource group, there should be a ssh-key resource 
# The private key must downloaded during the creation time. 
# Later on, the private key can not be downloaded from the portal.
# Get the ip address of the load balancer.
# Run the following command from bash command and NOT from powershell.
# If you get Permission denied (publickey,gssapi-keyex,gssapi-with-mic) error,
# then you are not in the right directory.

# Use either one of the following.
ssh -i ./ssh-keys/slb-demo1-ssk-keys.pem -p 1022 azureuser@20.124.60.147

ssh -i ./ssh-keys/slb-demo1-ssk-keys.pem -p 2022 azureuser@20.124.60.147


# Once you logged in, you can run the following commands.
sudo su -

hostname

# Verify the html folder where we have the app1 folder and index.html
cd /var/www/html

ls -lrta

cat index.html

cd ./app1

ls -lrta

cat hostname.html

cat status.html

cat hostname.html

cat index.html

exit

exit


