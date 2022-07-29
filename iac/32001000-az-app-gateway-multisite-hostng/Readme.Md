## Azure Gateway

 - This example builds from [29001000-az-app-gateway-portal](https://github.com/AvtsVivek/AzureWithTerraformAdvanced/tree/main/iac/29001000-az-app-gateway-portal)

- Difference [between App gate way and load balancer](https://blog.siliconvalve.com/2017/04/04/when-to-use-azure-load-balancer-or-application-gateway/#:~:text=The%20first%20real%20difference%20between,(including%20HTTPS%20and%20WebSockets))


- GateWay Topoliogy
![Gateway Topology](./Images/GateWayTopology.svg)

- Vnet Topoliogy
![Vnet Topology](./Images/VnetTopology.svg)

- Verification 1

First wait for 20 minutes

Then add the followng in the hosts file
C:\Windows\System32\drivers\etc

13.92.125.152 app1.terraformguru.com
13.92.125.152 app2.terraformguru.com

- Verify 1
![Verify 1](./Images/Verify1.jpg)

- Verify 2
![Verify 2](./Images/Verify2.jpg)

Now browse to the following URLs

http://app1.terraformguru.com/

http://app2.terraformguru.com/

You can also try the following

http://app1.terraformguru.com/app1/index.html

http://app2.terraformguru.com/app2/index.html

If you change to app2/index, it would not work. For example the following will not work.

http://app1.terraformguru.com/app2/index.html

