## Azure Gateway

 - This example builds from [23009000-vm-auto-scale-tf-fixed](https://github.com/AvtsVivek/AzureWithTerraformAdvanced/tree/main/iac/23009000-vm-auto-scale-tf-fixed)

- Adds an additional subnet(for azure gateway) to the existing VNet.

![Topology](./Images/topology.svg)

# Now creating Application Gateway from portal.

- Azure App GateWay
![Azure App Gateway](./Images/AzureAppGateWay1.jpg)

- Azure App GateWay Components
![Azure App Gateway Components](./Images/AzureAppGateWay2.jpg)


![Create App Gateway](./Images/CreateApplicationGateWay.jpg)

2
![Create App Gateway](./Images/CreateApplicationGateWay2.jpg)

3
![Create App Gateway](./Images/CreateApplicationGateWay3.jpg)

4
![Create App Gateway](./Images/CreateApplicationGateWay4.jpg)

5
![Create App Gateway](./Images/CreateApplicationGateWay5.jpg)

6
![Create App Gateway](./Images/CreateApplicationGateWay6.jpg)

7
![Create App Gateway](./Images/CreateApplicationGateWay7.jpg)

8
![Create App Gateway](./Images/CreateApplicationGateWay8.jpg)

9
![Create App Gateway](./Images/CreateApplicationGateWay9.jpg)

10
![Create App Gateway](./Images/CreateApplicationGateWay10.jpg)

Http Probe

![Http Probe](./Images/Http-probe.jpg)

Http Probe test

![Http Probe test](./Images/Http-probe2.jpg)

Monitoring

![Monitorng](./Images/MonitorngBackendHealth.jpg)

Ag Topology

![Ag Topology](./Images/AgTopology.svg)

 - Get the public IP address of the App Gateway.

http://23.96.9.202/app1/index.html


http://23.96.9.202/app1/hostname.html


http://23.96.9.202/app1/status.html


http://23.96.9.202/app1/meatadata.html


## Deleting the App Gateway

- Delete the public IP address of the App Gateway.

- Disassociate the backend pools from the App Gateway. Ensure the targets are 0

![Delete Backend pool](./Images/DeleteBackendPool.jpg)

Ensure targests are zero

![Ensure targests are 0](./Images/DeleteBackendPool2.jpg)

