## SSL Certificate, HTTP to HTTPS redirect and Error Pages


 - This example builds from [30001000-az-app-gateway-terraform-basic](https://github.com/AvtsVivek/AzureWithTerraformAdvanced/tree/main/iac/30001000-az-app-gateway-terraform-basic)



- Verification 

First wait for 20 minutes

Then add the followng in the hosts file
C:\Windows\System32\drivers\etc

20.127.126.139 terraformguru.com

- Verify 1
![Verify 1](./Images/Verify1.jpg)

- Verify 2
![Verify 2](./Images/Verify2.jpg)

- Verify 3
![Verify 2](./Images/Verify3.jpg)

Now open a browser and browse to the following URLs
http://terraformguru.com/

It will be redirected to (https)
https://terraformguru.com/

Finally shut down the vms and then access the same pages again.
You should get the error pages.

- Verify 4
![Verify 4](./Images/Verify4.jpg)

- Verify 5
![Verify 5](./Images/Verify5.jpg)

- Verify 6.  This happened only when the vms were shut down. Also you have to wait for 10 minutes
![Verify 6](./Images/Verify6.jpg)

