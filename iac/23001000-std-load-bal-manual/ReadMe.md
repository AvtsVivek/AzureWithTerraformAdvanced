# Standard Load Balancer with two Vms

- Create Resource Group with name slb-demo1-rg.

- Create a Vnet with name slb-demo1-vnet.

- Create a Subnet with name slb-demo1-subnet.

- Create 2 VMs with name slb-demo1-vm1 and slb-demo1-vm2.

![Create a VM](./Images/CreateVm1Basics.jpg)

- Create SSH Keys as well. Create Key Pair with name slb-demo1-ssh-key-pair.

![Create SSh keys](./Images/CreateVm1BasicsSShKeys.jpg)

- For Disk size, just take the defaults.

- Networking

![Networking options](./Images/CreateVm1Networking.jpg)

- 4 kinds of load balancers. They are classified into two groups. The bottom two comes under layer 4 load balancer. Tcp Udp load balancers.

![4 Kinds of load balancers.](./Images/KindsOfLoadBalancer.jpg)

- Create Standard Load Balancer.

![Standard Load Balancer Options](./Images/LoadBalancerBasic.jpg)

- Frontend IP Configuration

![Frontend IP Configuration](./Images/LoadBalancerBasicFrontEndIp.jpg)

- Backend Pool

![Backend Pool](./Images/LoadBalancerBackEndPool.jpg)

- Backend Pool options

![Backend Pool options](./Images/LoadBalancerBackEndPool2.jpg)

- Now Health Probes

![Health Probs](./Images/LoadBalancerHealthProbe1.jpg)

- Add Health Probes

![Add Health Probs](./Images/LoadBalancerHealthProbeAdd.jpg)

- Add Load Balancer Rules

![Add Load Balancer Rules](./Images/LoadBalancerLbRuleAdd.jpg)

- Load Balancer Rules Options

![Load Balancer Rules](./Images/LoadBalancerLbRule.jpg)

- NAT Rules 

![Add NAT Rules](./Images/LoadBalancerNatAdd.jpg)

- NAT Rules 

![Add NAT Rules](./Images/LoadBalancerNatAdd2.jpg)

- NAT Rules 

![Add NAT Rules](./Images/LoadBalancerNatAdd3.jpg)


7. slb-demo1-slb-fip
8. slb-demo1-slb-fip-pip
9. slb-demo1-slb-backend-pool
10. slb-demo1-slb-health-probe
11. slb-demo1-slb-load-balancing-rule
12. slb-demo1-slb-1022-nat1, slb-demo1-slb-2022-nat2









